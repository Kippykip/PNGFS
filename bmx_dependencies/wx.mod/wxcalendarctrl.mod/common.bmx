' Copyright (c) 2007-2018 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import wx.wx
Import wx.wxControl
Import wx.wxDateTime


' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk3-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk3-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk3-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "glue.cpp"

Extern

	Function bmx_wxcalendarctrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, date:Byte Ptr, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxcalendarctrl_setdate(handle:Byte Ptr, date:Byte Ptr)
	Function bmx_wxcalendarctrl_getdate:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_enablemonthchange(handle:Byte Ptr, enable:Int)
	Function bmx_wxcalendarctrl_enableholidaydisplay(handle:Byte Ptr, display:Int)
	Function bmx_wxcalendarctrl_setheadercolours(handle:Byte Ptr, colFG:Byte Ptr, colBG:Byte Ptr)
	Function bmx_wxcalendarctrl_getheadercolourfg:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_getheadercolourbg:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_sethighlightcolours(handle:Byte Ptr, colFG:Byte Ptr, colBG:Byte Ptr)
	Function bmx_wxcalendarctrl_gethighlightcolourfg:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_gethighlightcolourbg:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_setholidaycolours(handle:Byte Ptr, colFG:Byte Ptr, colBG:Byte Ptr)
	Function bmx_wxcalendarctrl_getholidaycolourfg:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_getholidaycolourbg:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendarctrl_getattr:Byte Ptr(handle:Byte Ptr, day:Int)
	Function bmx_wxcalendarctrl_setattr(handle:Byte Ptr, day:Int, attr:Byte Ptr)
	Function bmx_wxcalendarctrl_setholiday(handle:Byte Ptr, day:Int)
	Function bmx_wxcalendarctrl_resetattr(handle:Byte Ptr, day:Int)
	Function bmx_wxcalendarctrl_hittest:Byte Ptr(handle:Byte Ptr, x:Int, y:Int, where_:Int Ptr, wd:Int Ptr)

	Function bmx_wxcalendardateattr_create:Byte Ptr(colText:Byte Ptr, colBack:Byte Ptr, colBorder:Byte Ptr, font:Byte Ptr, border:Int)
	Function bmx_wxcalendardateattr_settextcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxcalendardateattr_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxcalendardateattr_setbordercolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxcalendardateattr_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxcalendardateattr_setborder(handle:Byte Ptr, border:Int)
	Function bmx_wxcalendardateattr_setholidy(handle:Byte Ptr, holiday:Int)
	Function bmx_wxcalendardateattr_hastextcolour:Int(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_hasbackgroundcolour:Int(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_hasbordercolour:Int(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_hasfont:Int(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_hasborder:Int(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_isholiday:Int(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_gettextcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_getbordercolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcalendardateattr_getborder:Int(handle:Byte Ptr)

	Function bmx_wxcalendarctrl_geteventtype:Int(eventType:Int)
	
	Function bmx_wxcalendarctrl_addresourcehandler()
	
End Extern

Rem
bbdoc: Show Sunday as the First day of the week (Default)
End Rem
Const wxCAL_SUNDAY_FIRST:Int = $0000

Rem
bbdoc: Show Monder as the First day of the week
End Rem
Const wxCAL_MONDAY_FIRST:Int = $0001

Rem
bbdoc: Highlight holidays
End Rem
Const wxCAL_SHOW_HOLIDAYS:Int = $0002

Rem
bbdoc: Don't allow changing neither month nor year (implies wxCAL_NO_YEAR_CHANGE)
End Rem
Const wxCAL_NO_MONTH_CHANGE:Int = $000c

Rem
bbdoc: Use MS-style Month-selection instead of combo-spin combination. (only generic)
End Rem
Const wxCAL_SEQUENTIAL_MONTH_SELECTION:Int = $0010

Rem
bbdoc: Show the neighbouring weeks in the previous and next month. (only generic, always on for the native controls)
End Rem
Const wxCAL_SHOW_SURROUNDING_WEEKS:Int = $0020

Rem
bbdoc: Show week numbers on the left side of the calendar. (not in generic)
End Rem
Const wxCAL_SHOW_WEEK_NUMBERS:Int = $0040

Const wxCAL_HITTEST_NOWHERE:Int = 0      ' outside of anything
Const wxCAL_HITTEST_HEADER:Int = 1       ' on the header (weekdays) 
Const wxCAL_HITTEST_DAY:Int = 2          ' on a day in the calendar 
Const wxCAL_HITTEST_INCMONTH:Int = 3
Const wxCAL_HITTEST_DECMONTH:Int = 4
Const wxCAL_HITTEST_SURROUNDING_WEEK:Int = 5

Const wxCAL_BORDER_NONE:Int = 0          ' no border (Default)
Const wxCAL_BORDER_SQUARE:Int = 1        ' a rectangular border
Const wxCAL_BORDER_ROUND:Int = 2         ' a round border


Const wxEVT_CALENDAR_SEL_CHANGED:Int = 950
Const wxEVT_CALENDAR_DAY_CHANGED:Int = 951
Const wxEVT_CALENDAR_MONTH_CHANGED:Int = 952
Const wxEVT_CALENDAR_YEAR_CHANGED:Int = 953
Const wxEVT_CALENDAR_DOUBLECLICKED:Int = 954
Const wxEVT_CALENDAR_WEEKDAY_CLICKED:Int = 955



