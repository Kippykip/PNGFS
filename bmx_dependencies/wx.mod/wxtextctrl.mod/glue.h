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
#include <wx/textctrl.h>
#include "../wxtextvalidator.mod/glue.h"
#include "wx/xrc/xh_text.h"
#include "wx/xml/xml.h"

class MaxTextCtrl;
class MaxTextAttr;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxtextctrl_wxTextCtrl__xrcNew)(wxTextCtrl * text);

	MaxTextCtrl * bmx_wxtextctrl_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, int x, int y, int w, int h, int style, wxValidator * validator);
	void bmx_wxtextctrl_appendtext(wxTextCtrl * ctrl, BBString * text);
	int bmx_wxtextctrl_cancopy(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_cancut(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_canpaste(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_canredo(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_canundo(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_clear(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_copy(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_cut(wxTextCtrl * ctrl);

	void bmx_wxtextctrl_discardedits(wxTextCtrl * ctrl);
	MaxTextAttr * bmx_wxtextctrl_getdefaultstyle(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_getinsertionpoint(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_getlastposition(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_getlinelength(wxTextCtrl * ctrl, int lineNo);
	BBString * bmx_wxtextctrl_getlinetext(wxTextCtrl * ctrl, int lineNo);
	int bmx_wxtextctrl_getnumberoflines(wxTextCtrl * ctrl);
	BBString * bmx_wxtextctrl_getrange(wxTextCtrl * ctrl, int fromPos, int toPos);
	void bmx_wxtextctrl_getselection(wxTextCtrl * ctrl, int * fromPos, int * toPos);
	BBString * bmx_wxtextctrl_getstringselection(wxTextCtrl * ctrl);
	MaxTextAttr * bmx_wxtextctrl_getstyle(wxTextCtrl * ctrl, int position);
	BBString * bmx_wxtextctrl_getvalue(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_iseditable(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_isempty(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_ismodified(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_ismultiline(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_issingleline(wxTextCtrl * ctrl);

	int bmx_wxtextctrl_loadfile(wxTextCtrl * ctrl, BBString * filename, int ftype);
	void bmx_wxtextctrl_markdirty(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_paste(wxTextCtrl * ctrl);
	int bmx_wxtextctrl_positiontoxy(wxTextCtrl * ctrl, int pos, int * x, int * y);
	void bmx_wxtextctrl_redo(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_remove(wxTextCtrl * ctrl, int fromPos, int toPos);
	void bmx_wxtextctrl_replace(wxTextCtrl * ctrl, int fromPos, int toPos, BBString * value);
	int bmx_wxtextctrl_savefile(wxTextCtrl * ctrl, BBString * filename, int ftype);
	int bmx_wxtextctrl_setdefaultstyle(wxTextCtrl * ctrl, MaxTextAttr * style);
	void bmx_wxtextctrl_seteditable(wxTextCtrl * ctrl, int editable);
	void bmx_wxtextctrl_setinsertionpoint(wxTextCtrl * ctrl, int pos);
	void bmx_wxtextctrl_setinsertionpointend(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_setmaxlength(wxTextCtrl * ctrl, int length);
	void bmx_wxtextctrl_setmodified(wxTextCtrl * ctrl, int modified);
	void bmx_wxtextctrl_setselection(wxTextCtrl * ctrl, int fromPos, int toPos);
	void bmx_wxtextctrl_setstyle(wxTextCtrl * ctrl, int fromPos, int toPos, MaxTextAttr * style);
	void bmx_wxtextctrl_changevalue(wxTextCtrl * ctrl, BBString * value);
	void bmx_wxtextctrl_showposition(wxTextCtrl * ctrl, int pos);
	void bmx_wxtextctrl_undo(wxTextCtrl * ctrl);
	void bmx_wxtextctrl_writetext(wxTextCtrl * ctrl, BBString * text);
	int bmx_wxtextctrl_xytoposition(wxTextCtrl * ctrl, int x, int y);
	void bmx_wxtextctrl_setvalue(wxTextCtrl * ctrl, BBString * text);
	
	int bmx_wxtextctrl_hittest(wxTextCtrl * ctrl, int x, int y, int * col, int * row);

	int bmx_wxtextattr_getalignment(MaxTextAttr * style);
	MaxColour * bmx_wxtextattr_getbackgroundcolour(MaxTextAttr * style);
	MaxFont * bmx_wxtextattr_getfont(MaxTextAttr * style);
	int bmx_wxtextattr_getleftindent(MaxTextAttr * style);
	int bmx_wxtextattr_getleftsubindent(MaxTextAttr * style);
	int bmx_wxtextattr_getrightindent(MaxTextAttr * style);
	BBArray * bmx_wxtextattr_gettabs(MaxTextAttr * style);
	MaxColour * bmx_wxtextattr_gettextcolour(MaxTextAttr * style);
	int bmx_wxtextattr_hasalignment(MaxTextAttr * style);
	int bmx_wxtextattr_hasbackgroundcolour(MaxTextAttr * style);
	int bmx_wxtextattr_hasfont(MaxTextAttr * style);
	int bmx_wxtextattr_hasleftindent(MaxTextAttr * style);
	int bmx_wxtextattr_hasrightindent(MaxTextAttr * style);
	int bmx_wxtextattr_hastabs(MaxTextAttr * style);
	int bmx_wxtextattr_hastextcolour(MaxTextAttr * style);
	int bmx_wxtextattr_getflags(MaxTextAttr * style);
	int bmx_wxtextattr_isdefault(MaxTextAttr * style);
	void bmx_wxtextattr_merge(MaxTextAttr * style, MaxTextAttr * overlay);
	void bmx_wxtextattr_setalignment(MaxTextAttr * style, int alignment);
	void bmx_wxtextattr_setbackgroundcolour(MaxTextAttr * style, MaxColour * colour);
	void bmx_wxtextattr_setflags(MaxTextAttr * style, int flags);
	void bmx_wxtextattr_setfont(MaxTextAttr * style, MaxFont * font);
	void bmx_wxtextattr_setleftindent(MaxTextAttr * style, int indent, int subIndent);
	void bmx_wxtextattr_setrightindent(MaxTextAttr * style, int indent);
	void bmx_wxtextattr_settabs(MaxTextAttr * style, BBArray * tabs);
	void bmx_wxtextattr_settextcolour(MaxTextAttr * style, MaxColour * colour);
	
	MaxTextAttr * bmx_wxtextattr_create(MaxColour * colText, MaxColour * colBack, MaxFont * font, int alignment);
	void bmx_wxtextattr_delete(MaxTextAttr * style);
	
	int bmx_wxtextctrl_geteventtype(int type);
	
	const wxMouseEvent & bmx_wxtexturlevent_getmouseevent(wxTextUrlEvent & event);
	int bmx_wxtexturlevent_geturlstart(wxTextUrlEvent & event);
	int bmx_wxtexturlevent_geturlend(wxTextUrlEvent & event);

	int bmx_wxtextctrl_emulatekeypress(wxTextCtrl * ctrl, wxKeyEvent & event);

	void bmx_wxtextctrl_addresourcehandler();
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTextCtrl : public wxTextCtrl
{
public:
	MaxTextCtrl();
	MaxTextCtrl(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, int x, int y, int w, int h, long style, const wxValidator & val);
	~MaxTextCtrl();

	void MaxBind(BBObject * handle);

	int GetLineLength(long lineNo) const;
	wxString GetLineText(long lineNo) const;
	int GetNumberOfLines() const;
	bool IsModified() const;
	void MarkDirty();
	void DiscardEdits();
	bool SetStyle(long start, long end, const wxTextAttr& style);
	bool GetStyle(long position, wxTextAttr& style);
	bool SetDefaultStyle(const wxTextAttr& style);
	long XYToPosition(long x, long y) const;
	bool PositionToXY(long pos, long *x, long *y) const;
	void ShowPosition(long pos);

	bool DoLoadFile(const wxString& file, int fileType);
	bool DoSaveFile(const wxString& file, int fileType);

	void SetMaxLength(unsigned long len);
	void Copy();
	void Cut();
	void Paste();

private:
	DECLARE_EVENT_TABLE()
};


class MaxTextAttr
{
public:
	MaxTextAttr(const wxTextAttr &);
	wxTextAttr & TextAttr();

private:
	wxTextAttr textAttr;

};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxTextCtrlXmlHandler : public wxTextCtrlXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxTextCtrlXmlHandler)

public:
    MaxTextCtrlXmlHandler();
    virtual wxObject *DoCreateResource();
};
