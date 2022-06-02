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

MaxInputStream::MaxInputStream(BBObject * handle)
	: maxHandle(handle)
{
}

MaxInputStream::~MaxInputStream() {
}

//bool MaxInputStream::Eof() const {
//	return _wx_wxstream_wxMaxInputStream__eof(maxHandle);
//}

//wxInputStream& MaxInputStream::Read(void *buffer, size_t size) {
//	MaxInputStream * s = _wx_wxstream_wxMaxInputStream__read(maxHandle, buffer, size);
//	return *s;
//}

size_t MaxInputStream::OnSysRead(void *buffer, size_t bufsize){
	return CB_PREF(wx_wxstream_wxMaxInputStream__sysread)(maxHandle, buffer, bufsize);
}

wxFileOffset MaxInputStream::OnSysSeek(wxFileOffset seek, wxSeekMode mode) {
	return CB_PREF(wx_wxstream_wxMaxInputStream__sysseek)(maxHandle, seek, mode);
}

wxFileOffset MaxInputStream::OnSysTell() const {
	return CB_PREF(wx_wxstream_wxMaxInputStream__systell)(maxHandle);
}

// *********************************************

MaxInputStream * bmx_wxmaxinputstream_create(BBObject * handle) {
	return new MaxInputStream(handle);
}

void bmx_wxmaxinputstream_delete(MaxInputStream * handle) {
	delete handle;
}

