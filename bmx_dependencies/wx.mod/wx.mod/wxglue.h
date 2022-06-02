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

#ifndef _WX_MAX_H_
#define _WX_MAX_H_

#include "wx/wx.h"
#include "wx/apptrait.h"
#include "wx/evtloop.h"
#include "wx/aboutdlg.h"
//#include "wx/artprov.h"
#include "wx/fontmap.h"
//#include "wx/timer.h"
//#include "wx/ptr_scpd.h"
#include "wx/txtstrm.h"
#include "wx/wfstream.h"
//#include "wx/power.h"

#include "wx/event.h"
#include "wx/socket.h"
#include "wx/stopwatch.h"
#include "wx/utils.h"

#include <map>

class MaxApp;
class MaxEvtHandler;
class MaxObject;
class MaxColour;
class MaxFont;
class MaxDC;
class MaxPaintDC;
class MaxRect;
class MaxWindowDC;
class MaxClientData;

extern "C" {

#include "brl.mod/blitz.mod/blitz.h"
#include "brl.mod/event.mod/event.h"
	void bbSystemEmitEvent( int id,BBObject *source,int data,int mods,int x,int y,BBObject *extra );

#ifdef BMX_NG
#define CB_PREF(func) func
#else
#define CB_PREF(func) _##func
#endif

#ifndef BMX_NG
	void _wx_wx_TEventHandler_eventCallback(wxEvent &, void * data);
	void _wx_wx_TEventHandler__nullref(void * handle);
	void _wx_wx_wxObject__Free(BBObject * handle);
#else
	void wx_wx_events_TEventHandler_eventCallback(wxEvent &, void * data);
	void wx_wx_events_TEventHandler__nullref(void * handle);
	void wx_wx_base_wxObject__Free(BBObject * handle);
#endif

	int CB_PREF(wx_wxapp_wxAppMain__MainLoop)();
	int CB_PREF(wx_wxapp_wxApp__OnInit)();
	int CB_PREF(wx_wxapp_wxApp__OnExit)();

	BBString *bbStringFromWxString(const wxString &s );
	wxString wxStringFromBBString(BBString * s);
	wxArrayString bbStringArrayTowxArrayStr( BBArray *p );
	BBArray *wxArrayStringToBBStringArray( wxArrayString t );
	wxArrayInt bbIntArrayTowxArrayInt( BBArray *p );
	BBArray *wxArrayIntToBBIntArray( wxArrayInt t );
	BBArray *wxArrayDoubleToBBDoubleArray( wxArrayDouble t );
	wxArrayDouble bbDoubleArrayTowxArrayDouble( BBArray *p );
	void wxbind( wxObject *obj, BBObject *peer );
	void wxunbind(wxObject *obj);
	BBObject *wxfind( wxObject *obj );

	int bmx_app_wxentry();
	int bmx_app_wxentrystart();
	int bmx_wxapp_macexitmenuitemid();
	void bmx_wxapp_settopwindow(wxWindow * window);
	void bmx_wxapp_setappname(BBString * name);
	int bmx_wxapp_yield(int onlyIfNeeded);
	void bmx_wxapp_setownmain();
	int bmx_wxapp_dispatch();
	int bmx_wxapp_pending();
	int bmx_wxapp_processidle();
	void bmx_wxapp_pollevents();

	MaxEvtHandler * bmx_wxevthandler_create(BBObject * maxHandle);
	void bmx_wxevthandler_connectnoid(wxEvtHandler * evtHandler, wxEventType eventType, MaxObject * data);
	void bmx_wxevthandler_connect(wxEvtHandler * evtHandler, int id, wxEventType eventType, MaxObject * data);
	void bmx_wxevthandler_connectrange(wxEvtHandler * evtHandler, int id, int lastId, wxEventType eventType, MaxObject * data);
	void bmx_wxevthandler_addpendingevent(wxEvtHandler * evtHandler, wxEvent & event);
	int bmx_wxevthandler_processevent(wxEvtHandler * evtHandler, wxEvent & event);
	int bmx_wxevthandler_disconnectnoid(wxEvtHandler * evtHandler, wxEventType eventType, MaxObject * data);
	int bmx_wxevthandler_disconnect(wxEvtHandler * evtHandler, int id, wxEventType eventType, MaxObject * data);
	int bmx_wxevthandler_disconnectrange(wxEvtHandler * evtHandler, int id, int lastId, wxEventType eventType, MaxObject * data);
	MaxObject * bmx_wxevthandler_newref(void * data);
	void bmx_wxevthandler_freeref(MaxObject * obj);

	void * bmx_event_geteventobject(wxEvent * evt);
	wxEventType bmx_eventtype_value(int type);
	BBString * bmx_wxcommandevent_getstring(wxCommandEvent & event);
	int bmx_wxcommandevent_ischecked(wxCommandEvent & event);
	int bmx_wxcommandevent_getint(wxCommandEvent & event);
	int bmx_wxcommandevent_getselection(wxCommandEvent & event);
	int bmx_wxcommandevent_isselection(wxCommandEvent & event);
	int bmx_wxcommandevent_getextralong(wxCommandEvent & event);
	void * bmx_wxcommandevent_getclientdata(wxCommandEvent & event);
	void bmx_wxcommandevent_setclientdata(wxCommandEvent & event, void * data);
	void bmx_wxcommandevent_setstring(wxCommandEvent & event, BBString * value);
	void bmx_wxcommandevent_setint(wxCommandEvent & event, int value);

	void bmx_wxmoveevent_getposition(wxMoveEvent & event, int * x, int * y);
	void bmx_wxevent_skip(wxEvent & event, int skip);
	void bmx_wxsizeevent_getsize(wxSizeEvent & event, int * w, int * h);
	wxEventType bmx_wxevent_geteventtype(wxEvent & event);
	int bmx_wxevent_getid(wxEvent & event);
	int bmx_wxevent_getskipped(wxEvent & event);
	int bmx_wxevent_gettimestamp(wxEvent & event);
	int bmx_wxevent_iscommandevent(wxEvent & event);
	void bmx_wxevent_resumepropagation(wxEvent & event, int propagationLevel);
	int bmx_wxevent_shouldpropagate(wxEvent & event);
	int bmx_wxevent_stoppropagation(wxEvent & event);
	wxObject * bmx_wxevent_geteventobject(wxEvent & event);

	
	void bmx_wxupdateeventui_check(wxUpdateUIEvent & event, int value);
	void bmx_wxupdateeventui_enable(wxUpdateUIEvent & event, int value);
	void bmx_wxupdateeventui_show(wxUpdateUIEvent & event, int value);
	
	void bmx_wxnotifyevent_allow(wxNotifyEvent & event);
	void bmx_wxnotifyevent_veto(wxNotifyEvent & event);
	int bmx_wxnotifyevent_isallowed(wxNotifyEvent & event);

	int bmx_wxscrollevent_getorientation(wxScrollEvent & event);
	int bmx_wxscrollevent_getposition(wxScrollEvent & event);
	
	void bmx_wxcontextmenuevent_getposition(wxContextMenuEvent & event, int * x, int * y);
	void bmx_wxcontextmenuevent_setposition(wxContextMenuEvent & event, int x, int y);

	int bmx_wxkeyevent_altdown(wxKeyEvent & event);
	int bmx_wxkeyevent_cmddown(wxKeyEvent & event);
	int bmx_wxkeyevent_controldown(wxKeyEvent & event);
	int bmx_wxkeyevent_getkeycode(wxKeyEvent & event);
	int bmx_wxkeyevent_getmodifiers(wxKeyEvent & event);
	void bmx_wxkeyevent_getposition(wxKeyEvent & event, int * x, int * y);
	int bmx_wxkeyevent_getrawkeycode(wxKeyEvent & event);
	int bmx_wxkeyevent_getrawkeyflags(wxKeyEvent & event);
	BBString * bmx_wxkeyevent_getunicodekey(wxKeyEvent & event);
	int bmx_wxkeyevent_getx(wxKeyEvent & event);
	int bmx_wxkeyevent_gety(wxKeyEvent & event);
	int bmx_wxkeyevent_hasmodifiers(wxKeyEvent & event);
	int bmx_wxkeyevent_metadown(wxKeyEvent & event);
	int bmx_wxkeyevent_shiftdown(wxKeyEvent & event);

	int bmx_wxcloseevent_canveto(wxCloseEvent & event);
	int bmx_wxcloseevent_getloggingoff(wxCloseEvent & event);
	void bmx_wxcloseevent_setcanveto(wxCloseEvent & event, int canVeto);
	void bmx_wxcloseevent_setloggingoff(wxCloseEvent & event, int loggingOff);
	void bmx_wxcloseevent_veto(wxCloseEvent & event, int value);


	BBString * bmx_wxversion_string();
	BBString * bmx_wxgetosdescription();
	
	int bmx_wxmessagebox(BBString * message, BBString * caption, int style, wxWindow * parent, int x, int y);
	
	wxAboutDialogInfo * bmx_wxaboutdialoginfo_create();
	void bmx_wxaboutdialoginfo_delete(wxAboutDialogInfo * info);
	void bmx_wxaboutbox(wxAboutDialogInfo * info);


	MaxColour * bmx_wxcolour_create(int r, int g, int b, int a);
	MaxColour * bmx_wxcolour_null();
	void bmx_wxcolour_delete(MaxColour * col);
	int bmx_wxcolour_isok(MaxColour * col);
	int bmx_wxcolour_red(MaxColour * col);
	int bmx_wxcolour_green(MaxColour * col);
	int bmx_wxcolour_blue(MaxColour * col);
	int bmx_wxcolour_alpha(MaxColour * col);
	BBString * bmx_wxcolour_getasstring(MaxColour * col, int flags);
	MaxColour * bmx_wxcolour_createnamedcolour(BBString * name);
	void bmx_wxcolour_set(MaxColour * col, int r, int g, int b, int a);
	int bmx_wxcolour_setasnamedcolour(MaxColour * col, BBString * name);
	int bmx_wxcolour_equals(MaxColour * col, MaxColour * other);
	void bmx_wxcolour_getrgb(MaxColour * col, int * r, int * g, int * b);
	void bmx_wxcolour_getrgba(MaxColour * col, int * r, int * g, int * b, int * a);
	MaxColour * bmx_wxcolour_copy(MaxColour * col);

	wxColourDatabase * bmx_wxcolourdatabase_create();
	wxColourDatabase * bmx_wxcolourdatase_instance();
	void bmx_wxcolourdatabase_addcolour(wxColourDatabase * database, BBString * colourName, MaxColour * colour);
	MaxColour * bmx_wxcolourdatabase_find(wxColourDatabase * database, BBString * colourName);
	BBString * bmx_wxcolourdatabase_findname(wxColourDatabase * database, MaxColour * colour);
	void bmx_wxcolourdatabase_free(wxColourDatabase * database);

	MaxColour * bmx_wxstockgdi_colour_black();
	MaxColour * bmx_wxstockgdi_colour_blue();
	MaxColour * bmx_wxstockgdi_colour_cyan();
	MaxColour * bmx_wxstockgdi_colour_green();
	MaxColour * bmx_wxstockgdi_colour_lightgrey();
	MaxColour * bmx_wxstockgdi_colour_red();
	MaxColour * bmx_wxstockgdi_colour_white();
		
	MaxFont * bmx_wxstockgdi_font_italic();
	MaxFont * bmx_wxstockgdi_font_normal();
	MaxFont * bmx_wxstockgdi_font_small();
	MaxFont * bmx_wxstockgdi_font_swiss();

	MaxFont * bmx_wxfont_create();
	MaxFont * bmx_wxfont_createattr(int pointSize, wxFontFamily family, int style, wxFontWeight weight,
			int underline, BBString * faceName, wxFontEncoding encoding);
	void bmx_wxfont_delete(MaxFont * font);
	int bmx_wxfont_getpointsize(MaxFont * font);
	void bmx_wxfont_setpointsize(MaxFont * font, int size);
	int bmx_wxfont_isfixedwidth(MaxFont * font);
	wxFontEncoding bmx_wxfont_getdefaultencoding();
	BBString * bmx_wxfont_getfacename(MaxFont * font);
	int bmx_wxfont_getfamily(MaxFont * font);
	BBString * bmx_wxfont_getfamilystring(MaxFont * font);
	BBString * bmx_wxfont_getnativefontinfodesc(MaxFont * font);
	BBString * bmx_wxfont_getnativefontinfouserdesc(MaxFont * font);
	int bmx_wxfont_getstyle(MaxFont * font);
	int bmx_wxfont_getunderlined(MaxFont * font);
	int bmx_wxfont_getweight(MaxFont * font);
	int bmx_wxfont_isok(MaxFont * font);
	wxFontEncoding bmx_wxfont_getencoding(MaxFont * font);
	BBString * bmx_wxfont_getstylestring(MaxFont * font);
	BBString * bmx_wxfont_getweightstring(MaxFont * font);
	void bmx_wxfont_setstyle(MaxFont * font, int style);
	void bmx_wxfont_setunderlined(MaxFont * font, int underlined);
	void bmx_wxfont_setweight(MaxFont * font, int weight);
	void bmx_wxfont_setdefaultencoding(wxFontEncoding encoding);
	int bmx_wxfont_setfacename(MaxFont * font, BBString * name);
	void bmx_wxfont_setfamily(MaxFont * font, int family);
	int bmx_wxfont_setnativefontinfo(MaxFont * font, BBString * info);
	int bmx_wxfont_setnativefontinfouserdesc(MaxFont * font, BBString * info);
	void bmx_wxfont_setencoding(MaxFont * font, wxFontEncoding encoding);
	MaxFont * bmx_wxfont_copy(MaxFont * font);
	MaxFont * bmx_wxfont_null();
	void bmx_wxfont_getpixelsize(MaxFont * font, int * w, int * h);
	void bmx_wxfont_setpixelsize(MaxFont * font, int w, int h);
	int bmx_wxfont_getstrikethrough(MaxFont * font);
	void bmx_wxfont_setstrikethrough(MaxFont * font, int strikethrough);


	MaxPaintDC * bmx_wxpaintdc_create(wxWindow * window);
	void bmx_wxpaintdc_delete(MaxPaintDC * dc);
	
	wxFontEncoding bmx_wxfontmapper_getencoding(int n);
	BBString * bmx_wxfontmapper_getencodingdescription(wxFontEncoding encoding);
	BBString * bmx_wxfontmapper_getencodingname(wxFontEncoding encoding);
	int bmx_wxfontmapper_getsupportedencodingcount();

	void bmx_wxstreambase_getlength(wxStreamBase * stream, BBInt64 * i);
	int bmx_wxstreambase_getlasterror(wxStreamBase * stream);
	int bmx_wxstreambase_getsize(wxStreamBase * stream);
	int bmx_wxstreambase_isok(wxStreamBase * stream);
	int bmx_wxstreambase_isseekable(wxStreamBase * stream);

	int bmx_wxisalnum(int code);
	int bmx_wxisprint(int code);
	void bmx_wxinitallimagehandlers();
	int bmx_wxlaunchdefaultbrowser(BBString * url, int flags);

	MaxRect * bmx_wxrect_create(int x, int y, int w, int h);
	MaxRect * bmx_wxrect_centrein(MaxRect * rect, MaxRect * r, int dir);
	MaxRect * bmx_wxrect_centerin(MaxRect * rect, MaxRect * r, int dir);
	int bmx_wxrect_contains(MaxRect * rect, int x, int y);
	int bmx_wxrect_containsrect(MaxRect * rect, MaxRect * r);
	void bmx_wxrect_deflate(MaxRect * rect, int dx, int dy);
	int bmx_wxrect_getbottom(MaxRect * rect);
	int bmx_wxrect_getheight(MaxRect * rect);
	int bmx_wxrect_getleft(MaxRect * rect);
	void bmx_wxrect_getposition(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_gettopleft(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_gettopright(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_getbottomleft(MaxRect * rect, int * x, int * y);
	void bmx_wxrect_getbottomright(MaxRect * rect, int * x, int * y);
	int bmx_wxrect_getright(MaxRect * rect);
	void bmx_wxrect_getsize(MaxRect * rect, int * w, int * h);
	int bmx_wxrect_gettop(MaxRect * rect);
	int bmx_wxrect_getwidth(MaxRect * rect);
	int bmx_wxrect_getx(MaxRect * rect);
	int bmx_wxrect_gety(MaxRect * rect);
	void bmx_wxrect_inflate(MaxRect * rect, int dx, int dy);
	int bmx_wxrect_intersects(MaxRect * rect, MaxRect * r);
	int bmx_wxrect_isempty(MaxRect * rect);
	void bmx_wxrect_offset(MaxRect * rect, int dx, int dy);
	void bmx_wxrect_setheight(MaxRect * rect, int height);
	void bmx_wxrect_setsize(MaxRect * rect, int w, int h);
	void bmx_wxrect_setwidth(MaxRect * rect, int width);
	void bmx_wxrect_setx(MaxRect * rect, int x);
	void bmx_wxrect_sety(MaxRect * rect, int y);
	MaxRect * bmx_wxrect_union(MaxRect * rect, MaxRect * r);
	void bmx_wxrect_delete(MaxRect * rect);

	void bmx_gdi_wxclientdisplayrect(int * x, int * y, int * width, int * height);
	MaxRect * bmx_gdi_wxgetclientdisplayrect();
	int bmx_gdi_wxcolourdisplay();
	int bmx_gdi_wxdisplaydepth();
	void bmx_gdi_wxdisplaysize(int * width, int * height);
	void bmx_gdi_wxdisplaysizemm(int * width, int * height);

	BBString * bmx_wxgetosdescription();
	BBString * bmx_wxgetemailaddress();
	void bmx_wxgetfreememory(BBInt64 * mem);
	BBString * bmx_wxgetfullhostname();
	BBString * bmx_wxgethomedir();
	BBString * bmx_wxgethostname();
	wxOperatingSystemId bmx_wxgetosversion(int * major, int * minor);
	int bmx_wxisplatformlittleendian();
	int bmx_wxisplatform64bit();
	BBString * bmx_wxgetuserhome(BBString * user);
	BBString * bmx_wxgetuserid();
	BBString * bmx_wxgetusername();

	wxEventType bmx_wxneweventtype();

	void bmx_wxevent_seteventobject(wxEvent & event, wxObject * obj);
	void bmx_wxevent_delete(wxEvent * event);
	wxCommandEvent * bmx_wxcommandevent_create(wxEventType type, int winId);
	wxEvent & bmx_wxevent_getcustref(wxEvent * customEventPtr);

	int bmx_wxinputstream_lastread(wxInputStream * s);
	wxInputStream * bmx_wxinputstream_read(wxInputStream * s, void * buffer, int size);
	int bmx_wxinputstream_canread(wxInputStream * s);
	int bmx_wxinputstream_eof(wxInputStream * s);

	wxTextInputStream * bmx_wxtextinputstream_create(wxInputStream * inp, BBString * separators);
	int bmx_wxtextinputstream_read8(wxTextInputStream * s, int base);
	int bmx_wxtextinputstream_read8s(wxTextInputStream * s, int base);
	int bmx_wxtextinputstream_read16(wxTextInputStream * s, int base);
	int bmx_wxtextinputstream_read16s(wxTextInputStream * s, int base);
	int bmx_wxtextinputstream_read32(wxTextInputStream * s, int base);
	int bmx_wxtextinputstream_read32s(wxTextInputStream * s, int base);
	int bmx_wxtextinputstream_getchar(wxTextInputStream * s);
	double bmx_wxtextinputstream_readdouble(wxTextInputStream * s);
	BBString * bmx_wxtextinputstream_readline(wxTextInputStream * s);
	BBString * bmx_wxtextinputstream_readword(wxTextInputStream * s);
	void bmx_wxtextinputstream_setstringseparators(wxTextInputStream * s, BBString * separators);
	void bmx_wxtextinputstream_delete(wxTextInputStream * s);

	int bmx_wxoutputstream_close(wxOutputStream * s);
	int bmx_wxoutputstream_lastwrite(wxOutputStream * s);
	wxOutputStream * bmx_wxoutputstream_write(wxOutputStream * s, void * buffer, int size);

	wxFileOutputStream * bmx_wxfileoutputstream_create(BBString * filename);
	int bmx_wxfileoutputstream_isok(wxFileOutputStream * stream);
	void bmx_wxfileoutputstream_free(wxFileOutputStream * stream);

	wxFileInputStream * bmx_wxfileinputstream_create(BBString * filename);
	int bmx_wxfileinputstream_isok(wxFileInputStream * stream);
	void bmx_wxfileinputstream_free(wxFileInputStream * stream);

	void bmx_wxfilterinputstream_free(wxFilterInputStream * stream);

	int bmx_wxnewid();
	void bmx_wxregisterid(int id);
	void bmx_wxenabletoplevelwindows(int enable);
	void bmx_wxgetmouseposition(int * x, int * y);

//	long bmx_wxgetelapsedtime(bool resetTimer);
	int bmx_wxgetlocaltime();
	void bmx_wxgetlocaltimemillis(BBInt64 * time);
	int bmx_wxgetutctime();
	void bmx_wxmicrosleep(int microseconds);
	void bmx_wxmillisleep(int milliseconds);
	BBString * bmx_wxnow();
	void bmx_wxsleep(int secs);
//	void bmx_wxstarttimer();

	wxTextOutputStream * bmx_wxtextoutputstream_create(wxOutputStream * out, wxEOL mode);
	wxEOL bmx_wxtextoutputstream_getmode(wxTextOutputStream * s);
	void bmx_wxtextoutputstream_setmode(wxTextOutputStream * s, wxEOL mode);
	void bmx_wxtextoutputstream_write8(wxTextOutputStream * s, int value);
	void bmx_wxtextoutputstream_write16(wxTextOutputStream * s, int value);
	void bmx_wxtextoutputstream_write32(wxTextOutputStream * s, int value);
	void bmx_wxtextoutputstream_writedouble(wxTextOutputStream * s, double value);
	void bmx_wxtextoutputstream_writestring(wxTextOutputStream * s, BBString * value);
	void bmx_wxtextoutputstream_delete(wxTextOutputStream * s);

#ifdef wxHAS_POWER_EVENTS
	void bmx_wxpowerevent_veto(wxPowerEvent & event);
#else
	void bmx_wxpowerevent_veto(wxEvent & event);
#endif

	int bmx_wxactivateevent_getactive(wxActivateEvent & event);
	int bmx_wxiconizeevent_iconized(wxIconizeEvent & event);

	void bmx_wxbell();
	int bmx_wxyield();

	void bmx_wxgestureevent_getposition(wxGestureEvent & event, int * x, int * y);
	int bmx_wxgestureevent_isgesturestart(wxGestureEvent & event);
	int bmx_wxgestureevent_isgestureend(wxGestureEvent & event);
	void bmx_wxgestureevent_setposition(wxGestureEvent & event, int x, int y);
	void bmx_wxgestureevent_setgesturestart(wxGestureEvent & event, int isStart);
	void bmx_wxgestureevent_setgestureend(wxGestureEvent & event, int isEnd);

	void bmx_wxpangestureevent_getdelta(wxPanGestureEvent & event, int * x, int * y);
	void bmx_wxpangestureevent_setdelta(wxPanGestureEvent & event, int x, int y);

	double bmx_wxrotategestureevent_getrotationangle(wxRotateGestureEvent & event);
	void bmx_wxrotategestureevent_setrotationangle(wxRotateGestureEvent & event, double angle);

	double bmx_wxzoomgestureevent_getzoomfactor(wxZoomGestureEvent & event);
	void bmx_wxzoomgestureevent_setzoomfactor(wxZoomGestureEvent & event, double factor);
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxApp : public wxApp
{
public:
	virtual bool OnInit();
	virtual int MainLoop();
	virtual int OnExit();
	int FilterEvent(wxEvent& event);
#ifdef __WXOSX__
	void MacOpenFiles(const wxArrayString & fileNames);
#endif

	static bool ownMain;
private:

    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()

	wxEventLoopBase * eventLoop;
};

wxDECLARE_APP(MaxApp);

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxObject : public wxObject
{
public:
	MaxObject(void * handle);
	~MaxObject();
	void * getHandle();
	
private:
	void * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxColour
{
public:
	MaxColour();
	MaxColour(wxColour & colour = wxNullColour);
	wxColour & Colour();

private:
	wxColour colour;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxFont
{
public:
	MaxFont();
	MaxFont(const wxFont & font);
	~MaxFont();
	wxFont & Font();

private:
	wxFont font;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDC
{
public:
	MaxDC();
	MaxDC(wxDC & dc);
	MaxDC(wxDC * dc);
	~MaxDC();
	wxDC * GetDC();
	void init(wxDC * _dc);
private:
	bool owner;
	wxDC * dc;
};

class MaxWindowDC : public MaxDC
{
public:
	//MaxWindowDC();
	MaxWindowDC(wxWindow * window);
private:
	wxWindowDC windowDC;
};

class MaxPaintDC : public MaxDC
{
public:
	MaxPaintDC(wxWindow * window);
private:
	wxPaintDC paintDC;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxEvtHandler : public wxEvtHandler
{
public:
	MaxEvtHandler(BBObject * handle);
	~MaxEvtHandler();

private:
	
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxRect
{
public:
	MaxRect(const wxRect & r);
	~MaxRect();
	wxRect & Rect();

private:
	wxRect rect;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxClientData : public wxClientData
{
public:
    MaxClientData()
		: handle(&bbNullObject)
	{}
	
	MaxClientData(BBObject * maxHandle)
		: handle(maxHandle)
	{
		if (handle != &bbNullObject) {
			BBRETAIN(handle);
		}
	}
	
    ~MaxClientData()
	{
		if (handle && (handle != &bbNullObject)) {
			BBRELEASE(handle);
		}
	}
	
	BBObject * Data() {
		if (handle) {
			return handle;
		} else {
			return &bbNullObject;
		}
	}

private:
	BBObject * handle;
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#endif // _WX_MAX_H_
