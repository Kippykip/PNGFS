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
#include "wx/valtext.h"

#ifndef _WX_MAX_TEXTVALIDATOR_H_
#define _WX_MAX_TEXTVALIDATOR_H_

extern "C" {

#include <blitz.h>

	wxTextValidator * bmx_wxtextvalidator_create(long style);
	wxWindow * bmx_wxtextvalidator_getwindow(wxTextValidator * validator);
	void bmx_wxtextvalidator_setwindow(wxTextValidator * validator, wxWindow * window);
	BBArray * bmx_wxtextvalidator_getexcludes(wxTextValidator * validator);
	BBArray *bmx_wxtextvalidator_getincludes(wxTextValidator * validator);
	long bmx_wxtextvalidator_getstyle(wxTextValidator * validator);
	void bmx_wxtextvalidator_setexcludes(wxTextValidator * validator, BBArray * list);
	void bmx_wxtextvalidator_setincludes(wxTextValidator * validator, BBArray * list);
	void bmx_wxtextvalidator_setstyle(wxTextValidator * validator, long style);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#endif // _WX_MAX_TEXTVALIDATOR_H_
