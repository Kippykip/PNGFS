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
#include "wx/sizer.h"
#include "wx/xrc/xh_sizer.h"
#include "wx/xml/xml.h"

class MaxStdDialogButtonSizer;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxstddialogbuttonsizer_wxStdDialogButtonSizer__xrcNew)(wxStdDialogButtonSizer * sizer);

	wxStdDialogButtonSizer * bmx_wxstddialogbuttonsizer_create(BBObject * handle);
	void bmx_wxstddialogbuttonsizer_addbutton(wxStdDialogButtonSizer * sizer, wxButton * button);
	void bmx_wxstddialogbuttonsizer_realize(wxStdDialogButtonSizer * sizer);
	void bmx_wxstddialogbuttonsizer_setaffirmativebutton(wxStdDialogButtonSizer * sizer, wxButton * button);
	void bmx_wxstddialogbuttonsizer_setcancelbutton(wxStdDialogButtonSizer * sizer, wxButton * button);
	void bmx_wxstddialogbuttonsizer_setnegativebutton(wxStdDialogButtonSizer * sizer, wxButton * button);

	void bmx_wxstddialogbuttonsizer_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxStdDialogButtonSizer : public wxStdDialogButtonSizer
{
public:
	MaxStdDialogButtonSizer(BBObject * handle);
	MaxStdDialogButtonSizer();
	~ MaxStdDialogButtonSizer();

	void MaxBind(BBObject * handle);

private:
	BBObject * maxHandle;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxStdDialogButtonSizerXmlHandler : public wxStdDialogButtonSizerXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxStdDialogButtonSizerXmlHandler)

public:
    MaxStdDialogButtonSizerXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);

    bool m_isInside;
    MaxStdDialogButtonSizer *m_parentSizer;
};

