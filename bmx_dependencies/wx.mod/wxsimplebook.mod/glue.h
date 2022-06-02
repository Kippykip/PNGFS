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

#ifndef _WX_MAX_SIMPLEBOOK_H_
#define _WX_MAX_SIMPLEBOOK_H_

#include "wxglue.h"
#include "wx/simplebook.h"


class MaxSimplebook;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxsimplebook_wxSimplebook__xrcNew)(wxSimplebook * simple);

	MaxSimplebook * bmx_wxchoicebook_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style);
	void bmx_wxsimplebook_seteffects(wxSimplebook * simple, int showEffect, int hideEffect);
	void bmx_wxsimplebook_seteffect(wxSimplebook * simple, int effect);
	void bmx_wxsimplebook_seteffectstimeouts(wxSimplebook * simple, int showTimeout, int hideTimeout);
	void bmx_wxsimplebook_seteffecttimeout(wxSimplebook * simple, int timeout);
	void bmx_wxsimplebook_shownewpage(wxSimplebook * simple, wxWindow * page);

	// TODO : not yet implemented in wxWidgets
	//void bmx_wxsimplebook_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxSimplebook : public wxSimplebook
{
public:
	MaxSimplebook(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxSimplebook();
	~ MaxSimplebook();

	void MaxBind(BBObject * handle);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/* TODO : not yet implemented in wxWidgets
class MaxSimplebookXmlHandler : public wxSimplebookXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxSimplebookXmlHandler)

public:
    MaxSimplebookXmlHandler();
    virtual wxObject *DoCreateResource();
	virtual bool CanHandle(wxXmlNode *node);
	
    bool m_isInside;
    wxSimplebook *m_simplebook;
};
*/

#endif
