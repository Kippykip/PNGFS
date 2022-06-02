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
#include "../wxicon.mod/glue.h"
#include "../wxregion.mod/glue.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	int CB_PREF(wx_wxtoplevelwindow_wxTopLevelWindow__myShouldPreventAppExit)(void * window);

	int bmx_wxtoplevelwindow_cansettransparent(wxTopLevelWindow * window);
	int bmx_wxtoplevelwindow_enableclosebutton(wxTopLevelWindow * window, int value);
	MaxIcon * bmx_wxtoplevelwindow_geticon(wxTopLevelWindow * window);
	BBString * bmx_wxtoplevelwindow_gettitle(wxTopLevelWindow * window);
	int bmx_wxtoplevelwindow_isactive(wxTopLevelWindow * window);
	int bmx_wxtoplevelwindow_isalwaysmaximized(wxTopLevelWindow * window);
	void bmx_wxtoplevelwindow_iconize(wxTopLevelWindow * window, int value);
	int bmx_wxtoplevelwindow_isfullscreen(wxTopLevelWindow * window);
	int bmx_wxtoplevelwindow_isiconized(wxTopLevelWindow * window);
	int bmx_wxtoplevelwindow_ismaximized(wxTopLevelWindow * window);
	void bmx_wxtoplevelwindow_maximize(wxTopLevelWindow * window, int value);
	void bmx_wxtoplevelwindow_requestuserattention(wxTopLevelWindow * window, int flags);
	void bmx_wxtoplevelwindow_setdefaultitem(wxTopLevelWindow * window, wxWindow * item);
	void bmx_wxtoplevelwindow_seticon(wxTopLevelWindow * window, MaxIcon * icon);
	void bmx_wxtoplevelwindow_setmaxsize(wxTopLevelWindow * window, int w, int h);
	void bmx_wxtoplevelwindow_setminsize(wxTopLevelWindow * window, int w, int h);
	void bmx_wxtoplevelwindow_setsizehints(wxTopLevelWindow * window, int minW, int minH, int maxW, int maxH);
	void bmx_wxtoplevelwindow_settitle(wxTopLevelWindow * window, BBString * title);
	void bmx_wxtoplevelwindow_settransparent(wxTopLevelWindow * window, int alpha);
	int bmx_wxtoplevelwindow_showfullscreen(wxTopLevelWindow * window, int show, int style);
	void bmx_wxtoplevelwindow_centreonscreen(wxTopLevelWindow * window, int direction);
	void bmx_wxtoplevelwindow_centeronscreen(wxTopLevelWindow * window, int direction);

	wxWindow * bmx_wxtoplevelwindow_getdefaultitem(wxTopLevelWindow * window);

	void bmx_wxtoplevelwindow_seticons(wxTopLevelWindow * window, MaxIconBundle * icons);
	MaxIconBundle * bmx_wxtoplevelwindow_geticons(wxTopLevelWindow * window);
	int bmx_wxtoplevelwindow_setshape(wxTopLevelWindow * window, MaxRegion * region);

//#ifdef __WXMAC__
//	WXWindow bmx_wxtoplevelwindow_macgetwindowref(wxTopLevelWindow * window);
//#endif

	int bmx_wxtoplevelwindow_geteventtype(int type);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

