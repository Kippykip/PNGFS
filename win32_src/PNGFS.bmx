Include "CRC16.bmx" 'CRC16 calculation thingy

'To Pixmap functions
Type ToPixmapWorkspace
	Global ErrorStatus:String
	Global Banner:TPixmap[3]
	Field File:TStream
	Field Pixmap:TPixmap
	Field PosX:Int, PosY:Int
	Field isDithered:Byte
	'Some buffer variables
	Field RGBABuffer:Int[] 'i guess this needs to be set as ARGB later on
	Field RGBAPos:Byte = 0
	Field DitheredSkipPixel:Byte
	Field PageCount:Short
	
	'Converts a set of bytes into an int via ARGB
	Method BufAddByte(tmp_byte:Byte)
		RGBABuffer[RGBAPos] = tmp_byte	
		RGBAPos:+1
		'End of integar?
		If(RGBAPos >= 4)
			RGBABuffer[0] = RGBABuffer[0] Shl 16 'Red
			RGBABuffer[1] = RGBABuffer[1] Shl 8 'Green
			RGBABuffer[2] = RGBABuffer[2] 'Blue
			RGBABuffer[3] = RGBABuffer[3] Shl 24 'Alpha
			
			'Combine them
			Local CombinedBuffer:Int = RGBABuffer[0] + RGBABuffer[1] + RGBABuffer[2] + RGBABuffer[3]
			PrintPixel(CombinedBuffer) 'Render it to the canvas
			RGBAPos = 0
			RGBABuffer[0] = 0
			RGBABuffer[1] = 0
			RGBABuffer[2] = 0
			RGBABuffer[3] = 0
		EndIf
	End Method
	
	'Draws an INT directly to the canvas
	Method PrintPixel(RGBA:Int)
		WritePixel(pixmap, PosX, PosY, RGBA)
		AdvancePixel()
		If(isDithered And DitheredSkipPixel) Then AdvancePixel() 'Skip the next pixel twice?
	End Method
	
	'Advances a pixels X or Y coordinate for the next pixel of data
	Method AdvancePixel()
		PosX:+1
		If(PosX >= PixmapWidth(pixmap))
			PosX = 0
			PosY:+1
		EndIf
		If(PosY >= PixmapHeight(pixmap))
			DitheredSkipPixel = False
			Return
		EndIf
		DitheredSkipPixel = Not DitheredSkipPixel
	End Method
	
	'Calculates how much actual data fits into a png canvas
	Function GetPixmapBytesize:UInt(TMP_IsDithered:Byte, TMP_IncludeWatermark:Byte = True)
		Local MaxSize:UInt = (PixmapWidth(WorkspacePixmap) * PixmapHeight(WorkspacePixmap) * 4) - 32 '4 Bytes per pixel, header is 32 bytes
		If(TMP_IsDithered) Then MaxSize:/2
		If(TMP_IncludeWatermark = False) Then Return MaxSize
		Return MaxSize - GetBannerBytesize() ' take away the banner pixels
	End Function
	
	'Calculates how many bytes a banner will consume
	Function GetBannerBytesize:UInt()
		Return PixmapWidth(WorkspacePixmap) * PixmapHeight(ToPixmapWorkspace.Banner[0]) * 4
	End Function
	
	'Calculates how many pages will be needed
	Function CalculatePages:Short(TMP_FileSize:UInt, TMP_IsDithered:Byte)
		Local TMP_Pages:Int = Int(Ceil(Float(TMP_FileSize) / Float(GetPixmapBytesize(TMP_IsDithered))))
		If(TMP_Pages > $FFFF) Then Return $FFFF
		Return Short(TMP_Pages)
	End Function
	
	'Renders a banner/watermark on the bottom of the image
	Function DrawBanner(TMP_Pixmap:TPixmap)
		Local BannerType:Int
		'Which banner should we use?
		If(PixmapWidth(TMP_Pixmap) >= PixmapWidth(ToPixmapWorkspace.Banner[1]))
			BannerType = 1
		Else
			BannerType = 2
		EndIf
		'Copy the pixels for the banner
		For Local TMP_X:Int = 0 To PixmapWidth(ToPixmapWorkspace.Banner[BannerType]) - 1
			For Local TMP_Y:Int = 0 To PixmapHeight(ToPixmapWorkspace.Banner[BannerType]) - 1
				WritePixel(TMP_Pixmap, PixmapWidth(TMP_Pixmap) - PixmapWidth(ToPixmapWorkspace.Banner[BannerType]) + TMP_X, PixmapHeight(TMP_Pixmap) - PixmapHeight(ToPixmapWorkspace.Banner[BannerType]) + TMP_Y, ReadPixel(ToPixmapWorkspace.Banner[BannerType], TMP_X, TMP_Y))
			Next
		Next
		'BG fill
		If(PixmapWidth(TMP_Pixmap) > PixmapWidth(ToPixmapWorkspace.Banner[BannerType]))
			For Local TMP_X:Int = 0 To PixmapWidth(TMP_Pixmap) - PixmapWidth(ToPixmapWorkspace.Banner[BannerType]) - 1
				For Local TMP_Y:Int = 0 To PixmapHeight(ToPixmapWorkspace.Banner[0]) - 1
					WritePixel(TMP_Pixmap, TMP_X, PixmapHeight(TMP_Pixmap) - PixmapHeight(ToPixmapWorkspace.Banner[0]) + TMP_Y, ReadPixel(ToPixmapWorkspace.Banner[0], 0, TMP_Y))
				Next
			Next
		EndIf
	End Function
End Type

Function PNGFS_CreateHeader:TBank(TMP_IsDithered:Byte = False, TMP_FullSize:Int, TMP_PageSize:Int, TMP_TotalPages:Short = 1, TMP_CurrentPage:Short = 0, TMP_CRC16:Short, TMP_PageCRC16:Short, TMP_InternalFilename:String = "binary.bin")
	Local Header:TBank = CreateBank(32)
	'Header
	PokeByte(Header, 0, $4B) 'K
	If(TMP_IsDithered)
		PokeByte(Header, 1, $44) 'D
	Else
		PokeByte(Header, 1, $53) 'S
	EndIf
	PokeByte(Header, 2, $50) 'P
	PokeByte(Header, 3, $46) 'F
	'Sizes
	PokeInt(Header, 4, TMP_FullSize)
	PokeInt(Header, 8, TMP_PageSize)
	
	PokeShort(Header, 12, TMP_TotalPages) 'Number of total pages
	PokeShort(Header, 14, TMP_CurrentPage) 'Current Page+
	PokeShort(Header, 16, TMP_CRC16) 'Entire file CRC16 hash
	PokeShort(Header, 18, TMP_PageCRC16) 'Pages CRC16 hash
	
	'Filename
	TMP_InternalFilename = Left(TMP_InternalFilename, 12)
	For Local TMP_X:Int = 0 To 12 - 1
		If(TMP_X > Len(TMP_InternalFilename) - 1)
			PokeByte(Header, 20 + TMP_X, 0)
		'	Print "00"
		Else
			PokeByte(Header, 20 + TMP_X, Asc(Mid(TMP_InternalFilename, TMP_X + 1, 1)))
		'	Print Mid(TMP_InternalFilename, TMP_X + 1, 1)
		EndIf
	Next
	Rem
		'debugging
		Local headertxt:String
		Local headertxty:String
		For Local TMP_X:Int = 0 To BankSize(Header) - 1
			headertxt:+Chr(PeekByte(Header, TMP_X))
			headertxty:+Right(Hex(PeekByte(Header, TMP_X)), 2)
		Next
		Print headertxt
		Print headertxty
		Print "CRC16_File: " + TMP_CRC16
		Print "CRC16_Page: " + TMP_PageCRC16
	endrem
	
	Return Header
End Function

Function StripExtension:String(FilePath:String)
	Local SplitPath:String[] = FilePath.split(".")
	Local BaseName:String = ""
	For Local x:Int = 0 To Len(SplitPath) - 2 'take 1, so no overflow. Take another to strip extension.
		If(Len(BaseName) > 0) Then BaseName:+"."
		BaseName:+SplitPath[x]
	Next
	Return BaseName
End Function

Function StripFilename:String(FilePath:String)
	Local SplitPath:String[] = FilePath.split(".")
	Return "." + SplitPath[Len(SplitPath) - 1]
End Function

'Strips the path only keeping the filename
Function StripPath:String(FilePath:String)
	FilePath = FilePath.Replace("\", "/")
	Local SplitPath:String[] = FilePath.split("/")
	Return SplitPath[Len(SplitPath) - 1]
End Function

'Keeps only the folder path
Function StripDirectory:String(FilePath:String)
	Local FileName:String = StripPath(FilePath)
	Return Left(FilePath, Len(FilePath) - Len(FileName))
End Function

Function ReplaceSketchySymbols:String(TMP_Input:String)
	TMP_Input = TMP_Input.Replace("/", "")
	TMP_Input = TMP_Input.Replace("\", "")
	TMP_Input = TMP_Input.Replace(":", "")
	TMP_Input = TMP_Input.Replace("|", "")
	TMP_Input = TMP_Input.Replace("*", "")
	TMP_Input = TMP_Input.Replace("?", "")
	TMP_Input = TMP_Input.Replace("<", "")
	TMP_Input = TMP_Input.Replace(">", "")
	TMP_Input = TMP_Input.Replace(Chr(34), "") '"
	TMP_Input = TMP_Input.Replace(Chr(10), "") 'Newline 1
	TMP_Input = TMP_Input.Replace(Chr(13), "") 'Newline 2
	Return TMP_Input
End Function

'Converts an existing pixmap to a file stream
Function ConvertFileToPixmap:ToPixmapWorkspace(useDithered:Byte = False, TMP_File:TStream, TMP_InternalFilename:String = "binary.bin", TMP_FilePath:String = "image")
	Local Workspace:ToPixmapWorkspace = New ToPixmapWorkspace
	Workspace.pixmap = CopyPixmap(WorkspacePixmap)
	Workspace.file = TMP_File
	Workspace.isDithered = useDithered
	'Init these vars
	Workspace.RGBABuffer = New Int[4]
	Workspace.RGBAPos = 0
	Workspace.PageCount = 1
	ToPixmapWorkspace.ErrorStatus = ""
	'Cap this
	TMP_InternalFilename = Left(TMP_InternalFilename, 12)
	Local TMP_UsePages:Byte = False
		
	If(Len(TMP_InternalFilename) <= 0) Then TMP_InternalFilename = "FILENAME.BIN"
	'Dumb safeguard
	TMP_InternalFilename = ReplaceSketchySymbols(TMP_InternalFilename)
	
	'Pixmap not set
	If Not (Workspace.pixmap)
		ToPixmapWorkspace.ErrorStatus = "Pixmap not found!"
		Return Null
	End If
	'File not set
	If Not (Workspace.file)
		ToPixmapWorkspace.ErrorStatus = "File could not be loaded!"
		Return Null
	End If
	'Pixmap is too small :C
	If(PixmapWidth(Workspace.pixmap) < 32 And PixmapHeight(Workspace.pixmap) < 32)
		ToPixmapWorkspace.ErrorStatus = "Canvas must be at least 32x32"
		Return Null
	EndIf
	'Pages
	If(Workspace.GetPixmapBytesize(Workspace.isDithered) < StreamSize(TMP_File))
		TMP_UsePages = True
		Workspace.PageCount = Workspace.CalculatePages(UInt(StreamSize(TMP_File)), Workspace.isDithered)
	EndIf
		
	'CRC Check stuff
	Local CRC_File:Short = 0, CRC_Page:Short = 0
	CRC_File = StreamToCRC16(TMP_File)
	
	'Other vars
	Local CurrentPage:Short = 0
	Local TMP_FileSize:UInt = UInt(StreamSize(TMP_File))
	Local TMP_BytesWritten:UInt = 0 'How many bytes have been written to the file?
		
	'Ok lets convert the actual binary data into the file
	Workspace.PosX = 8 'Begin here so we can go back to writing the header after
	If(Workspace.isDithered) Then Workspace.PosX = 16 'Alternatively start here	
	Workspace.PosY = 0
	SeekStream(TMP_File, 0)

	While Not Eof(TMP_File)
		Local CurrentByte:Byte = ReadByte(TMP_File)
		Workspace.BufAddByte(CurrentByte)
		TMP_BytesWritten:+1
		CRC_Page = CRC16(CRC_Page, CurrentByte)
		'Reached end of page or reached eof
		If((TMP_UsePages And Workspace.PosY >= PixmapHeight(Workspace.pixmap) - PixmapHeight(ToPixmapWorkspace.Banner[0])) Or Eof(TMP_File))
			'Reached end of the file?
			If(Eof(TMP_File))
				'Any excess, just fill the end of the int with 00's
				While(Workspace.RGBAPos > 0)
					Workspace.BufAddByte(0)
				Wend
				'Fill the dithered image with random colours if we reached the file early				
				If(Workspace.isDithered)
					SeedRnd(TMP_FileSize)
					While(Workspace.PosY < PixmapHeight(Workspace.pixmap) - PixmapHeight(ToPixmapWorkspace.Banner[0]))
						Workspace.BufAddByte(Byte(Rand(0, 255)))
						Workspace.BufAddByte(Byte(Rand(0, 255)))
						Workspace.BufAddByte(Byte(Rand(0, 255)))
						Workspace.BufAddByte(Byte(Rand(0, 255)))
					Wend
				EndIf
			EndIf
			
			'I guess we can write the header now?
			Workspace.PosX = 0
			Workspace.PosY = 0
			Local Header:TBank = PNGFS_CreateHeader(Workspace.isDithered, TMP_FileSize, TMP_BytesWritten, Workspace.PageCount, CurrentPage, CRC_File, CRC_Page, TMP_InternalFilename)
			For Local TMP_X:Int = 0 To BankSize(Header) - 1
				Workspace.BufAddByte(Byte(PeekByte(Header, TMP_X)))
			Next
			
			'Draw the banner
			Workspace.DrawBanner(Workspace.Pixmap)
			If(TMP_UsePages)
				SavePixmapPNG(Workspace.pixmap, TMP_FilePath + "_" + CurrentPage + ".png", 9)
			Else
				SavePixmapPNG(Workspace.pixmap, TMP_FilePath + ".png", 9)
			EndIf
			Workspace.pixmap = CopyPixmap(WorkspacePixmap) 'Revert this back to a blank canvas
			CurrentPage:+1 'Next Page
			Workspace.DitheredSkipPixel = False
			'Reset these
			TMP_BytesWritten = 0
			CRC_Page = 0
			GCCollect()
		EndIf
	Wend
	
	Return Workspace
End Function

'To File functions
Type PNGFS_Header
	Field HeaderMode:String 'KSPF or KDPF
	Field TotalSize:UInt
	Field TotalSizePage:UInt
	Field PageCount:Short
	Field CurrentPageID:Short
	Field CRC16:Short
	Field PageCRC16:Short
	Field InternalFilename:String
	Field PosX:Int, PosY:Int
	Field ByteIndex:Int '0-3 before it goes to next posX
	Field Pixmap:TPixmap
	Field IsDithered:Byte
	Field DitheredSkipPixel:Byte
	
	Function PixmapToHeader:PNGFS_Header(TMP_Pixmap:TPixmap)
		Local Container:PNGFS_Header = New PNGFS_Header
		'Don't bother reading if these aren't in place
		If Not(TMP_Pixmap) Then Return Null
		If(PixmapWidth(TMP_Pixmap) < 32 Or PixmapHeight(TMP_Pixmap) < 32) Then Return Null
		Container.Pixmap = TMP_Pixmap
		
		'Header
		Container.HeaderMode = Container.GetText(4)
		'Header is good?
		If(Container.HeaderMode = "KSPF")
			Container.IsDithered = False
		ElseIf(Container.HeaderMode = "KDPF")
			Container.IsDithered = True
			Container.AdvancePixel()
		Else
			Return Null
		EndIf
		Container.TotalSize = Container.GetInteger()
		Container.TotalSizePage = Container.GetInteger()
		Container.PageCount = Container.GetShort()
		If(Container.PageCount <= 0) Then Return Null
		Container.CurrentPageID = Container.GetShort()
		Container.CRC16 = Container.GetShort()
		Container.PageCRC16 = Container.GetShort()
		Container.InternalFilename = Container.GetText(12)
		If(Len(Container.InternalFilename) <= 0) Then Container.InternalFilename = "BINARY.BIN"
		Container.InternalFilename = ReplaceSketchySymbols(Container.InternalFilename)
		
		Return Container
	End Function
	
	'Advances a pixels X or Y coordinate for the next pixel of data
	Method AdvancePixel()
		PosX:+1
		If(PosX >= PixmapWidth(pixmap))
			PosX = 0
			PosY:+1
		EndIf
		DitheredSkipPixel = Not DitheredSkipPixel
		If(PosY >= PixmapHeight(pixmap))
			Return
		EndIf
	End Method
	
	Method GetPixelByte:Byte()
		'Print "PosX: " + PosX + ", Index: " + ByteIndex
		Local CurrentByte:Byte
		Select ByteIndex
			Case 0 'Red
				CurrentByte = (ReadPixel(pixmap, PosX, PosY) Shr 16) & $FF
			Case 1 'Green
				CurrentByte = ((ReadPixel(pixmap, PosX, PosY) Shr 8) & $FF)
			Case 2 'Blue
				CurrentByte = (ReadPixel(pixmap, PosX, PosY) & $FF)
			Case 3 'Alpha
				CurrentByte = ((ReadPixel(pixmap, PosX, PosY) Shr 24) & $FF)
		End Select
		ByteIndex:+1
		If(ByteIndex > 3)
			ByteIndex = 0
			AdvancePixel()
			If(IsDithered And DitheredSkipPixel) Then AdvancePixel() 'Skip the next pixel twice?
		EndIf
		Return CurrentByte
	End Method
	
	Method GetInteger:Int()
		Local TMP_Int:Int = GetPixelByte()
		TMP_Int:+Int(GetPixelByte()) Shl 8
		TMP_Int:+Int(GetPixelByte()) Shl 16
		TMP_Int:+Int(GetPixelByte()) Shl 24
		Return TMP_Int
	End Method
	
	Method GetShort:Short()
		Local TMP_Int:Int = GetPixelByte()
		TMP_Int:+Int(GetPixelByte()) Shl 8
		Return Short(TMP_Int)
	End Method
	
	Method GetText:String(TMP_Characters:Int)
		Local TMP_String:String = ""
		For Local TMP_X:Int = 0 To TMP_Characters - 1
			Local TMP_Char:Int = GetPixelByte()
			If(TMP_Char > 0) Then TMP_String:+Chr(TMP_Char) 'Don't add null characters to the string
		Next
		Return TMP_String
	End Method
End Type

Type ToFileWorkspace
	Global ErrorStatus:String
End Type

Function ConvertPixmapToFile:ToFileWorkspace(TMP_Path:String, TMP_OutputPath:String = Null)
	ToFileWorkspace.ErrorStatus = ""
	Local Workspace:ToFileWorkspace = New ToFileWorkspace
	WorkspacePixmap:TPixmap = LoadPixmap(TMP_Path)
	If(Not WorkspacePixmap)
		Workspace.ErrorStatus = "Failed to load PNGFS!"
		Return Workspace
	EndIf
	
	Local header:PNGFS_Header = PNGFS_Header.PixmapToHeader(WorkspacePixmap)
	If(Not header)
		Workspace.ErrorStatus = "Failed to recognise PNGFS header data! (Has alpha been lost? Is this even a PNGFS image?)"
		Return Workspace
	EndIf
	
	If(ToPixmapWorkspace.GetPixmapBytesize(header.IsDithered, False) < header.TotalSizePage)
		Workspace.ErrorStatus = "PNGFS claims to have more storage inside than what can actually fit. Corruption?"
		Print ToPixmapWorkspace.GetPixmapBytesize(header.IsDithered)
		Print header.TotalSizePage
		Return Workspace
	EndIf
	if(len(TMP_OutputPath) <= 0) Then TMP_OutputPath = header.InternalFilename
	
	Local PathArray:String[]
	
	If(header.PageCount <= 0)
		Workspace.ErrorStatus = "PNGFS contains an invalid page count. Corruption?"
		Return Workspace
	ElseIf(header.PageCount = 1)
		PathArray = New String[1]
		PathArray[0] = TMP_Path
	Else
		PathArray = New String[header.PageCount]
		Local DirectoryPath:String = StripDirectory(TMP_Path)
		Local Directory:Byte Ptr = ReadDir(DirectoryPath)
		If Not(Directory)
			Workspace.ErrorStatus = "Error getting the directory for the PNGFS file."
			Return Workspace
		EndIf
		Repeat
			Local TMP_CurrentFile:String = NextFile(Directory)
			If(TMP_CurrentFile:String = "")
				Exit
			ElseIf Not(TMP_CurrentFile = "." Or TMP_CurrentFile = "..")
				If(Right(Upper(TMP_CurrentFile), 4) = ".PNG")
					Local TMP_Pixmap:TPixmap = LoadPixmap(DirectoryPath + TMP_CurrentFile)
					'Loaded pixmap successfully?
					If(TMP_Pixmap)
						Local TMP_Header:PNGFS_Header = PNGFS_Header.PixmapToHeader(TMP_Pixmap)
						If(TMP_Header)
							'Header info matches the source file?
							If(TMP_Header.CRC16 = header.CRC16 And TMP_Header.PageCount = header.PageCount And TMP_Header.InternalFilename = header.InternalFilename And TMP_Header.TotalSize = header.TotalSize And TMP_Header.CurrentPageID < Len(PathArray))
								PathArray[TMP_Header.CurrentPageID] = DirectoryPath + TMP_CurrentFile
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			GCCollect()
		Forever
		
		'Check the whole array and make sure its all filled with paths
		For Local TMP_X = 0 To Len(PathArray) - 1
			If(Len(PathArray[TMP_X]) <= 0)
				Workspace.ErrorStatus = "Could not locate page '" + TMP_X + "'. Please place them in the same directory with the selected file."
				Return Workspace
			EndIf
		Next
	EndIf
	
	'Export the shiz
	Local TMP_Output:TStream = WriteFile(TMP_OutputPath)
	Local TMP_OutputCRC16:Short
	Local TMP_WrittenBytes:UInt = 0
	
	If(Not TMP_Output)
		CloseFile(TMP_Output)
		Workspace.ErrorStatus = "Failed to gain write access to: '" + TMP_OutputPath + "'."
		Return Workspace
	EndIf
	
	For Local TMP_X = 0 To Len(PathArray) - 1
		Local TMP_Header:PNGFS_Header
		Local TMP_PageCRC16:Short
		
		'Wait is it just a single file anyway?
		If(header.PageCount = 1)
			TMP_Header = header
		Else 'Multipage
			WorkspacePixmap:TPixmap = LoadPixmap(PathArray[TMP_X])
			If(Not WorkspacePixmap)
				CloseFile(TMP_Output)
				Workspace.ErrorStatus = "Failed to load page " + TMP_X + " PNGFS!"
				Return Workspace
			EndIf
			
			TMP_Header = PNGFS_Header.PixmapToHeader(WorkspacePixmap)
			If(Not TMP_Header)
				CloseFile(TMP_Output)
				Workspace.ErrorStatus = "Failed to recognise PNGFS header data on page " + TMP_X + "! (Has alpha been lost? Is this even a PNGFS image?)"
				Return Workspace
			EndIf
		EndIf
		'Each byte in the file
		For Local TMP_Y = 0 To TMP_Header.TotalSizePage - 1
			Local TMP_Byte:Byte = TMP_Header.GetPixelByte()
			TMP_OutputCRC16 = CRC16(TMP_OutputCRC16, TMP_Byte)
			TMP_PageCRC16 = CRC16(TMP_PageCRC16, TMP_Byte)
			WriteByte(TMP_Output, TMP_Byte)
			TMP_WrittenBytes:+1
		Next
		
		'Error checks
		If(TMP_WrittenBytes > header.TotalSize)
			CloseFile(TMP_Output)
			Workspace.ErrorStatus = "Written file exceeds defined file size. Corruption?"
			Return Workspace
		EndIf
		If(TMP_PageCRC16 <> TMP_Header.PageCRC16)
			CloseFile(TMP_Output)
			Workspace.ErrorStatus = "Page " + TMP_Header.CurrentPageID + " contained a CRC16 checksum fail. Corruption?~n" + Right(Hex(TMP_Header.PageCRC16), 4) + " expected but got " + Right(Hex(TMP_PageCRC16), 4)
			Return Workspace
		EndIf
	Next
	If(TMP_OutputCRC16 <> header.CRC16)
		CloseFile(TMP_Output)
		Workspace.ErrorStatus = "Written file contained an overall CRC16 checksum fail. Corruption?~n" + Right(Hex(header.CRC16), 4) + " expected but got " + Right(Hex(TMP_OutputCRC16), 4)
		Return Workspace
	EndIf
	Print "Exported " + TMP_OutputPath
	CloseFile(TMP_Output)
End Function
