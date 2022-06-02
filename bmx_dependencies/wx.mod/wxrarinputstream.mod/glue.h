/*
  Copyright (c) 2007-2018 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "wxglue.h"
#include "wx/rarstream.h"

//class MaxRarFileInfo;

extern "C" {

#include <blitz.h>

	wxRarInputStream * bmx_wxrarinputstream_create(BBString * filename);
	int bmx_wxrarinputstream_opennextfile(wxRarInputStream * stream);
	int bmx_wxrarinputstream_extractfile(wxRarInputStream * stream, BBString * destPath, BBString * destName);
	wxRarFileInfo * bmx_wxrarinputstream_getfileinfo(wxRarInputStream * stream);
	void bmx_wxrarinputstream_close(wxRarInputStream * stream);

	void bmx_wxrarfileinfo_delete(wxRarFileInfo * info);
	BBString * bmx_wxrarfileinfo_getname(wxRarFileInfo * info);
	BBString * bmx_wxrarfileinfo_getcomment(wxRarFileInfo * info);
	wxUint32 bmx_wxrarfileinfo_getuncompressedsize(wxRarFileInfo * info);
	wxUint32 bmx_wxrarfileinfo_getcompressedsize(wxRarFileInfo * info);
	wxUint32 bmx_wxrarfileinfo_getfiletime(wxRarFileInfo * info);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

