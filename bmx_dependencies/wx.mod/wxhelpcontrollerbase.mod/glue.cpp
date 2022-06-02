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



// *********************************************

int bmx_wxhelpcontrollerbase_initialize(wxHelpControllerBase * controller, BBString * file) {
	return static_cast<int>(controller->Initialize(wxStringFromBBString(file)));
}


int bmx_wxhelpcontrollerbase_displayBlock(wxHelpControllerBase * controller, int blockNo) {
	return static_cast<int>(controller->DisplayBlock(blockNo));
}

int bmx_wxhelpcontrollerbase_displaycontextpopup(wxHelpControllerBase * controller, int contextId) {
	return static_cast<int>(controller->DisplayContextPopup(contextId));
}

int bmx_wxhelpcontrollerbase_displaysection(wxHelpControllerBase * controller, int sectionNo) {
	return static_cast<int>(controller->DisplaySection(sectionNo));
}

int bmx_wxhelpcontrollerbase_displaysectionbyname(wxHelpControllerBase * controller, BBString * section) {
	return static_cast<int>(controller->DisplaySection(wxStringFromBBString(section)));
}

int bmx_wxhelpcontrollerbase_displaytextpopup(wxHelpControllerBase * controller, BBString * text, int x, int y) {
	return static_cast<int>(controller->DisplayTextPopup(wxStringFromBBString(text), wxPoint(x, y)));
}

wxWindow * bmx_wxhelpcontrollerbase_getparentwindow(wxHelpControllerBase * controller) {
	return controller->GetParentWindow();
}

int bmx_wxhelpcontrollerbase_quit(wxHelpControllerBase * controller) {
	return static_cast<int>(controller->Quit());
}


int bmx_wxhelpcontrollerbase_keywordsearch(wxHelpControllerBase * cont, BBString * keyword, wxHelpSearchMode mode) {
	return static_cast<int>(cont->KeywordSearch(wxStringFromBBString(keyword), mode));
}

void bmx_wxhelpcontrollerbase_displaycontents(wxHelpControllerBase * cont) {
	cont->DisplayContents();
}


