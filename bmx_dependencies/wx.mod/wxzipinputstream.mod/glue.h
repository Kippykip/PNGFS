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
#include "wx/zipstrm.h"

extern "C" {

#include <blitz.h>

	wxZipInputStream * bmx_wxzipinputstream_create(wxInputStream * stream);
	int bmx_wxzipinputstream_closeentry(wxZipInputStream * stream);
	BBString * bmx_wxzipinputstream_getcomment(wxZipInputStream * stream);
	wxZipEntry * bmx_wxzipinputstream_getnextentry(wxZipInputStream * stream);
	int bmx_wxzipinputstream_gettotalentries(wxZipInputStream * stream);
	int bmx_wxzipinputstream_openentry(wxZipInputStream * stream, wxZipEntry * entry);
	void bmx_wxzipinputstream_free(wxZipInputStream * stream);
	

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

