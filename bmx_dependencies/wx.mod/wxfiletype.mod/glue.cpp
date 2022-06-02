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

void bmx_wxfiletype_delete(wxFileType * type) {
	delete type;
}

BBString * bmx_wxfiletype_getdescription(wxFileType * type) {
	wxString desc;
	bool val = type->GetDescription(&desc);
	if (val) {
		return bbStringFromWxString(desc);
	} else {
		return &bbEmptyString;
	}
}

BBArray * bmx_wxfiletype_getextensions(wxFileType * type) {
	wxArrayString arr;
	bool val = type->GetExtensions(arr);
	if (val) {
		return wxArrayStringToBBStringArray(arr);
	} else {
		return &bbEmptyArray;
	}
}

BBString * bmx_wxfiletype_getmimtype(wxFileType * type) {
	wxString desc;
	bool val = type->GetMimeType(&desc);
	if (val) {
		return bbStringFromWxString(desc);
	} else {
		return &bbEmptyString;
	}
}

BBArray * bmx_wxfiletype_getmimetypes(wxFileType * type) {
	wxArrayString arr;
	bool val = type->GetMimeTypes(arr);
	if (val) {
		return wxArrayStringToBBStringArray(arr);
	} else {
		return &bbEmptyArray;
	}
}

BBString * bmx_wxfiletype_getopencommand(wxFileType * type, BBString * filename) {
	wxString desc;
	bool val = type->GetOpenCommand(&desc, wxStringFromBBString(filename));
	if (val) {
		return bbStringFromWxString(desc);
	} else {
		return &bbEmptyString;
	}
}

MaxIconLocation * bmx_wxfiletype_geticon(wxFileType * type) {
	wxIconLocation loc;
	if (type->GetIcon(&loc)) {
		return new MaxIconLocation(loc);
	} else {
		return 0;
	}
}


