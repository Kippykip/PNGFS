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

MaxAcceleratorTable::MaxAcceleratorTable(const wxAcceleratorTable & t)
	: table(t)
{
}

wxAcceleratorTable & MaxAcceleratorTable::Table() {
	return table;
}

// ---------------------------------------------------------------------------------------



// *********************************************

MaxAcceleratorTable * bmx_wxacceleratortable_create(BBArray * p) {
	int n = p->scales[0];
	wxAcceleratorEntry * entries = new wxAcceleratorEntry[n];

	for( int i=0;i<n;++i ){
		entries[i] = *CB_PREF(wx_wxacceleratortable_wxAcceleratorTable__getEntry)(p, i);
	}

	wxAcceleratorTable table(n, entries);
	delete [] entries;
	return new MaxAcceleratorTable(table);
}

int bmx_wxacceleratortable_isok(MaxAcceleratorTable * table) {
	return static_cast<int>(table->Table().IsOk());
}

void bmx_wxacceleratortable_delete(MaxAcceleratorTable * table) {
	delete table;
}


// *********************************************


