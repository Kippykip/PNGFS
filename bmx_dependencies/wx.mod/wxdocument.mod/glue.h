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
#include "wx/docview.h"

class MaxDocument;
class MaxView;
class MaxDocManager;
class MaxDocTemplate;

extern "C" {

#include <blitz.h>

	BBObject * CB_PREF(wx_wxdocument_wxDocument__create)(wxDocument * doc);
	void CB_PREF(wx_wxdocument_wxDocument__OnChangedViewList)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxDocument__OnCloseDocument)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxDocument__OnCreate)(BBObject * handle, BBString * path, int flags);
	wxCommandProcessor * CB_PREF(wx_wxdocument_wxDocument__OnCreateCommandProcessor)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxDocument__OnNewDocument)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxDocument__OnOpenDocument)(BBObject * handle, BBString * filename);
	int CB_PREF(wx_wxdocument_wxDocument__OnSaveDocument)(BBObject * handle, BBString * filename);
	int CB_PREF(wx_wxdocument_wxDocument__OnSaveModified)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxDocument__IsModified)(BBObject * handle);
	void CB_PREF(wx_wxdocument_wxDocument__Modify)(BBObject * handle, int doModify);

	void CB_PREF(wx_wxdocument_wxView__OnActivateView)(BBObject * handle, int activate, wxView *activeView, wxView *deactiveView);
	void CB_PREF(wx_wxdocument_wxView__OnChangeFilename)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxView__OnClose)(BBObject * handle, int deleteWindow);
	void CB_PREF(wx_wxdocument_wxView__OnClosingDocument)(BBObject * handle);
	int CB_PREF(wx_wxdocument_wxView__OnCreate)(BBObject * handle, wxDocument* doc, int flags);
	wxPrintout * CB_PREF(wx_wxdocument_wxView__OnCreatePrintout)(BBObject * handle);
	void CB_PREF(wx_wxdocument_wxView__OnDraw)(BBObject * handle, MaxDC * dc);
	void CB_PREF(wx_wxdocument_wxView__OnUpdate)(BBObject * handle, wxView* sender);

	BBObject * CB_PREF(wx_wxdocument_wxDocTemplate__create)(wxDocTemplate * tmpl);
	int CB_PREF(wx_wxdocument_wxDocTemplate__InitDocument)(BBObject * handle, wxDocument * doc, BBString * path, int flags);
	wxDocument * CB_PREF(wx_wxdocument_wxDocTemplate__CreateDocument)(BBObject * handle, BBString * path, int flags);
	wxView * CB_PREF(wx_wxdocument_wxDocTemplate__CreateView)(BBObject * handle, wxDocument * doc, int flags);

	BBObject * CB_PREF(wx_wxdocument_wxView__create)(wxView * view);

	wxDocument * bmx_wxdocument_create(BBObject * handle);
	int bmx_wxdocument_addview(wxDocument * doc, wxView * view);
	int bmx_wxdocument_close(wxDocument * doc);
	int bmx_wxdocument_deleteallviews(wxDocument * doc);
	wxCommandProcessor * bmx_wxdocument_getcommandprocessor(wxDocument * doc);
	wxDocTemplate * bmx_wxdocument_getdocumenttemplate(wxDocument * doc);
	wxDocManager * bmx_wxdocument_getdocumentmanager(wxDocument * doc);
	BBString * bmx_wxdocument_getdocumentname(wxDocument * doc);
	wxWindow * bmx_wxdocument_getdocumentwindow(wxDocument * doc);
	BBString * bmx_wxdocument_getfilename(wxDocument * doc);
	wxView * bmx_wxdocument_getfirstview(wxDocument * doc);
	BBString * bmx_wxdocument_getuserreadablename(wxDocument * doc);
	BBString * bmx_wxdocument_gettitle(wxDocument * doc);
	int bmx_wxdocument_ismodified(MaxDocument * doc);
#if !defined(__WXGTK__)
	wxInputStream * bmx_wxdocument_loadobject(wxDocument * doc, wxInputStream * stream);
#endif
	void bmx_wxdocument_modify(MaxDocument * doc, int doModify);
	void bmx_wxdocument_onchangedviewlist(MaxDocument * doc);
	int bmx_wxdocument_onclosedocument(MaxDocument * doc);
	int bmx_wxdocument_oncreate(MaxDocument * doc, BBString * path, int flags);
	wxCommandProcessor * bmx_wxdocument_oncreatecommandprocessor(MaxDocument * doc);
	int bmx_wxdocument_onnewdocument(MaxDocument * doc);
	int bmx_wxdocument_onopendocument(MaxDocument * doc, BBString * filename);
	int bmx_wxdocument_onsavedocument(MaxDocument * doc, BBString * filename);
	int bmx_wxdocument_onsavemodified(MaxDocument * doc);
	int bmx_wxdocument_removeview(wxDocument * doc, wxView * view);
	int bmx_wxdocument_save(wxDocument * doc);
	int bmx_wxdocument_saveas(wxDocument * doc);
#if !defined(__WXGTK__)
	wxOutputStream * bmx_wxdocument_saveobject(wxDocument * doc, wxOutputStream * stream);
#endif
	void bmx_wxdocument_setcommandprocessor(wxDocument * doc, wxCommandProcessor * processor);
	void bmx_wxdocument_setdocumentname(wxDocument * doc, BBString * name);
	void bmx_wxdocument_setdocumenttemplate(wxDocument * doc, wxDocTemplate * templ);
	void bmx_wxdocument_setfilename(wxDocument * doc, BBString * filename, int notifyViews);
	void bmx_wxdocument_settitle(wxDocument * doc, BBString * title);
	void bmx_wxdocument_updateallviews(wxDocument * doc, wxView * sender);
	int bmx_wxdocument_alreadysaved(wxDocument * doc);
	void bmx_wxdocument_activate(wxDocument * doc);
	void bmx_wxdocument_setdocumentsaved(wxDocument * doc, int saved);
	int bmx_wxdocument_getdocumentsaved(wxDocument * doc);


	wxDocTemplate * bmx_wxdoctemplate_create(BBObject * handle, wxDocManager * manager, BBString *desc, BBString * filter,
			BBString * dir, BBString * ext, BBString * docTypeName, BBString * viewTypeName, int flags);
	BBString * bmx_wxdoctemplate_getdefaultextension(wxDocTemplate * templ);
	BBString * bmx_wxdoctemplate_getdescription(wxDocTemplate * templ);
	BBString * bmx_wxdoctemplate_getdirectory(wxDocTemplate * templ);
	wxDocManager * bmx_wxdoctemplate_getdocumentmanager(wxDocTemplate * templ);
	BBString * bmx_wxdoctemplate_getdocumentname(wxDocTemplate * templ);
	BBString * bmx_wxdoctemplate_getfilefilter(wxDocTemplate * templ);
	int bmx_wxdoctemplate_getflags(wxDocTemplate * templ);
	BBString * bmx_wxdoctemplate_getviewname(wxDocTemplate * templ);
	int bmx_wxdoctemplate_initdocument(MaxDocTemplate * templ, wxDocument * doc, BBString * path, int flags);
	int bmx_wxdoctemplate_isvisible(wxDocTemplate * templ);
	void bmx_wxdoctemplate_setdefaultextension(wxDocTemplate * templ, BBString * ext);
	void bmx_wxdoctemplate_setdescription(wxDocTemplate * templ, BBString * desc);
	void bmx_wxdoctemplate_setdirectory(wxDocTemplate * templ, BBString * dir);
	void bmx_wxdoctemplate_setfilefilter(wxDocTemplate * templ, BBString * filter);
	void bmx_wxdoctemplate_setflags(wxDocTemplate * templ, int flags);


	wxDocManager * bmx_wxdocmanager_create(BBObject * handle);
	void bmx_wxdocmanager_activateview(wxDocManager * mgr, wxView * doc, int activate);
	void bmx_wxdocmanager_adddocument(wxDocManager * mgr, wxDocument * doc);
	void bmx_wxdocmanager_addfiletohistory(wxDocManager * mgr, BBString * filename);
	void bmx_wxdocmanager_associatetemplate(wxDocManager * mgr, wxDocTemplate * temp);
	int bmx_wxdocmanager_closedocument(wxDocManager * mgr, wxDocument * doc, int force);
	int bmx_wxdocmanager_closedocuments(wxDocManager * mgr, int force);
	wxDocument * bmx_wxdocmanager_createdocument(wxDocManager * mgr, BBString * path, int flags);
	wxView * bmx_wxdocmanager_createview(wxDocManager * mgr, wxDocument * doc, int flags);
	void bmx_wxdocmanager_disassociatetemplate(wxDocManager * mgr, wxDocTemplate * temp);
	void bmx_wxdocmanager_filehistoryaddfilestomenu(wxDocManager * mgr);
	void bmx_wxdocmanager_filehistoryload(wxDocManager * mgr, wxConfigBase * config);
	void bmx_wxdocmanager_filehistoryremovemenu(wxDocManager * mgr, wxMenu * menu);
	void bmx_wxdocmanager_filehistorysave(wxDocManager * mgr, wxConfigBase * resourceFile);
	void bmx_wxdocmanager_filehistoryusemenu(wxDocManager * mgr, wxMenu * menu);
	wxDocument * bmx_wxdocmanager_finddocumentbypath(wxDocManager * mgr, BBString * path);
	wxDocTemplate * bmx_wxdocmanager_findtemplateforpath(wxDocManager * mgr, BBString * path);
	wxView * bmx_wxdocmanager_getanyusableview(wxDocManager * mgr);
	wxDocument * bmx_wxdocmanager_getcurrentdocument(wxDocManager * mgr);
	wxView * bmx_wxdocmanager_getcurrentview(wxDocManager * mgr);
	wxFileHistory * bmx_wxdocmanager_getfilehistory(wxDocManager * mgr);
	BBString * bmx_wxdocmanager_getlastdirectory(wxDocManager * mgr);
	int bmx_wxdocmanager_getmaxdocsopen(wxDocManager * mgr);
	int bmx_wxdocmanager_gethistoryfilescount(wxDocManager * mgr);
	BBString * bmx_wxdocmanager_makenewdocumentname(wxDocManager * mgr);
	void bmx_wxdocmanager_removedocument(wxDocManager * mgr, wxDocument * doc);
	void bmx_wxdocmanager_setlastdirectory(wxDocManager * mgr, BBString * dir);
	void bmx_wxdocmanager_setmaxdocsopen(wxDocManager * mgr, int num);
	void bmx_wxdocmanager_onmrufile(wxDocManager * mgr, wxCommandEvent & event);

	wxView * bmx_wxview_create(BBObject * handle);
	void bmx_wxview_activate(wxView * view, int doActivate);
	int bmx_wxview_close(wxView * view, int deleteWindow);
	wxDocument * bmx_wxview_getdocument(wxView * view);
	wxDocManager * bmx_wxview_getdocumentmanager(wxView * view);
	wxWindow * bmx_wxview_getframe(wxView * view);
	BBString * bmx_wxview_getviewname(wxView * view);
	void bmx_wxview_onactivateview(MaxView * view, int activate, wxView * activeView, wxView * deactiveView);
	void bmx_wxview_onchangefilename(MaxView * view);
	int bmx_wxview_onclose(MaxView * view, int deleteWindow);
	void bmx_wxview_onclosingdocument(MaxView * view);
	int bmx_wxView_oncreate(MaxView * view, wxDocument * doc, int flags);
	wxPrintout * bmx_wxview_oncreateprintout(MaxView * view);
	void bmx_wxview_ondraw(MaxView * view, MaxDC * dc);
	void bmx_wxview_onupdate(MaxView * view, wxView * sender);
	void bmx_wxview_setdocument(wxView * view, wxDocument * doc);
	void bmx_wxview_setframe(wxView * view, wxWindow * frame);
	void bmx_wxview_setviewname(wxView * view, BBString * name);


}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxDocument : public wxDocument
{

	DECLARE_DYNAMIC_CLASS(MaxDocument)

public:
	MaxDocument();
	MaxDocument(BBObject * handle);
	~MaxDocument();
	
	void OnChangedViewList();
	bool OnCloseDocument();
	bool OnCreate(const wxString& path, long flags);
	wxCommandProcessor* OnCreateCommandProcessor();
	bool OnNewDocument();
	bool OnOpenDocument(const wxString& filename);
	bool OnSaveDocument(const wxString& filename);
	bool OnSaveModified();
	bool IsModified() const;
	void Modify(bool doModify);

	void OnChangedViewList_default();
	bool OnCloseDocument_default();
	bool OnCreate_default(const wxString& path, long flags);
	wxCommandProcessor* OnCreateCommandProcessor_default();
	bool OnNewDocument_default();
	bool OnOpenDocument_default(const wxString& filename);
	bool OnSaveDocument_default(const wxString& filename);
	bool OnSaveModified_default();
	bool IsModified_default();
	void Modify_default(bool doModify);

private:
	BBObject * maxHandle;
};

class MaxView : public wxView
{

	DECLARE_DYNAMIC_CLASS(MaxView)

public:
	MaxView();
	MaxView(BBObject * handle);
	~MaxView();

	void OnActivateView(bool activate, wxView *activeView, wxView *deactiveView);
	void OnChangeFilename();
	bool OnClose(bool deleteWindow);
	void OnClosingDocument();
	bool OnCreate(wxDocument* doc, long flags);
	wxPrintout* OnCreatePrintout();
	void OnDraw(wxDC* dc);
	void OnUpdate(wxView* sender, wxObject* hint);

	void OnActivateView_default(bool activate, wxView *activeView, wxView *deactiveView);
	void OnChangeFilename_default();
	bool OnClose_default(bool deleteWindow);
	void OnClosingDocument_default();
	bool OnCreate_default(wxDocument* doc, long flags);
	wxPrintout* OnCreatePrintout_default();
	void OnDraw_default(wxDC* dc);
	void OnUpdate_default(wxView* sender, wxObject* hint);

private:
	BBObject * maxHandle;
};

class MaxDocTemplate : public wxDocTemplate
{
public: 
	MaxDocTemplate(BBObject * handle, wxDocManager* manager, const wxString& descr, const wxString& filter,
		const wxString& dir, const wxString& ext, const wxString& docTypeName, const wxString& viewTypeName, long flags);
	~MaxDocTemplate();
	
	bool InitDocument(wxDocument* doc, const wxString& path, long flags = 0);

	bool InitDocument_default(wxDocument* doc, const wxString& path, long flags = 0);

    wxDocument * CreateDocument(const wxString& path, long flags = 0);
    wxView * CreateView(wxDocument* doc, long flags = 0);
	
private: 
	BBObject * maxHandle;
};

class MaxDocManager : public wxDocManager
{
public: 
	MaxDocManager(BBObject * handle);
	~MaxDocManager();
	
private: 

};



