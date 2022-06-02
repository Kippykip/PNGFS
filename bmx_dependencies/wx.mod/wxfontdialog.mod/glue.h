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
#include "wx/fontdlg.h"

class MaxFontDialog;
class MaxFontData;

extern "C" {

#include <blitz.h>

	MaxFont * bmx_wxgetfontfromuser(wxWindow * window, MaxFont * font, BBString * caption);
	
	MaxFontDialog * bmx_wxfontdialog_create(BBObject * handle, wxWindow  * parent, MaxFontData * data);
	MaxFontData * bmx_wxfontdialog_getfontdata(wxFontDialog * dialog);
	int bmx_wxfontdialog_showmodal(wxFontDialog * dialog);
	
	MaxFontData * bmx_wxfontdata_create();

	void bmx_wxfontdata_enableeffects(MaxFontData * data, int enable);
	int bmx_wxfontdata_getallowsymbols(MaxFontData * data);
	MaxColour * bmx_wxfontdata_getcolour(MaxFontData * data);
	MaxFont * bmx_wxfontdata_getchosenfont(MaxFontData * data);
	int bmx_wxfontdata_getenableeffects(MaxFontData * data);
	MaxFont * bmx_wxfontdata_getinitialfont(MaxFontData * data);
	int bmx_wxfontdata_getshowhelp(MaxFontData * data);
	void bmx_wxfontdata_setallowsymbols(MaxFontData * data, int allowSymbols);
	void bmx_wxfontdata_setchosenfont(MaxFontData * data, MaxFont * font);
	void bmx_wxfontdata_setcolour(MaxFontData * data, MaxColour * colour);
	void bmx_wxfontdata_setinitialfont(MaxFontData * data, MaxFont * font);
	void bmx_wxfontdata_setrange(MaxFontData * data, int minSize, int maxSize);
	void bmx_wxfontdata_setshowhelp(MaxFontData * data, int showhelp);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxFontDialog : public wxFontDialog
{
public:
	MaxFontDialog(BBObject * handle, wxWindow * parent, const wxFontData& data);
	~MaxFontDialog();
};

class MaxFontData
{
public:
	MaxFontData();
	MaxFontData(wxFontData & data);
	wxFontData & FontData();

private:
	wxFontData data;
};
