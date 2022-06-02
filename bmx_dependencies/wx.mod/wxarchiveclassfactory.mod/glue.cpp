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

const wxArchiveClassFactory * bmx_wxarchiveclassfactory_find(BBString * protocol, wxStreamProtocolType protocolType) {
	return wxArchiveClassFactory::Find(wxStringFromBBString(protocol), protocolType);
}

int bmx_wxarchiveclassfactory_canhandle(wxArchiveClassFactory * factory, BBString * protocol, wxStreamProtocolType protocolType) {
	return static_cast<int>(factory->CanHandle(wxStringFromBBString(protocol), protocolType));
}

BBString * bmx_wxarchiveclassfactory_getprotocol(wxArchiveClassFactory * factory) {
	return bbStringFromWxString(factory->GetProtocol());
}

wxFilterInputStream * bmx_wxarchiveclassfactory_newinputstream(wxArchiveClassFactory * factory, wxInputStream * stream) {
	return factory->NewStream(stream);
}

BBString * bmx_wxarchiveclassfactory_popextension(wxArchiveClassFactory * factory, BBString * location) {
	return bbStringFromWxString(factory->PopExtension(wxStringFromBBString(location)));
}

void bmx_wxarchiveclassfactory_pushfront(wxArchiveClassFactory * factory) {
	factory->PushFront();
}

void bmx_wxarchiveclassfactory_remove(wxArchiveClassFactory * factory) {
	factory->Remove();
}


