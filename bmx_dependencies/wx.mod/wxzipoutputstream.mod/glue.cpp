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

wxZipOutputStream * bmx_wxzipoutputstream_create(wxOutputStream * s, int level) {
	return new wxZipOutputStream(*s, level);
}

int bmx_wxzipoutputstream_close(wxZipOutputStream * s) {
	return static_cast<int>(s->Close());
}

int bmx_wxzipoutputstream_closeentry(wxZipOutputStream * s) {
	return static_cast<int>(s->CloseEntry());
}

int bmx_wxzipoutputstream_getlevel(wxZipOutputStream * s) {
	return s->GetLevel();
}

void bmx_wxzipoutputstream_setlevel(wxZipOutputStream * s, int level) {
	s->SetLevel(level);
}

int bmx_wxzipoutputstream_putnextdirentry(wxZipOutputStream * s, BBString * name, MaxDateTime * dt) {
	return static_cast<int>(s->PutNextDirEntry(wxStringFromBBString(name), (dt)?dt->DateTime():wxDateTime::Now()));
}

int bmx_wxzipoutputstream_putnextentry(wxZipOutputStream * s, BBString * name, MaxDateTime * dt) {
	return static_cast<int>(s->PutNextEntry(wxStringFromBBString(name), (dt)?dt->DateTime():wxDateTime::Now()));
}

void bmx_wxzipoutputstream_setcomment(wxZipOutputStream * s, BBString * comment) {
	s->SetComment(wxStringFromBBString(comment));
}

void bmx_wxzipoutputstream_delete(wxZipOutputStream * s) {
	delete s;
}


