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

MaxVScrolledWindow::MaxVScrolledWindow(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style)
	: wxVScrolledWindow(parent, id, wxPoint(x, y), wxSize(w, h), style)
{
	wxbind(this, handle);
}

MaxVScrolledWindow::~MaxVScrolledWindow() {
	wxunbind(this);
}

wxCoord MaxVScrolledWindow::OnGetRowHeight(size_t n) const {
	return CB_PREF(wx_wxvscrolledwindow_wxVScrolledWindow__OnGetRowHeight)(this, n);
}

void MaxVScrolledWindow::OnGetRowsHeightHint(size_t lineMin, size_t lineMax) const {
	CB_PREF(wx_wxvscrolledwindow_wxVScrolledWindow__OnGetRowsHeightHint)(this, lineMin, lineMax);
}


// *********************************************

BEGIN_EVENT_TABLE(MaxVScrolledWindow, wxVScrolledWindow)
END_EVENT_TABLE()

MaxVScrolledWindow * bmx_wxvscrolledwindow_create(BBObject * maxHandle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style) {
	return new MaxVScrolledWindow(maxHandle, parent, id, x, y, w, h, style);
}

int bmx_wxvscrolledwindow_getvisiblerowsbegin(wxVScrolledWindow * window) {
	return window->GetVisibleRowsBegin();
}

int bmx_wxvscrolledwindow_getvisiblerowsend(wxVScrolledWindow * window) {
	return window->GetVisibleRowsEnd();
}

int bmx_wxvscrolledwindow_getrowcount(wxVScrolledWindow * window) {
	return window->GetRowCount();
}

int bmx_wxvscrolledwindow_getvisiblebegin(wxVScrolledWindow * window) {
	return window->GetVisibleBegin();
}

int bmx_wxvscrolledwindow_getvisibleend(wxVScrolledWindow * window) {
	return window->GetVisibleEnd();
}

int bmx_wxvscrolledwindow_hittest(wxVScrolledWindow * window, int x, int y) {
	return window->HitTest(x, y);
}

int bmx_wxvscrolledwindow_isvisible(wxVScrolledWindow * window, int line) {
	return static_cast<int>(window->IsVisible(line));
}

void bmx_wxvscrolledwindow_refreshrow(wxVScrolledWindow * window, int line) {
	window->RefreshRow(line);
}

void bmx_wxvscrolledwindow_refreshrows(wxVScrolledWindow * window, int fromLine, int toLine) {
	window->RefreshRows(fromLine, toLine);
}

void bmx_wxvscrolledwindow_refreshall(wxVScrolledWindow * window) {
	window->RefreshAll();
}

int bmx_wxvscrolledwindow_scrollrows(wxVScrolledWindow * window, int lines) {
	return static_cast<int>(window->ScrollRows(lines));
}

int bmx_wxvscrolledwindow_scrollrowpages(wxVScrolledWindow * window, int pages) {
	return static_cast<int>(window->ScrollRowPages(pages));
}

int bmx_wxvscrolledwindow_scrolltorow(wxVScrolledWindow * window, int line) {
	return static_cast<int>(window->ScrollToRow(line));
}

void bmx_wxvscrolledwindow_setrowcount(wxVScrolledWindow * window, int count) {
	window->SetRowCount(count);
}


