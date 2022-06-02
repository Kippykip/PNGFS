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
#include "wx/xrc/xh_chckl.h"
#include "wx/xml/xml.h"

class MaxCheckListBox;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxchecklistbox_wxCheckListBox__xrcNew)(wxCheckListBox * listbox);

	MaxCheckListBox * bmx_wxchecklistbox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBArray * array, int x, int y, int w, int h, int style);
	void bmx_wxchecklistbox_check(wxCheckListBox * listbox, int item, int check);
	int bmx_wxchecklistbox_ischecked(wxCheckListBox * listbox, int item);
	int bmx_wxchecklistbox_append(wxCheckListBox * listbox, BBString * item);
	
	int bmx_wxchecklistbox_geteventtype(int type);

	void bmx_wxchecklistbox_addresourcehandler();
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxCheckListBox : public wxCheckListBox
{
public:
	MaxCheckListBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxArrayString& array, int x, int y, int w, int h, long style);
	MaxCheckListBox();
	~MaxCheckListBox();
	
	void Clear();
	void Delete(unsigned int n);

	void MaxBind(BBObject * handle);

private:
    // any class wishing to process wxWidgets events must use this macro
    DECLARE_EVENT_TABLE()
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCheckListBoxXmlHandler : public wxCheckListBoxXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxCheckListBoxXmlHandler)

public:
    MaxCheckListBoxXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    bool m_insideBox;
    wxArrayString strList;
};


