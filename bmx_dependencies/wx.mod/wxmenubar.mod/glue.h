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
#include "../wxmenu.mod/glue.h"
#include "wx/xrc/xh_menu.h"
#include "wx/xml/xml.h"

class MaxMenuBar;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxmenubar_wxMenuBar__xrcNew)(wxMenuBar * menubar);

	MaxMenuBar * bmx_wxmenubar_create(BBObject * maxHandle, int style);
	int bmx_wxmenubar_append(wxMenuBar * menubar, MaxMenu * menu, BBString * title);
	void bmx_wxmenubar_check(wxMenuBar * menubar, int id, int value);
	void bmx_wxmenubar_enable(wxMenuBar * menubar, int id, int value);
	void bmx_wxmenubar_enabletop(wxMenuBar * menubar, int pos, int value);
	int bmx_wxmenubar_findmenu(wxMenuBar * menubar, BBString * title);
	int bmx_wxmenubar_findmenuitem(wxMenuBar * menubar, BBString * menuString, BBString * itemString);
	BBString * bmx_wxmenubar_gethelpstring(wxMenuBar * menubar, int id);
	BBString * bmx_wxmenubar_getlabel(wxMenuBar * menubar, int id);
	BBString * bmx_wxmenubar_getmenulabel(wxMenuBar * menubar, int pos);
	wxMenu * bmx_wxmenubar_getmenu(wxMenuBar * menubar, int index);
	int bmx_wxmenubar_getmenucount(wxMenuBar * menubar);
	int bmx_wxmenubar_insert(wxMenuBar * menubar, int pos, MaxMenu * menu, BBString * title);
	int bmx_wxmenubar_ischecked(wxMenuBar * menubar, int id);
	int bmx_wxmenubar_isenabled(wxMenuBar * menubar, int id);
	void bmx_wxmenubar_refresh(wxMenuBar * menubar);
	wxMenu * bmx_wxmenubar_remove(wxMenuBar * menubar, int pos);
	wxMenu * bmx_wxmenubar_replace(wxMenuBar * menubar, int pos, MaxMenu * menu, BBString * title);
	void bmx_wxmenubar_sethelpstring(wxMenuBar * menubar, int id, BBString * helpString);
	void bmx_wxmenubar_setlabel(wxMenuBar * menubar, int id, BBString * label);
	void bmx_wxmenubar_setmenulabel(wxMenuBar * menubar, int pos, BBString * label);
	wxMenuItem * bmx_wxmenubar_finditem(wxMenuBar * menubar, int id);

	void bmx_wxmenubar_addresourcehandler();
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxMenuBar : public wxMenuBar
{
public:
	MaxMenuBar(BBObject * handle, long style);
	MaxMenuBar(long style);
	~MaxMenuBar();

	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxMenuBarXmlHandler : public wxMenuBarXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxMenuBarXmlHandler)

public:
    MaxMenuBarXmlHandler();
    virtual wxObject *DoCreateResource();
};
