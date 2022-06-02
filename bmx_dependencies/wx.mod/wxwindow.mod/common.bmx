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
Import wx.wxDC
Import wx.wxCursor
Import wx.wxMenu
Import wx.wxDropTarget
Import wx.wxValidator
Import wx.wxAcceleratorTable



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

	Function bmx_wxwindow_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxwindow_show:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxwindow_close:Int(handle:Byte Ptr, force:Int)
	Function bmx_wxwindow_setsizer(handle:Byte Ptr, sizer:Byte Ptr, deleteOld:Int)
	Function bmx_wxwindow_setautolayout(handle:Byte Ptr, autoLayout:Int)
	Function bmx_wxwindow_delete(handle:Byte Ptr)
	Function bmx_wxwindow_getsizer:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_layout(handle:Byte Ptr)
	Function bmx_wxwindow_getwindowstyleflag:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getbestsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_setfocus(handle:Byte Ptr)
	Function bmx_wxwindow_clearbackground(handle:Byte Ptr)
	Function bmx_wxwindow_clienttoscreen(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_setbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxwindow_setfont:Int(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxwindow_setforegroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxwindow_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_gethelptext:String(handle:Byte Ptr)
	Function bmx_wxwindow_getid:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getlabel:String(handle:Byte Ptr)
	Function bmx_wxwindow_preparedc(handle:Byte Ptr, dc:Byte Ptr)
	Function bmx_wxwindow_refresh(handle:Byte Ptr, eraseBackground:Int)
	Function bmx_wxwindow_getparent:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getscrollpos:Int(handle:Byte Ptr, orientation:Int)
	Function bmx_wxwindow_getscrollrange:Int(handle:Byte Ptr, orientation:Int)
	Function bmx_wxwindow_getscrollthumb:Int(handle:Byte Ptr, orientation:Int)
	Function bmx_wxwindow_getcharheight:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getcharwidth:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getclientsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxwindow_getforegroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getgrandparent:Byte Ptr(handle:Byte Ptr)
	
	Function bmx_wxwindow_gethelptextatpoint:String(handle:Byte Ptr, x:Int, y:Int, origin:Int)
	Function bmx_wxwindow_getmaxsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getminsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getname:String(handle:Byte Ptr)
	Function bmx_wxwindow_getposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_getrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getscreenposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_getscreenrect(handle:Byte Ptr, x:Int Ptr, y:Int Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_getrectrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getscreenrectrect:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_sethelptext(handle:Byte Ptr, helpText:String)
	Function bmx_wxwindow_setid(handle:Byte Ptr, id:Int)
	Function bmx_wxwindow_setlabel(handle:Byte Ptr, label:String)
	Function bmx_wxwindow_setscrollbar(handle:Byte Ptr, orientation:Int, position:Int, thumbsize:Int, Range:Int, refresh:Int)
	Function bmx_wxwindow_setscrollpos(handle:Byte Ptr, orientation:Int, pos:Int, refresh:Int)
	
	Function bmx_wxwindow_setcursor(handle:Byte Ptr, cursor:Byte Ptr)
	Function bmx_wxwindow_setwindowstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setwindowstyleflag(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_hide:Int(handle:Byte Ptr)
	Function bmx_wxwindow_move(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxwindow_setdimensions(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, flags:Int)
	Function bmx_wxwindow_setdimensionsrect(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxwindow_pusheventhandler(handle:Byte Ptr, evt:Byte Ptr)

	Function bmx_wxwindow_getwindowvariant:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hascapture:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hasflag:Int(handle:Byte Ptr, flag:Int)
	Function bmx_wxwindow_hasmultiplepages:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hastransparentbackground:Int(handle:Byte Ptr)
	Function bmx_wxwindow_hasscrollbar:Int(handle:Byte Ptr, orient:Int)
	Function bmx_wxwindow_inheritattributes(handle:Byte Ptr)
	Function bmx_wxwindow_initdialog(handle:Byte Ptr)
	Function bmx_wxwindow_invalidatebestsize(handle:Byte Ptr)
	Function bmx_wxwindow_isdoublebuffered:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isenabled:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isexposed:Int(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxwindow_isexposedrect:Int(handle:Byte Ptr, rect:Byte Ptr)
	Function bmx_wxwindow_isfrozen:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isretained:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isshown:Int(handle:Byte Ptr)
	Function bmx_wxwindow_isshownonscreen:Int(handle:Byte Ptr)
	Function bmx_wxwindow_istoplevel:Int(handle:Byte Ptr)
	Function bmx_wxwindow_reparent:Int(handle:Byte Ptr, parent:Byte Ptr)
	
	Function bmx_wxwindow_destroy:Int(handle:Byte Ptr)
	Function bmx_wxwindow_destroyChildren(handle:Byte Ptr)
	Function bmx_wxwindow_disable:Int(handle:Byte Ptr)
	Function bmx_wxwindow_dragacceptfiles(handle:Byte Ptr, accept:Int)
	Function bmx_wxwindow_enable:Int(handle:Byte Ptr, value:Int)
	Function bmx_wxwindow_enabletouchevents:Int(handle:Byte Ptr, eventMask:Int)
	Function bmx_wxwindow_fit(handle:Byte Ptr)
	Function bmx_wxwindow_fitinside(handle:Byte Ptr)
	Function bmx_wxwindow_freeze(handle:Byte Ptr)
	Function bmx_wxwindow_getbackgroundcolour:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getbackgroundstyle:Int(handle:Byte Ptr)
	Function bmx_wxwindow_getcontentscalefactor:Double(handle:Byte Ptr)
	Function bmx_wxwindow_geteffectiveminsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxwindow_capturemouse(handle:Byte Ptr)
	Function bmx_wxwindow_centre(handle:Byte Ptr, direction:Int)
	Function bmx_wxwindow_centreonparent(handle:Byte Ptr, direction:Int)
	Function bmx_wxwindow_popupmenu:Int(handle:Byte Ptr, menu:Byte Ptr, x:Int, y:Int)
	Function bmx_wxwindow_refreshrect(handle:Byte Ptr, x:Int, y:Int, w:Int, h:Int, erase:Int)
	Function bmx_wxwindow_refreshrectrect(handle:Byte Ptr, rect:Byte Ptr, erase:Int)
	Function bmx_wxwindow_releasemouse(handle:Byte Ptr)
	Function bmx_wxwindow_screentoclient(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxwindow_setsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setposition(handle:Byte Ptr, x:Int, y:Int)

	Function bmx_wxwindow_gethandle:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_linedown:Int(handle:Byte Ptr)
	Function bmx_wxwindow_lineup:Int(handle:Byte Ptr)
	Function bmx_wxwindow_lower(handle:Byte Ptr)
	Function bmx_wxwindow_moveafterintaborder(handle:Byte Ptr, win:Byte Ptr)
	Function bmx_wxwindow_movebeforeintaborder(handle:Byte Ptr, win:Byte Ptr)
	Function bmx_wxwindow_pagedown:Int(handle:Byte Ptr)
	Function bmx_wxwindow_pageup:Int(handle:Byte Ptr)
	Function bmx_wxwindow_popeventhandler:Byte Ptr(handle:Byte Ptr, deleteHandler:Int)
	Function bmx_wxwindow_raise(handler:Byte Ptr)
	Function bmx_wxwindow_removeeventhandler:Int(handle:Byte Ptr, handler:Byte Ptr)
	Function bmx_wxwindow_setbackgroundstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setinitialsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxwindow_setclientsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxwindow_setcontainingsizer(handle:Byte Ptr, sizer:Byte Ptr)
	'Function bmx_wxwindow_setinitialbestsize(handle:Byte Ptr, w:Int, h:Int)
	Function bmx_wxwindow_seteventhandler(handle:Byte Ptr, handler:Byte Ptr)
	Function bmx_wxwindow_setextrastyle(handle:Byte Ptr, style:Int)
	Function bmx_wxwindow_setmaxsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setminsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setname(handle:Byte Ptr, name:String)
	Function bmx_wxwindow_setownbackgroundcolour(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxwindow_setownfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_wxwindow_setownforegroundcolour(handle:Byte Ptr, colour:Byte Ptr)

	Function bmx_wxwindow_findfocus:Byte Ptr()
	Function bmx_wxwindow_thaw(handle:Byte Ptr)
	Function bmx_wxwindow_togglewindowstyle:Int(handle:Byte Ptr, flag:Int)
	Function bmx_wxwindow_transferdatafromwindow:Int(handle:Byte Ptr)
	Function bmx_wxwindow_transferdatatowindow:Int(handle:Byte Ptr)
	Function bmx_wxwindow_udpate(handle:Byte Ptr)
	Function bmx_wxwindow_updatewindowui(handle:Byte Ptr, flags:Int)
	Function bmx_wxwindow_validate:Int(handle:Byte Ptr)
	Function bmx_wxwindow_setsizerandfit(handle:Byte Ptr, sizer:Byte Ptr, deleteOld:Int)
	Function bmx_wxwindow_setthemeenabled(handle:Byte Ptr, enable:Int)
	Function bmx_wxwindow_settooltip(handle:Byte Ptr, tip:String)
	Function bmx_wxwindow_setvirtualsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxwindow_setminclientsize(handle:Byte Ptr, minW:Int, minH:Int)
	Function bmx_wxwindow_setmaxclientsize(handle:Byte Ptr, maxW:Int, maxH:Int)

	Function bmx_wxwindow_convertdialogtopixels(handle:Byte Ptr, dx:Int, dy:Int, px:Int Ptr, py:Int Ptr)
	Function bmx_wxwindow_convertpixelstodialog(handle:Byte Ptr, px:Int, py:Int, dx:Int Ptr, dy:Int Ptr)
	Function bmx_wxwindow_findwindow:Byte Ptr(handle:Byte Ptr, id:Int)
	Function bmx_wxwindow_findwindowbyid:Byte Ptr(id:Int, parent:Byte Ptr)
	Function bmx_wxwindow_findwindowbyname:Byte Ptr(name:String, parent:Byte Ptr)
	Function bmx_wxwindow_findwindowbylabel:Byte Ptr(label:String, parent:Byte Ptr)
	Function bmx_wxwindow_getcapture:Byte Ptr()
	Function bmx_wxwindow_getcaret:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getcontainingsizer:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getcursor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_getextrastyle:Int(handle:Byte Ptr)
	Function bmx_wxwindow_geteventhandler:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_gettextextent(handle:Byte Ptr, Text:String, x:Int Ptr, y:Int Ptr, descent:Int Ptr, ..
			externalLeading:Int Ptr, font:Byte Ptr, use16:Int)
	Function bmx_wxwindow_getvirtualsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxwindow_getwindowbordersize(handle:Byte Ptr, leftRight:Int Ptr, topBottom:Int Ptr)
	Function bmx_wxwindow_navigate(handle:Byte Ptr, flags:Int)
	Function bmx_wxwindow_registerhotkey:Int(handle:Byte Ptr, hotKeyId:Int, modifiers:Int, virtualKeyCode:Int)
	Function bmx_wxwindow_scrolllines:Int(handle:Byte Ptr, LINES:Int)
	Function bmx_wxwindow_scrollpages:Int(handle:Byte Ptr, pages:Int)
	Function bmx_wxwindow_setcaret(handle:Byte Ptr, caret:Byte Ptr)
	Function bmx_wxwindow_setwindowvariant(handle:Byte Ptr, variant:Int)
	Function bmx_wxwindow_unregisterhotkey:Int(handle:Byte Ptr, hotKeyId:Int)
	Function bmx_wxwindow_warppointer(handle:Byte Ptr, x:Int, y:Int)

	Function bmx_wxwindow_getdroptarget:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_setdroptarget(handle:Byte Ptr, target:Byte Ptr)
	Function bmx_wxwindow_gettooltip:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_scrollwindow(handle:Byte Ptr, dx:Int, dy:Int, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxwindow_scrollwindowrect(handle:Byte Ptr, dx:Int, dy:Int, rect:Byte Ptr)
	
	Function bmx_wxwindow_alwaysshowscrollbars(handle:Byte Ptr, hflag:Int, vflag:Int)
	Function bmx_wxwindow_beginrepositioningchildren:Int(handle:Byte Ptr)
	Function bmx_wxwindow_canacceptfocus:Int(handle:Byte Ptr)
	Function bmx_wxwindow_canacceptfocusfromkeyboard:Int(handle:Byte Ptr)
	Function bmx_wxwindow_canscroll:Int(handle:Byte Ptr, orient:Int)
	Function bmx_wxwindow_cansettransparent:Int(handle:Byte Ptr)
	Function bmx_wxwindow_endrepositioningchildren(handle:Byte Ptr)

	Function bmx_wxwindow_fromdippoint(handle:Byte Ptr, x:Int, y:Int, px:Int Ptr, py:Int Ptr)
	Function bmx_wxwindow_fromdipsize(handle:Byte Ptr, w:Int, h:Int, sw:Int Ptr, sh:Int Ptr)
	Function bmx_wxwindow_fromdip:Int(handle:Byte Ptr, d:Int)
	Function bmx_wxwindow_todip:Int(handle:Byte Ptr, d:Int)
	Function bmx_wxwindow_todipsize(handle:Byte Ptr, w:Int, h:Int, sw:Int Ptr, sh:Int Ptr)
	Function bmx_wxwindow_todippoint(handle:Byte Ptr, x:Int, y:Int, px:Int Ptr, py:Int Ptr)
	Function bmx_wxwindow_unsettooltip(handle:Byte Ptr)
	Function bmx_window_showwitheffect:Int(handle:Byte Ptr, effect:Int, timeout:Int)
	Function bmx_window_hidewitheffect:Int(handle:Byte Ptr, effect:Int, timeout:Int)

	Function bmx_wxboxsizer_create:Byte Ptr(handle:Object, orient:Int)
	Function bmx_wxsizer_add:Byte Ptr(handler:Byte Ptr, window:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_addsizer:Byte Ptr(handler:Byte Ptr, sizer:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_detach:Int(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsizer_detachsizer:Int(handle:Byte Ptr, sizer:Byte Ptr)
	Function bmx_wxsizer_insert:Byte Ptr(handler:Byte Ptr, index:Int, window:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_insertsizer:Byte Ptr(handler:Byte Ptr, index:Int, sizer:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_addcustomspacer:Byte Ptr(handler:Byte Ptr, width:Int, height:Int, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_addspacer:Byte Ptr(handler:Byte Ptr, size:Int)
	Function bmx_wxsizer_addstretchspacer:Byte Ptr(handler:Byte Ptr, prop:Int)
	Function bmx_wxsizer_setitemminsize(handler:Byte Ptr, index:Int, width:Int, height:Int)
	Function bmx_wxsizer_setitemminsizewindow(handler:Byte Ptr, window:Byte Ptr, width:Int, height:Int)
	Function bmx_wxsizer_setitemminsizesizer(handler:Byte Ptr, sizer:Byte Ptr, width:Int, height:Int)
	Function bmx_wxsizer_clear(handler:Byte Ptr, deleteWindows:Int)
	Function bmx_wxsizer_fitinside(handler:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsizer_getcontainingwindow:Byte Ptr(handler:Byte Ptr)
	Function bmx_wxsizer_getsize(handler:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxsizer_getposition(handler:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxsizer_getminsize(handler:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxsizer_show:Int(handler:Byte Ptr, window:Byte Ptr, doShow:Int, recursive:Int)
	Function bmx_wxsizer_showsizer:Int(handler:Byte Ptr, sizer:Byte Ptr, doShow:Int, recursive:Int)
	Function bmx_wxsizer_showitem:Int(handler:Byte Ptr, index:Int, doShow:Int)
	Function bmx_wxgridsizer_create:Byte Ptr(handle:Object, COLS:Int, vgap:Int, hgap:Int)
	Function bmx_wxgridsizer_createrc:Byte Ptr(handle:Object, rows:Int, COLS:Int, vgap:Int, hgap:Int)
	Function bmx_wxgridsizer_getcols:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_gethgap:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_getrows:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_getvgap:Int(handle:Byte Ptr)
	Function bmx_wxgridsizer_setcols(handle:Byte Ptr, COLS:Int)
	Function bmx_wxgridsizer_sethgap(handle:Byte Ptr, hgap:Int)
	Function bmx_wxgridsizer_setrows(handle:Byte Ptr, rows:Int)
	Function bmx_wxgridsizer_setvgap(handle:Byte Ptr, vgap:Int)
	Function bmx_wxsizer_setsizehints(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxflexgridsizer_create:Byte Ptr(handle:Object, COLS:Int, vgap:Int, hgap:Int)
	Function bmx_wxflexgridsizer_createrc:Byte Ptr(handle:Object, rows:Int, COLS:Int, vgap:Int, hgap:Int)
	Function bmx_wxflexgridsizer_addgrowablecol(handle:Byte Ptr, index:Int, prop:Int)
	Function bmx_wxflexgridsizer_addgrowablerow(handle:Byte Ptr, index:Int, prop:Int)
	Function bmx_wxsizer_fit(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsizer_fitsize(handle:Byte Ptr, window:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxboxsizer_getorientation:Int(handle:Byte Ptr)
	Function bmx_wxsizer_isshown:Int(handle:Byte Ptr, index:Int)
	Function bmx_wxsizer_layout(handle:Byte Ptr)
	Function bmx_wxsizer_recalcsizes(handle:Byte Ptr)

	Function bmx_wxsizer_insertspacer:Byte Ptr(handle:Byte Ptr, index:Int, size:Int)
	Function bmx_wxsizer_insertstretchspacer:Byte Ptr(handle:Byte Ptr, index:Int, prop:Int)
	Function bmx_wxsizer_iswindowshown:Int(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxsizer_issizershown:Int(handle:Byte Ptr, sizer:Byte Ptr)
	Function bmx_wxsizer_setdimension(handle:Byte Ptr, x:Int, y:Int, width:Int, height:Int)
	Function bmx_wxsizer_setminsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxsizer_prepend:Byte Ptr(handle:Byte Ptr, window:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_prependsizer:Byte Ptr(handle:Byte Ptr, sizer:Byte Ptr, proportion:Int, flag:Int, border:Int)
	Function bmx_wxsizer_prependspacer:Byte Ptr(handle:Byte Ptr, size:Int)
	Function bmx_wxsizer_prependstretchspacer:Byte Ptr(handle:Byte Ptr, prop:Int)
	Function bmx_wxsizer_removesizer:Int(handle:Byte Ptr, sizer:Byte Ptr)
	Function bmx_wxsizer_remove:Int(handle:Byte Ptr, index:Int)
	Function bmx_wxsizer_replacewindow:Int(handle:Byte Ptr, oldWin:Byte Ptr, newWin:Byte Ptr, recursive:Int)
	Function bmx_wxsizer_replacesizer:Int(handle:Byte Ptr, oldsz:Byte Ptr, newsz:Byte Ptr, recursive:Int)
	Function bmx_wxsizer_replace:Int(handle:Byte Ptr, oldIndex:Int, newItem:Byte Ptr)
	Function bmx_wxsizer_getitemcount:Int(handle:Byte Ptr)
	Function bmx_wxsizer_isempty:Int(handle:Byte Ptr)

	Function bmx_wxflexgridsizer_getflexibledirection:Int(handle:Byte Ptr)
	Function bmx_wxflexgridsizer_getnonflexiblegrowmode:Int(handle:Byte Ptr)
	Function bmx_wxflexgridsizer_removegrowablecol(handle:Byte Ptr, idx:Int)
	Function bmx_wxflexgridsizer_removegrowablerow(handle:Byte Ptr, idx:Int)
	Function bmx_wxflexgridsizer_setflexibledirection(handle:Byte Ptr, direction:Int)
	Function bmx_wxflexgridsizer_setnonflexiblegrowmode(handle:Byte Ptr, Mode:Int)

	Function bmx_wxtooltip_enable(flag:Int)
	Function bmx_wxtooltip_setdelay(msecs:Int)
	Function bmx_wxtooltip_settip(handle:Byte Ptr, tip:String)
	Function bmx_wxtooltip_gettip:String(handle:Byte Ptr)
	Function bmx_wxtooltip_getwindow:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxupdateeventui_canupdate:Int(window:Byte Ptr)
	Function bmx_wxupdateeventui_getchecked:Int(handle:Byte Ptr)
	Function bmx_wxupdateeventui_getenabled:Int(handle:Byte Ptr)
	Function bmx_wxupdateeventui_getshown:Int(handle:Byte Ptr)
	Function bmx_wxupdateeventui_gettext:String(handle:Byte Ptr)
	Function bmx_wxupdateeventui_getmode:Int()
	Function bmx_wxupdateeventui_getupdateinterval:Int()
	Function bmx_wxupdateeventui_setmode(Mode:Int)
	Function bmx_wxupdateeventui_settext(handle:Byte Ptr, Text:String)
	Function bmx_wxupdateeventui_setupdateinterval(interval:Int)

	Function bmx_wxidleevent_getmode:Int()
	Function bmx_wxidleevent_requestmore(handle:Byte Ptr, needMore:Int)
	Function bmx_wxidleevent_morerequested:Int(handle:Byte Ptr)
	Function bmx_wxidleevent_setmode(Mode:Int)

	Function bmx_wxfocusevent_getwindow:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxwindow_getacceleratortable:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxwindow_setacceleratortable(handle:Byte Ptr, table:Byte Ptr)

	Function bmx_wxsetcursorevent_getcursor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsetcursorevent_getx:Int(handle:Byte Ptr)
	Function bmx_wxsetcursorevent_gety:Int(handle:Byte Ptr)
	Function bmx_wxsetcursorevent_hascursor:Int(handle:Byte Ptr)
	Function bmx_wxsetcursorevent_setcursor(handle:Byte Ptr, cursor:Byte Ptr)

	Function bmx_wxeraseevent_getdc:Byte Ptr(handle:Byte Ptr)

	Function bmx_wxcaret_create:Byte Ptr(window:Byte Ptr, width:Int, height:Int)
	Function bmx_wxcaret_getblinktime:Int()
	Function bmx_wxcaret_getposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_wxcaret_getsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxcaret_getwindow:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxcaret_hide(handle:Byte Ptr)
	Function bmx_wxcaret_isok:Int(handle:Byte Ptr)
	Function bmx_wxcaret_isvisible:Int(handle:Byte Ptr)
	Function bmx_wxcaret_move(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxcaret_setblinktime(milliseconds:Int)
	Function bmx_wxcaret_setsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxcaret_show(handle:Byte Ptr, _show:Int)

	Function bmx_wxfindwindowatpoint:Byte Ptr(x:Int, y:Int)
	Function bmx_wxfindwindowatpointer:Byte Ptr(x:Int Ptr, y:Int Ptr)
	Function bmx_wxgetactivewindow:Byte Ptr()

	Function bmx_wxgridbagsizer_create:Byte Ptr(handle:Object, vgap:Int, hgap:Int)
	Function bmx_wxgridbagsizer_add:Byte Ptr(handle:Byte Ptr, window:Byte Ptr, row:Int, col:Int, rowspan:Int, colspan:Int, flag:Int, border:Int)
	Function bmx_wxgridbagsizer_addsizer:Byte Ptr(handle:Byte Ptr, sizer:Byte Ptr, row:Int, col:Int, rowspan:Int, colspan:Int, flag:Int, border:Int)
	Function bmx_wxgridbagsizer_addspacer:Byte Ptr(handle:Byte Ptr, width:Int, height:Int, row:Int, col:Int, rowspan:Int, colspan:Int, flag:Int, border:Int)
	Function bmx_wxgridbagsizer_addgbsizeritem:Byte Ptr(handle:Byte Ptr, item:Byte Ptr)
	Function bmx_wxgridbagsizer_checkforintersection:Int(handle:Byte Ptr, item:Byte Ptr, excludeItem:Byte Ptr)
	Function bmx_wxgridbagsizer_checkforintersectionpos:Int(handle:Byte Ptr, row:Int, col:Int, rowspan:Int, colspan:Int, excludeItem:Byte Ptr)
	Function bmx_wxgridbagsizer_getcellsize(handle:Byte Ptr, row:Int, col:Int, width:Int Ptr, height:Int Ptr)
	Function bmx_wxgridbagsizer_getemptycellsize(handle:Byte Ptr, width:Int Ptr, height:Int Ptr)
	Function bmx_wxgridbagsizer_getitempositionwindow(handle:Byte Ptr, window:Byte Ptr, row:Int Ptr, col:Int Ptr)
	Function bmx_wxgridbagsizer_getitempositionsizer(handle:Byte Ptr, sizer:Byte Ptr, row:Int Ptr, col:Int Ptr)
	Function bmx_wxgridbagsizer_getitemposition(handle:Byte Ptr, index:Int, row:Int Ptr, col:Int Ptr)
	Function bmx_wxgridbagsizer_getitemspanwindow(handle:Byte Ptr, window:Byte Ptr, rowspan:Int Ptr, colspan:Int Ptr)
	Function bmx_wxgridbagsizer_getitemspansizer(handle:Byte Ptr, sizer:Byte Ptr, rowspan:Int Ptr, colspan:Int Ptr)
	Function bmx_wxgridbagsizer_getitemspan(handle:Byte Ptr, index:Int, rowspan:Int Ptr, colspan:Int Ptr)
	Function bmx_wxgridbagsizer_setemptycellsize(handle:Byte Ptr, width:Int, height:Int)
	Function bmx_wxgridbagsizer_setitempositionwindow:Int(handle:Byte Ptr, window:Byte Ptr, row:Int, col:Int)
	Function bmx_wxgridbagsizer_setitempositionsizer:Int(handle:Byte Ptr, sizer:Byte Ptr, row:Int, col:Int)
	Function bmx_wxgridbagsizer_setitemposition:Int(handle:Byte Ptr, index:Int, row:Int, col:Int)
	Function bmx_wxgridbagsizer_setitemspanwindow:Int(handle:Byte Ptr, window:Byte Ptr, rowspan:Int, colspan:Int)
	Function bmx_wxgridbagsizer_setitemspansizer:Int(handle:Byte Ptr, sizer:Byte Ptr, rowspan:Int, colspan:Int)
	Function bmx_wxgridbagsizer_setitemspan:Int(handle:Byte Ptr, index:Int, rowspan:Int, colspan:Int)
	Function bmx_wxgridbagsizer_finditemwindow:Byte Ptr(handle:Byte Ptr, window:Byte Ptr)
	Function bmx_wxgridbagsizer_finditemsizer:Byte Ptr(handle:Byte Ptr, sizer:Byte Ptr)
	Function bmx_wxgridbagsizer_finditematpoint:Byte Ptr(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_wxgridbagsizer_finditematposition:Byte Ptr(handle:Byte Ptr, row:Int, col:Int)

	Function bmx_wxwindow_setvalidator(handle:Byte Ptr, validator:Byte Ptr)

	Function bmx_wxsizer_addresourcehandler()

	Function bmx_wxwindowdestroyevent_getwindow:Byte Ptr(handle:Byte Ptr)

End Extern


Const wxEVT_SET_FOCUS:Int = 112
Const wxEVT_KILL_FOCUS:Int = 113

' Clipboard events
Const wxEVT_COMMAND_TEXT_COPY:Int = 444
Const wxEVT_COMMAND_TEXT_CUT:Int = 445
Const wxEVT_COMMAND_TEXT_PASTE:Int = 446
Const wxEVT_TEXT_COPY:Int = wxEVT_COMMAND_TEXT_COPY
Const wxEVT_TEXT_CUT:Int = wxEVT_COMMAND_TEXT_CUT
Const wxEVT_TEXT_PASTE:Int = wxEVT_COMMAND_TEXT_PASTE

Rem
bbdoc: Background is erased in the EVT_ERASE_BACKGROUND handler or using the system default background if no such handler is defined (this is the default style)
End Rem
Const wxBG_STYLE_ERASE:Int = 0
Rem
bbdoc: Background is erased by the system, no EVT_ERASE_BACKGROUND event is generated at all
End Rem
Const wxBG_STYLE_SYSTEM:Int = 1
Rem
bbdoc: Background is erased in EVT_PAINT handler and not erased at all before it, this should be used if the paint handler paints over the entire window to avoid flicker
End Rem
Const wxBG_STYLE_PAINT:Int = 2
Rem
bbdoc: This is a Mac-only style, don't use in portable code
End Rem
Const wxBG_STYLE_TRANSPARENT:Int = 3
Rem
bbdoc: This style is deprecated and doesn't do anything, don't use
End Rem
Const wxBG_STYLE_COLOUR:Int = 4
Rem
bbdoc: This style is deprecated and is synonymous with wxBG_STYLE_PAINT, use the new name.
End Rem
Const wxBG_STYLE_CUSTOM:Int = wxBG_STYLE_PAINT

Const wxFLEX_GROWMODE_NONE:Int = 0
Const wxFLEX_GROWMODE_SPECIFIED:Int = 1
Const wxFLEX_GROWMODE_ALL:Int = 2

Const wxWINDOW_VARIANT_NORMAL:Int = 0
Const wxWINDOW_VARIANT_SMALL:Int = 1
Const wxWINDOW_VARIANT_MINI:Int = 2
Const wxWINDOW_VARIANT_LARGE:Int = 3
Const wxWINDOW_VARIANT_MAX:Int = 4

Rem
bbdo: By Default, TransferDataTo/FromWindow() only work on direct children of the window (compatible behaviour).
about: Set this flag To make them recursively descend into all subwindows
End Rem
Const wxWS_EX_VALIDATE_RECURSIVELY:Int = $00000001

Rem
bbdoc: wxCommandEvents And the objects of the derived classes are forwarded To the parent window And so on recursively by Default.
about: Using this flag For the given window allows To block this propagation at this window,
i.e. prevent the events from being propagated further upwards. The dialogs have this 
flag on by Default.
End Rem
Const wxWS_EX_BLOCK_EVENTS:Int = $00000002

Rem
bbdoc: Don't use this window as an implicit parent for the other windows.
about: This must be used with transient windows as otherwise there is the risk of creating a
dialog/frame with this window as a parent which would lead to a crash if the
parent is destroyed before the child
End Rem
Const  wxWS_EX_TRANSIENT:Int = $00000004

Rem
bbdoc: Don't paint the window background, we'll assume it will be done by a theming engine.
about: This is not yet used but could possibly be made to work in the future, at least on
Windows.
End Rem
Const wxWS_EX_THEMED_BACKGROUND:Int = $00000008

Rem
bbdoc: This window should always process idle events
End Rem
Const wxWS_EX_PROCESS_IDLE:Int = $00000010

Rem
bbdoc: This window should always process UI update events
End Rem
Const wxWS_EX_PROCESS_UI_UPDATES:Int = $00000020

Rem
bbdoc: Use this style to add a context-sensitive help to the window.
about: Currently for Win32 only and it doesn't work if wxMINIMIZE_BOX or wxMAXIMIZE_BOX are used.

End Rem
Const wxWS_EX_CONTEXTHELP:Int = $00000080

Rem
bbdoc: Don't generate any touch events.
End Rem
Const wxTOUCH_NONE:Int = $0000
Rem
bbdoc: Generate #wxPanGestureEvent for vertical pans.
about: Note that under macOS horizontal pan events are also enabled when this flag is specified.
End Rem
Const wxTOUCH_VERTICAL_PAN_GESTURE:Int = $0001
Rem
bbdoc: Generate #wxPanGestureEvent for horizontal pans.
about: Note that under macOS vertical pan events are also enabled when this flag is specified.
End Rem
Const wxTOUCH_HORIZONTAL_PAN_GESTURE:Int = $0002
Rem
bbdoc: Generate #wxPanGestureEvent for any pans.
about: This is just a convenient combination of #wxTOUCH_VERTICAL_PAN_GESTURE and #wxTOUCH_HORIZONTAL_PAN_GESTURE
End Rem
Const wxTOUCH_PAN_GESTURES:Int = wxTOUCH_VERTICAL_PAN_GESTURE | wxTOUCH_HORIZONTAL_PAN_GESTURE
Rem
bbdoc: Generate #wxZoomGestureEvent.
End Rem
Const wxTOUCH_ZOOM_GESTURE:Int = $0004
Rem
bbdoc: Generate #wxRotateGestureEvent.
End Rem
Const wxTOUCH_ROTATE_GESTURE:Int = $0008
Rem
bbdoc: Generate events for press or tap gestures such as #wxTwoFingerTapEvent, #wxLongPressEvent and #wxPressAndTapEvent.
End Rem
Const wxTOUCH_PRESS_GESTURES:Int = $0010
Rem
bbdoc: Enable all supported gesture events.
End Rem
Const wxTOUCH_ALL_GESTURES:Int = $001F

Rem
bbdoc: No effect, equivalent to normal #wxWindow.Show() or #Hide() call.
End Rem
Const wxSHOW_EFFECT_NONE:Int = 0
Rem
bbdoc: Roll window to the left.
End Rem
Const wxSHOW_EFFECT_ROLL_TO_LEFT:Int = 1
Rem
bbdoc: Roll window to the right.
End Rem
Const wxSHOW_EFFECT_ROLL_TO_RIGHT:Int = 2
Rem
bbdoc: Roll window to the top.
End Rem
Const wxSHOW_EFFECT_ROLL_TO_TOP:Int = 3
Rem
bbdoc: Roll window to the bottom.
End Rem
Const wxSHOW_EFFECT_ROLL_TO_BOTTOM:Int = 4
Rem
bbdoc: Slide window to the left.
End Rem
Const wxSHOW_EFFECT_SLIDE_TO_LEFT:Int = 5
Rem
bbdoc: Slide window to the right.
End Rem
Const wxSHOW_EFFECT_SLIDE_TO_RIGHT:Int = 6
Rem
bbdoc: Slide window to the top.
End Rem
Const wxSHOW_EFFECT_SLIDE_TO_TOP:Int = 7
Rem
bbdoc: Slide window to the bottom.
End Rem
Const wxSHOW_EFFECT_SLIDE_TO_BOTTOM:Int = 8
Rem
bbdoc: Fade in or out effect.
End Rem
Const wxSHOW_EFFECT_BLEND:Int = 9
Rem
bbdoc: Expanding or collapsing effect.
End Rem
Const wxSHOW_EFFECT_EXPAND:Int = 10
