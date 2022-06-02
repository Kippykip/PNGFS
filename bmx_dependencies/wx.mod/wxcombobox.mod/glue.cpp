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

#include "glue.h"

// ---------------------------------------------------------------------------------------


MaxComboBox::MaxComboBox(BBObject * handle, wxWindow * parent, wxWindowID id, const wxString& value, const wxArrayString& array, int x, int y, int w, int h, long style)
	: wxComboBox(parent, id, value, wxPoint(x, y), wxSize(w, h), array, style)
{
	wxbind(this, handle);
}

MaxComboBox::MaxComboBox()
{}

MaxComboBox::~MaxComboBox() {
	wxunbind(this);
	
	// we need to free any items
	int count = GetCount();
	if (HasClientUntypedData()) {
		for (int i = 0; i < count; i++) {
			void * data = GetClientData(i);
			if (data) {
				BBRELEASE((BBObject*)data);
			}
		}
	}
}

void MaxComboBox::MaxBind(BBObject * handle) {
	wxbind(this, handle);
}

// ---------------------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(MaxComboBoxXmlHandler, wxComboBoxXmlHandler)

MaxComboBoxXmlHandler::MaxComboBoxXmlHandler()
	: wxComboBoxXmlHandler(), m_insideBox(false)
{}


wxObject * MaxComboBoxXmlHandler::DoCreateResource()
{
    if( m_class == wxT("wxComboBox"))
    {
        // find the selection
        long selection = GetLong( wxT("selection"), -1 );

        // need to build the list of strings from children
        m_insideBox = true;
        CreateChildrenPrivately(NULL, GetParamNode(wxT("content")));

        XRC_MAKE_INSTANCE(control, MaxComboBox)

        control->Create(m_parentAsWindow,
                        GetID(),
                        GetText(wxT("value")),
                        GetPosition(), GetSize(),
                        strList,
                        GetStyle(),
                        wxDefaultValidator,
                        GetName());


		control->MaxBind(CB_PREF(wx_wxcombobox_wxComboBox__xrcNew)(control));

        if (selection != -1)
            control->SetSelection(selection);

        SetupWindow(control);

        const wxString hint = GetText(wxS("hint"));
        if ( !hint.empty() )
            control->SetHint(hint);
        strList.Clear();    // dump the strings

        return control;
    }
    else
    {
        // on the inside now.
        // handle <item>Label</item>

        // add to the list
        wxString str = GetNodeContent(m_node);
        if (m_resource->GetFlags() & wxXRC_USE_LOCALE)
            str = wxGetTranslation(str, m_resource->GetDomain());
        strList.Add(str);

        return NULL;
    }

}

bool MaxComboBoxXmlHandler::CanHandle(wxXmlNode *node)
{
    return (IsOfClass(node, wxT("wxComboBox")) ||
           (m_insideBox && node->GetName() == wxT("item")));
}

// *********************************************

BEGIN_EVENT_TABLE(MaxComboBox, wxComboBox)
END_EVENT_TABLE()

MaxComboBox * bmx_wxcombobox_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, BBString * value, BBArray * array, int x, int y, int w, int h, int style) {
	return new MaxComboBox(maxHandle, parent, id, wxStringFromBBString(value), bbStringArrayTowxArrayStr(array), x, y, w, h, style);
}

int bmx_wxcombobox_cancopy(wxComboBox * combo) {
	return static_cast<int>(combo->CanCopy());
}

int bmx_wxcombobox_cancut(wxComboBox * combo) {
	return static_cast<int>(combo->CanCut());
}

int bmx_wxcombobox_canpaste(wxComboBox * combo) {
	return static_cast<int>(combo->CanPaste());
}

int bmx_wxcombobox_canredo(wxComboBox * combo) {
	return static_cast<int>(combo->CanRedo());
}

int bmx_wxcombobox_canundo(wxComboBox * combo) {
	return static_cast<int>(combo->CanUndo());
}

void bmx_wxcombobox_copy(wxComboBox * combo) {
	combo->Copy();
}

void bmx_wxcombobox_cut(wxComboBox * combo) {
	combo->Cut();
}

int bmx_wxcombobox_getcurrentselection(wxComboBox * combo) {
	return combo->GetCurrentSelection();
}

int bmx_wxcombobox_getinsertionpoint(wxComboBox * combo) {
	return combo->GetInsertionPoint();
}

wxTextPos bmx_wxcombobox_getlastposition(wxComboBox * combo) {
	return combo->GetLastPosition();
}

void bmx_wxcombobox_gettextselection(wxComboBox * combo, int * fromPos, int * toPos) {
#ifndef __APPLE__
	long fp, tp;
	combo->GetSelection(&fp, &tp);
	*fromPos = fp;
	*toPos = tp;
#endif
}

BBString * bmx_wxcombobox_getvalue(wxComboBox * combo) {
	return bbStringFromWxString(combo->GetValue());
}

void bmx_wxcombobox_paste(wxComboBox * combo) {
	combo->Paste();
}

void bmx_wxcombobox_redo(wxComboBox * combo) {
	combo->Redo();
}

void bmx_wxcombobox_replace(wxComboBox * combo, int fromPos, int toPos, BBString * text) {
	combo->Replace(fromPos, toPos, wxStringFromBBString(text));
}

void bmx_wxcombobox_remove(wxComboBox * combo, int fromPos, int toPos) {
	combo->Remove(fromPos, toPos);
}

void bmx_wxcombobox_setinsertionpoint(wxComboBox * combo, int pos) {
	combo->SetInsertionPoint(pos);
}

void bmx_wxcombobox_setinsertionpointend(wxComboBox * combo) {
	combo->SetInsertionPointEnd();
}

void bmx_wxcombobox_settextselection(wxComboBox * combo, int fromPos, int toPos) {
	combo->SetSelection(fromPos, toPos);
}

void bmx_wxcombobox_setvalue(wxComboBox * combo, BBString * text) {
	combo->SetValue(wxStringFromBBString(text));
}

void bmx_wxcombobox_undo(wxComboBox * combo) {
	combo->Undo();
}


int bmx_wxcombobox_geteventtype(int type) {
	switch(type) {
		case 15: return wxEVT_COMMAND_COMBOBOX_SELECTED;
		case -7: return wxEVT_COMMAND_TEXT_UPDATED;
		case -8: return wxEVT_COMMAND_TEXT_ENTER;
		case -63: return wxEVT_COMMAND_COMBOBOX_DROPDOWN;
		case -64: return wxEVT_COMMAND_COMBOBOX_CLOSEUP;
	}
	
	return 0;
}

// *********************************************

void bmx_wxcombobox_addresourcehandler() {
	wxXmlResource::Get()->AddHandler(new MaxComboBoxXmlHandler);
}
