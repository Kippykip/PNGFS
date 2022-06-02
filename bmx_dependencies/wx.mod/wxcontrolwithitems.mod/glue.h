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

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	int bmx_wxcontrolwithitems_append(wxControlWithItems * control, BBString * item, BBObject * clientData);
	void bmx_wxcontrolwithitems_clear(wxControlWithItems * control);
	void bmx_wxcontrolwithitems_deleteitem(wxControlWithItems * control, int item);
	int bmx_wxcontrolwithitems_getselection(wxControlWithItems * control);
	int bmx_wxcontrolwithitems_getcount(wxControlWithItems * control);
	int bmx_wxcontrolwithitems_isempty(wxControlWithItems * control);
	void bmx_wxcontrolwithitems_selectitem(wxControlWithItems * control, int item);
	int bmx_wxcontrolwithitems_insert(wxControlWithItems * control, BBString * item, int pos, BBObject * clientData);
	BBString * bmx_wxcontrolwithitems_getstring(wxControlWithItems * control, int item);
	void bmx_wxcontrolwithitems_setselection(wxControlWithItems * control, int item);

	void bmx_wxcontrolwithitems_appenditems(wxControlWithItems * control, BBArray * items);
	int bmx_wxcontrolwithitems_findstring(wxControlWithItems * control, BBString * text, int caseSensitive);
	BBObject * bmx_wxcontrolwithitems_getclientdata(wxControlWithItems * control, int item);
	BBArray * bmx_wxcontrolwithitems_getstrings(wxControlWithItems * control);
	BBString * bmx_wxcontrolwithitems_getstringselection(wxControlWithItems * control);
	void bmx_wxcontrolwithitems_setclientdata(wxControlWithItems * control, int item, BBObject * clientData);
	void bmx_wxcontrolwithitems_setstring(wxControlWithItems * control, unsigned int item, BBString * text);
	int bmx_wxcontrolwithitems_setstringselection(wxControlWithItems * control, BBString * text);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

