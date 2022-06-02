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

#ifndef _WX_MAX_WINDOW_H_
#define _WX_MAX_WINDOW_H_


#include "wxglue.h"
#include "wx/tooltip.h"
#include "wx/caret.h"
#include "../wxcursor.mod/glue.h"
#include "../wxacceleratortable.mod/glue.h"
#include "wx/gbsizer.h"
#include "wx/xrc/xh_sizer.h"
#include "wx/tokenzr.h"
#include "wx/xml/xml.h"

class MaxWindow;
class MaxBoxSizer;
class MaxGridSizer;
class MaxFlexGridSizer;
class MaxGridBagSizer;


extern "C" {

#include <blitz.h>

	BBArray * CB_PREF(wx_wxwindow_wxWindow__newwindowarray)(int size);
	void CB_PREF(wx_wxwindow_wxWindow__setwindow)(BBArray * array, int index, wxWindow * window);
	BBArray * CB_PREF(wx_wxwindow_wxSizer__newsizeritemsarray)(int size);
	void CB_PREF(wx_wxwindow_wxSizer__setsizeritem)(BBArray * array, int index, wxSizerItem * item);

	BBObject * CB_PREF(wx_wxwindow_wxGridSizer__xrcNew)(wxSizer * sizer);
	BBObject * CB_PREF(wx_wxwindow_wxBoxSizer__xrcNew)(wxSizer * sizer);
	BBObject * CB_PREF(wx_wxwindow_wxFlexGridSizer__xrcNew)(wxSizer * sizer);
	BBObject * CB_PREF(wx_wxwindow_wxGridBagSizer__xrcNew)(wxSizer * sizer);

	MaxWindow * bmx_wxwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style);
	int bmx_wxwindow_show(wxWindow * window, int value);
	int bmx_wxwindow_close(wxWindow * window, int force);
	void bmx_wxwindow_setsizer(wxWindow * window, wxSizer * sizer, int deleteOld);
	void bmx_wxwindow_setautolayout(wxWindow * window, int autoLayout);
	void bmx_wxwindow_delete(wxWindow * window);
	wxSizer * bmx_wxwindow_getsizer(wxWindow * window);
	void bmx_wxwindow_layout(wxWindow * window);
	int bmx_wxwindow_getwindowstyleflag(wxWindow * window);
	void bmx_wxwindow_getbestsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_setfocus(wxWindow * window);
	void bmx_wxwindow_clearbackground(wxWindow * window);
	void bmx_wxwindow_clienttoscreen(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_setbackgroundcolour(wxWindow * window, MaxColour * colour);
	void bmx_wxwindow_setforegroundcolour(wxWindow * window, MaxColour * colour);
	int bmx_wxwindow_setfont(wxWindow * window, MaxFont * font);
	MaxFont * bmx_wxwindow_getfont(wxWindow * window);
	BBString * bmx_wxwindow_gethelptext(wxWindow * window);
	int bmx_wxwindow_getid(wxWindow * window);
	BBString * bmx_wxwindow_getlabel(wxWindow * window);
	void bmx_wxwindow_preparedc(wxWindow * window, MaxDC * dc);
	void bmx_wxwindow_refresh(wxWindow * window, int erase);
	wxWindow * bmx_wxwindow_getparent(wxWindow * window);
	int bmx_wxwindow_getscrollpos(wxWindow * window, int orientation);
	int bmx_wxwindow_getscrollrange(wxWindow * window, int orientation);
	int bmx_wxwindow_getscrollthumb(wxWindow * window, int orientation);
	int bmx_wxwindow_getcharheight(wxWindow * window);
	int bmx_wxwindow_getcharwidth(wxWindow * window);
	void bmx_wxwindow_getclientsize(wxWindow * window, int * width, int * height);
	MaxColour * bmx_wxwindow_getforegroundcolour(wxWindow * window);
	wxWindow * bmx_wxwindow_getgrandparent(wxWindow * window);

	BBString * bmx_wxwindow_gethelptextatpoint(wxWindow * window, int x, int y, wxHelpEvent::Origin origin);
	void bmx_wxwindow_getmaxsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_getminsize(wxWindow * window, int * w, int * h);
	BBString * bmx_wxwindow_getname(wxWindow * window);
	void bmx_wxwindow_getposition(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_getrect(wxWindow * window, int * x, int * y, int * w, int * h);
	void bmx_wxwindow_getscreenposition(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_getscreenrect(wxWindow * window, int * x, int * y, int * w, int * h);
	MaxRect * bmx_wxwindow_getrectrect(wxWindow * window);
	MaxRect * bmx_wxwindow_getscreenrectrect(wxWindow * window);
	void bmx_wxwindow_getsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_sethelptext(wxWindow * window, BBString * helpText);
	void bmx_wxwindow_setid(wxWindow * window, int id);
	void bmx_wxwindow_setlabel(wxWindow * window, BBString * label);
	void bmx_wxwindow_setscrollbar(wxWindow * window, int orientation, int position, int thumbsize, int range, int refresh);
	void bmx_wxwindow_setscrollpos(wxWindow * window, int orientation, int pos, int refresh);
	
	void bmx_wxwindow_setcursor(wxWindow * window, MaxCursor * cursor);
	void bmx_wxwindow_setwindowstyle(wxWindow * window, int style);
	void bmx_wxwindow_setwindowstyleflag(wxWindow * window, int style);
	int bmx_wxwindow_hide(wxWindow * window);
	void bmx_wxwindow_move(wxWindow * window, int x, int y);
	void bmx_wxwindow_setdimensions(wxWindow * window, int x, int y, int w, int h, int flags);
	void bmx_wxwindow_setdimensionsrect(wxWindow * window, MaxRect * rect);
	void bmx_wxwindow_pusheventhandler(wxWindow * window, wxEvtHandler * evt);

	wxWindowVariant bmx_wxwindow_getwindowvariant(wxWindow * window);
	int bmx_wxwindow_hascapture(wxWindow * window);
	int bmx_wxwindow_hasflag(wxWindow * window, int flag);
	int bmx_wxwindow_hasmultiplepages(wxWindow * window);
	int bmx_wxwindow_hastransparentbackground(wxWindow * window);
	int bmx_wxwindow_hasscrollbar(wxWindow * window, int orient);
	void bmx_wxwindow_inheritattributes(wxWindow * window);
	void bmx_wxwindow_initdialog(wxWindow * window);
	void bmx_wxwindow_invalidatebestsize(wxWindow * window);
	int bmx_wxwindow_isdoublebuffered(wxWindow * window);
	int bmx_wxwindow_isenabled(wxWindow * window);
	int bmx_wxwindow_isexposed(wxWindow * window, int x, int y, int w, int h);
	int bmx_wxwindow_isexposedrect(wxWindow * window, MaxRect * rect);
	int bmx_wxwindow_isfrozen(wxWindow * window);
	int bmx_wxwindow_isretained(wxWindow * window);
	int bmx_wxwindow_isshown(wxWindow * window);
	int bmx_wxwindow_isshownonscreen(wxWindow * window);
	int bmx_wxwindow_istoplevel(wxWindow * window);
	int bmx_wxwindow_reparent(wxWindow * window, wxWindow * parent);

	int bmx_wxwindow_destroy(wxWindow * window);
	void bmx_wxwindow_destroyChildren(wxWindow * window);
	int bmx_wxwindow_disable(wxWindow * window);
	void bmx_wxwindow_dragacceptfiles(wxWindow * window, int accept);
	int bmx_wxwindow_enable(wxWindow * window, int value);
	int bmx_wxwindow_enabletouchevents(wxWindow * window, int eventMask);
	void bmx_wxwindow_fit(wxWindow * window);
	void bmx_wxwindow_fitinside(wxWindow * window);
	void bmx_wxwindow_freeze(wxWindow * window);
	MaxColour * bmx_wxwindow_getbackgroundcolour(wxWindow * window);
	int bmx_wxwindow_getbackgroundstyle(wxWindow * window);
	double bmx_wxwindow_getcontentscalefactor(wxWindow * window);
	void bmx_wxwindow_geteffectiveminsize(wxWindow * window, int * w, int * h);
	void bmx_wxwindow_capturemouse(wxWindow * window);
	void bmx_wxwindow_centre(wxWindow * window, int direction);
	void bmx_wxwindow_centreonparent(wxWindow * window, int direction);
	int bmx_wxwindow_popupmenu(wxWindow * window, wxMenu * menu, int x, int y);
	void bmx_wxwindow_refreshrect(wxWindow * window, int x, int y, int w, int h, int erase);
	void bmx_wxwindow_refreshrectrect(wxWindow * window, MaxRect * rect, int erase);
	void bmx_wxwindow_releasemouse(wxWindow * window);
	void bmx_wxwindow_screentoclient(wxWindow * window, int * x, int * y);
	void bmx_wxwindow_setsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setposition(wxWindow * window, int x, int y);

	void * bmx_wxwindow_gethandle(wxWindow * window);
	int bmx_wxwindow_linedown(wxWindow * window);
	int bmx_wxwindow_lineup(wxWindow * window);
	void bmx_wxwindow_lower(wxWindow * window);
	void bmx_wxwindow_moveafterintaborder(wxWindow * window, wxWindow * win);
	void bmx_wxwindow_movebeforeintaborder(wxWindow * window, wxWindow * win);
	int bmx_wxwindow_pagedown(wxWindow * window);
	int bmx_wxwindow_pageup(wxWindow * window);
	wxEvtHandler * bmx_wxwindow_popeventhandler(wxWindow * window, int deleteHandler);
	void bmx_wxwindow_raise(wxWindow * window);
	int bmx_wxwindow_removeeventhandler(wxWindow * window, wxEvtHandler * handler);
	void bmx_wxwindow_setbackgroundstyle(wxWindow * window, wxBackgroundStyle style);
	void bmx_wxwindow_setinitialsize(wxWindow * window, int w, int h);
	void bmx_wxwindow_setclientsize(wxWindow * window, int w, int h);
	void bmx_wxwindow_setcontainingsizer(wxWindow * window, wxSizer * sizer);
	//void bmx_wxwindow_setinitialbestsize(wxWindow * window, int w, int h);
	void bmx_wxwindow_seteventhandler(wxWindow * window, wxEvtHandler * handler);
	void bmx_wxwindow_setextrastyle(wxWindow * window, int style);
	void bmx_wxwindow_setmaxsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setminsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setname(wxWindow * window, BBString * name);
	void bmx_wxwindow_setownbackgroundcolour(wxWindow * window, MaxColour * colour);
	void bmx_wxwindow_setownfont(wxWindow * window, MaxFont * font);
	void bmx_wxwindow_setownforegroundcolour(wxWindow * window, MaxColour * colour);

	wxWindow * bmx_wxwindow_findfocus();
	void bmx_wxwindow_thaw(wxWindow * window);
	int bmx_wxwindow_togglewindowstyle(wxWindow * window, int flag);
	int bmx_wxwindow_transferdatafromwindow(wxWindow * window);
	int bmx_wxwindow_transferdatatowindow(wxWindow * window);
	void bmx_wxwindow_udpate(wxWindow * window);
	void bmx_wxwindow_updatewindowui(wxWindow * window, int flags);
	int bmx_wxwindow_validate(wxWindow * window);
	void bmx_wxwindow_setsizerandfit(wxWindow * window, wxSizer * sizer, int deleteOld);
	void bmx_wxwindow_setthemeenabled(wxWindow * window, int enable);
	void bmx_wxwindow_settooltip(wxWindow * window, BBString * tip);
	void bmx_wxwindow_setvirtualsize(wxWindow * window, int width, int height);
	void bmx_wxwindow_setminclientsize(wxWindow * window, int minW, int minH);
	void bmx_wxwindow_setmaxclientsize(wxWindow * window, int maxW, int maxH);
	
	BBArray * bmx_wxwindow_getchildren(wxWindow * window);
	void bmx_wxwindow_convertdialogtopixels(wxWindow * window, int dx, int dy, int * px, int  * py);
	void bmx_wxwindow_convertpixelstodialog(wxWindow * window, int px, int py, int * dx, int * dy);
	wxWindow * bmx_wxwindow_findwindow(wxWindow * window, int id);
	wxWindow * bmx_wxwindow_findwindowbyid(int id, wxWindow * parent);
	wxWindow * bmx_wxwindow_findwindowbyname(BBString * name, wxWindow * parent);
	wxWindow * bmx_wxwindow_findwindowbylabel(BBString * label, wxWindow * parent);
	wxWindow * bmx_wxwindow_getcapture();
	wxCaret * bmx_wxwindow_getcaret(wxWindow * window);
	wxSizer * bmx_wxwindow_getcontainingsizer(wxWindow * window);
	MaxCursor * bmx_wxwindow_getcursor(wxWindow * window);
	int bmx_wxwindow_getextrastyle(wxWindow * window);
	wxEvtHandler * bmx_wxwindow_geteventhandler(wxWindow * window);
	void bmx_wxwindow_gettextextent(wxWindow * window, BBString * text, int * x, int * y, int * descent, int * externalLeading, MaxFont * font, int use16);
	void bmx_wxwindow_getvirtualsize(wxWindow * window, int * width, int * height);
	void bmx_wxwindow_getwindowbordersize(wxWindow * window, int * leftRight, int * topBottom);
	void bmx_wxwindow_navigate(wxWindow * window, int flags);
	int bmx_wxwindow_registerhotkey(wxWindow * window, int hotKeyId, int modifiers, int virtualKeyCode);
	int bmx_wxwindow_scrolllines(wxWindow * window, int lines);
	int bmx_wxwindow_scrollpages(wxWindow * window, int pages);
	void bmx_wxwindow_setcaret(wxWindow * window, wxCaret * caret);
	void bmx_wxwindow_setwindowvariant(wxWindow * window, wxWindowVariant variant);
	int bmx_wxwindow_unregisterhotkey(wxWindow * window, int hotKeyId);
	void bmx_wxwindow_warppointer(wxWindow * window, int x, int y);

	wxDropTarget * bmx_wxwindow_getdroptarget(wxWindow * window);
	void bmx_wxwindow_setdroptarget(wxWindow * window, wxDropTarget * target);
	wxToolTip * bmx_wxwindow_gettooltip(wxWindow * window);
	void bmx_wxwindow_scrollwindow(wxWindow * window, int dx, int dy, int x, int y, int w, int h);
	void bmx_wxwindow_scrollwindowrect(wxWindow * window, int dx, int dy, MaxRect * rect);

	MaxAcceleratorTable * bmx_wxwindow_getacceleratortable(wxWindow * window);
	void bmx_wxwindow_setacceleratortable(wxWindow * window, MaxAcceleratorTable * table);

	void bmx_wxwindow_alwaysshowscrollbars(wxWindow * window, int hflag, int vflag);
	int bmx_wxwindow_beginrepositioningchildren(wxWindow * window);
	int bmx_wxwindow_canacceptfocus(wxWindow * window);
	int bmx_wxwindow_canacceptfocusfromkeyboard(wxWindow * window);
	int bmx_wxwindow_canscroll(wxWindow * window, int orient);
	int bmx_wxwindow_cansettransparent(wxWindow * window);
	void bmx_wxwindow_endrepositioningchildren(wxWindow * window);

	void bmx_wxwindow_fromdippoint(wxWindow * window, int x, int y, int * px, int * py);
	void bmx_wxwindow_fromdipsize(wxWindow * window, int w, int h, int * sw, int * sh);
	int bmx_wxwindow_fromdip(wxWindow * window, int d);
	int bmx_wxwindow_todip(wxWindow * window, int d);
	void bmx_wxwindow_todipsize(wxWindow * window, int w, int h, int * sw, int * sh);
	void bmx_wxwindow_todippoint(wxWindow * window, int x, int y, int * px, int * py);
	void bmx_wxwindow_unsettooltip(wxWindow * window);
	int bmx_window_showwitheffect(wxWindow * window, int effect, int timeout);
	int bmx_window_hidewitheffect(wxWindow * window, int effect, int timeout);

	MaxBoxSizer * bmx_wxboxsizer_create(BBObject * maxHandle, int orient);
	wxSizerItem * bmx_wxsizer_add(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_addsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border);
	int bmx_wxsizer_detach(wxSizer * sizer, wxWindow * window);
	int bmx_wxsizer_detachsizer(wxSizer * sizer, wxSizer * sz);
	wxSizerItem * bmx_wxsizer_insert(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_insertsizer(wxSizer * sizer, int index, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_addcustomspacer(wxSizer * sizer, int width, int height, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_addspacer(wxSizer * sizer, int size);
	wxSizerItem * bmx_wxsizer_addstretchspacer(wxSizer * sizer, int prop);
	void bmx_wxsizer_setitemminsize(wxSizer * sizer, int index, int width, int height);
	void bmx_wxsizer_setitemminsizewindow(wxSizer * sizer, wxWindow * window, int width, int height);
	void bmx_wxsizer_setitemminsizesizer(wxSizer * sizer, wxSizer * sz, int width, int height);
	void bmx_wxsizer_clear(wxSizer * sizer, int deleteWindows);
	void bmx_wxsizer_fitinside(wxSizer * sizer, wxWindow * window);
	wxWindow * bmx_wxsizer_getcontainingwindow(wxSizer * sizer);
	void bmx_wxsizer_getsize(wxSizer * sizer, int * w, int * h);
	void bmx_wxsizer_getposition(wxSizer * sizer, int * x, int * y);
	void bmx_wxsizer_getminsize(wxSizer * sizer, int * w, int * h);
	int bmx_wxsizer_show(wxSizer * sizer, wxWindow * window, int doShow, int recursive);
	int bmx_wxsizer_showsizer(wxSizer * sizer, wxSizer * s, int doShow, int recursive);
	int bmx_wxsizer_showitem(wxSizer * sizer, int index, int doShow);
	MaxGridSizer * bmx_wxgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap);
	MaxGridSizer * bmx_wxgridsizer_createrc(BBObject * maxHandle, int rows, int cols, int vgap, int hgap);
	int bmx_wxgridsizer_getcols(MaxGridSizer * sizer);
	int bmx_wxgridsizer_gethgap(MaxGridSizer * sizer);
	int bmx_wxgridsizer_getrows(MaxGridSizer * sizer);
	int bmx_wxgridsizer_getvgap(MaxGridSizer * sizer);
	void bmx_wxgridsizer_setcols(MaxGridSizer * sizer, int cols);
	void bmx_wxgridsizer_sethgap(MaxGridSizer * sizer, int hgap);
	void bmx_wxgridsizer_setrows(MaxGridSizer * sizer, int rows);
	void bmx_wxgridsizer_setvgap(MaxGridSizer * sizer, int vgap);
	void bmx_wxsizer_setsizehints(wxSizer * sizer, wxWindow * window);
	MaxFlexGridSizer * bmx_wxflexgridsizer_create(BBObject * maxHandle, int cols, int vgap, int hgap);
	MaxFlexGridSizer * bmx_wxflexgridsizer_createrc(BBObject * maxHandle, int rows, int cols, int vgap, int hgap);
	void bmx_wxflexgridsizer_addgrowablecol(wxFlexGridSizer * sizer, int index, int prop);
	void bmx_wxflexgridsizer_addgrowablerow(wxFlexGridSizer * sizer, int index, int prop);
	void bmx_wxsizer_fit(wxSizer * sizer, wxWindow * window);
	void bmx_wxsizer_fitsize(wxSizer * sizer, wxWindow * window, int * w, int * h);
	int bmx_wxboxsizer_getorientation(wxBoxSizer * sizer);
	int bmx_wxsizer_isshown(wxSizer * sizer, int index);
	void bmx_wxsizer_layout(wxSizer * sizer);
	void bmx_wxsizer_recalcsizes(wxSizer * sizer);
	BBArray * bmx_wxsizer_getchildren(wxSizer * sizer);

	wxSizerItem * bmx_wxsizer_insertspacer(wxSizer * sizer, int index, int size);
	wxSizerItem * bmx_wxsizer_insertstretchspacer(wxSizer * sizer, int index, int prop);
	int bmx_wxsizer_iswindowshown(wxSizer * sizer, wxWindow * window);
	int bmx_wxsizer_issizershown(wxSizer * sizer, wxSizer * sz);
	void bmx_wxsizer_setdimension(wxSizer * sizer, int x, int y, int width, int height);
	void bmx_wxsizer_setminsize(wxSizer * sizer, int width, int height);
	wxSizerItem * bmx_wxsizer_prepend(wxSizer * sizer, wxWindow * window, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_prependsizer(wxSizer * sizer, wxSizer * sz, int proportion, int flag, int border);
	wxSizerItem * bmx_wxsizer_prependspacer(wxSizer * sizer, int size);
	wxSizerItem * bmx_wxsizer_prependstretchspacer(wxSizer * sizer, int prop);
	int bmx_wxsizer_removesizer(wxSizer * sizer, wxSizer * sz);
	int bmx_wxsizer_remove(wxSizer * sizer, int index);
	int bmx_wxsizer_replacewindow(wxSizer * sizer, wxWindow * oldWin, wxWindow * newWin, int recursive);
	int bmx_wxsizer_replacesizer(wxSizer * sizer, wxSizer * oldsz, wxSizer * newsz, int recursive);
	int bmx_wxsizer_replace(wxSizer * sizer, int oldIndex, wxSizerItem * newItem);
	int bmx_wxsizer_getitemcount(wxSizer * sizer);
	int bmx_wxsizer_isempty(wxSizer * sizer);

	int bmx_wxflexgridsizer_getflexibledirection(wxFlexGridSizer * sizer);
	int bmx_wxflexgridsizer_getnonflexiblegrowmode(wxFlexGridSizer * sizer);
	void bmx_wxflexgridsizer_removegrowablecol(wxFlexGridSizer * sizer, int idx);
	void bmx_wxflexgridsizer_removegrowablerow(wxFlexGridSizer * sizer, int idx);
	void bmx_wxflexgridsizer_setflexibledirection(wxFlexGridSizer * sizer, int direction);
	void bmx_wxflexgridsizer_setnonflexiblegrowmode(wxFlexGridSizer * sizer, wxFlexSizerGrowMode mode);

	void bmx_wxtooltip_enable(int flag);
	void bmx_wxtooltip_setdelay(int msecs);
	void bmx_wxtooltip_settip(wxToolTip * tip, BBString * text);
	BBString * bmx_wxtooltip_gettip(wxToolTip * tip);
	wxWindow * bmx_wxtooltip_getwindow(wxToolTip * tip);

	int bmx_wxupdateeventui_canupdate(wxWindow * window);
	int bmx_wxupdateeventui_getchecked(wxUpdateUIEvent & event);
	int bmx_wxupdateeventui_getenabled(wxUpdateUIEvent & event);
	int bmx_wxupdateeventui_getshown(wxUpdateUIEvent & event);
	BBString * bmx_wxupdateeventui_gettext(wxUpdateUIEvent & event);
	wxUpdateUIMode bmx_wxupdateeventui_getmode();
	int bmx_wxupdateeventui_getupdateinterval();
	void bmx_wxupdateeventui_setmode(wxUpdateUIMode mode);
	void bmx_wxupdateeventui_settext(wxUpdateUIEvent & event, BBString * text);
	void bmx_wxupdateeventui_setupdateinterval(int interval);

	wxIdleMode bmx_wxidleevent_getmode();
	void bmx_wxidleevent_requestmore(wxIdleEvent & event, int needMore);
	int bmx_wxidleevent_morerequested(wxIdleEvent & event);
	void bmx_wxidleevent_setmode(wxIdleMode mode);

	wxWindow * bmx_wxfocusevent_getwindow(wxFocusEvent & event);

	MaxCursor * bmx_wxsetcursorevent_getcursor(wxSetCursorEvent & event);
	int bmx_wxsetcursorevent_getx(wxSetCursorEvent & event);
	int bmx_wxsetcursorevent_gety(wxSetCursorEvent & event);
	int bmx_wxsetcursorevent_hascursor(wxSetCursorEvent & event);
	void bmx_wxsetcursorevent_setcursor(wxSetCursorEvent & event, MaxCursor * cursor);

	MaxDC * bmx_wxeraseevent_getdc(wxEraseEvent & event);

	wxCaret * bmx_wxcaret_create(wxWindow * window, int width, int height);
	int bmx_wxcaret_getblinktime();
	void bmx_wxcaret_getposition(wxCaret * caret, int * x, int * y);
	void bmx_wxcaret_getsize(wxCaret * caret, int * width, int * height);
	wxWindow * bmx_wxcaret_getwindow(wxCaret * caret);
	void bmx_wxcaret_hide(wxCaret * caret);
	int bmx_wxcaret_isok(wxCaret * caret);
	int bmx_wxcaret_isvisible(wxCaret * caret);
	void bmx_wxcaret_move(wxCaret * caret, int x, int y);
	void bmx_wxcaret_setblinktime(int milliseconds);
	void bmx_wxcaret_setsize(wxCaret * caret, int width, int height);
	void bmx_wxcaret_show(wxCaret * caret, int _show);

	wxWindow * bmx_wxfindwindowatpoint(int x, int y);
	wxWindow * bmx_wxfindwindowatpointer(int * x, int * y);
	wxWindow * bmx_wxgetactivewindow();

	wxGridBagSizer * bmx_wxgridbagsizer_create(BBObject * handle, int vgap, int hgap);
	wxSizerItem * bmx_wxgridbagsizer_add(wxGridBagSizer * gb, wxWindow * window, int row, int col, int rowspan, int colspan, int flag, int border);
	wxSizerItem * bmx_wxgridbagsizer_addsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col, int rowspan, int colspan, int flag, int border);
	wxSizerItem * bmx_wxgridbagsizer_addspacer(wxGridBagSizer * gb, int width, int height, int row, int col, int rowspan, int colspan, int flag, int border);
	wxSizerItem * bmx_wxgridbagsizer_addgbsizeritem(wxGridBagSizer * gb, wxGBSizerItem * item);
	int bmx_wxgridbagsizer_checkforintersection(wxGridBagSizer * gb, wxGBSizerItem * item, wxGBSizerItem * excludeItem);
	int bmx_wxgridbagsizer_checkforintersectionpos(wxGridBagSizer * gb, int row, int col, int rowspan, int colspan, wxGBSizerItem * excludeItem);
	void bmx_wxgridbagsizer_getcellsize(wxGridBagSizer * gb, int row, int col, int * width, int * height);
	void bmx_wxgridbagsizer_getemptycellsize(wxGridBagSizer * gb, int * width, int * height);
	void bmx_wxgridbagsizer_getitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int * row, int * col);
	void bmx_wxgridbagsizer_getitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int * row, int * col);
	void bmx_wxgridbagsizer_getitemposition(wxGridBagSizer * gb, int index, int * row, int * col);
	void bmx_wxgridbagsizer_getitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int * rowspan, int * colspan);
	void bmx_wxgridbagsizer_getitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int * rowspan, int * colspan);
	void bmx_wxgridbagsizer_getitemspan(wxGridBagSizer * gb, int index, int * rowspan, int * colspan);
	void bmx_wxgridbagsizer_setemptycellsize(wxGridBagSizer * gb, int width, int height);
	int bmx_wxgridbagsizer_setitempositionwindow(wxGridBagSizer * gb, wxWindow * window, int row, int col);
	int bmx_wxgridbagsizer_setitempositionsizer(wxGridBagSizer * gb, wxSizer * sizer, int row, int col);
	int bmx_wxgridbagsizer_setitemposition(wxGridBagSizer * gb, int index, int row, int col);
	int bmx_wxgridbagsizer_setitemspanwindow(wxGridBagSizer * gb, wxWindow * window, int rowspan, int colspan);
	int bmx_wxgridbagsizer_setitemspansizer(wxGridBagSizer * gb, wxSizer * sizer, int rowspan, int colspan);
	int bmx_wxgridbagsizer_setitemspan(wxGridBagSizer * gb, int index, int rowspan, int colspan);
	wxGBSizerItem * bmx_wxgridbagsizer_finditemwindow(wxGridBagSizer * gb, wxWindow * window);
	wxGBSizerItem * bmx_wxgridbagsizer_finditemsizer(wxGridBagSizer * gb, wxSizer * sizer);
	wxGBSizerItem * bmx_wxgridbagsizer_finditematpoint(wxGridBagSizer * gb, int x, int y);
	wxGBSizerItem * bmx_wxgridbagsizer_finditematposition(wxGridBagSizer * gb, int row, int col);

	void bmx_wxwindow_setvalidator(wxWindow * window, wxValidator * validator);

	void bmx_wxsizer_addresourcehandler();

	wxWindow * bmx_wxwindowdestroyevent_getwindow(wxWindowDestroyEvent & event);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxWindow : public wxWindow
{
public:
	MaxWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	~MaxWindow();
	
private:
	BBObject * maxHandle;

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxBoxSizer : public wxBoxSizer
{
public:
	MaxBoxSizer(BBObject * handle, int orient);
	MaxBoxSizer(int orient);
	~MaxBoxSizer();
	void MaxBind(BBObject * handle);

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxGridSizer : public wxGridSizer
{
public:
	MaxGridSizer(BBObject * handle, int cols, int vgap, int hgap);
	MaxGridSizer(BBObject * handle, int rows, int cols, int vgap, int hgap);
	MaxGridSizer(int rows, int cols, int vgap, int hgap);
	~MaxGridSizer();
	void MaxBind(BBObject * handle);

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFlexGridSizer : public wxFlexGridSizer
{
public:
	MaxFlexGridSizer(BBObject * handle, int cols, int vgap, int hgap);
	MaxFlexGridSizer(BBObject * handle, int rows, int cols, int vgap, int hgap);
	MaxFlexGridSizer(int rows, int cols, int vgap, int hgap);
	~MaxFlexGridSizer();
	void MaxBind(BBObject * handle);

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxGridBagSizer : public wxGridBagSizer
{
public:
	MaxGridBagSizer(BBObject * handle, int vgap, int hgap);
	MaxGridBagSizer(int vgap, int hgap);
	~MaxGridBagSizer();
	void MaxBind(BBObject * handle);

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSizerXmlHandler : public wxSizerXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxSizerXmlHandler)

public:
    MaxSizerXmlHandler();
    //virtual wxObject *DoCreateResource();
    bool IsSizerNode(wxXmlNode *node) const;

    wxSizer*  Handle_wxBoxSizer();
    wxSizer*  Handle_wxGridSizer();
    wxSizer*  Handle_wxFlexGridSizer();
    wxSizer*  Handle_wxGridBagSizer();
};

#endif // _WX_MAX_WINDOW_H_
