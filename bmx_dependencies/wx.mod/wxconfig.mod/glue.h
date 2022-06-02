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
#include "wx/confbase.h"

//class MaxNotebook;

extern "C" {

#include <blitz.h>

	wxConfigBase * bmx_wxconfigbase_set(wxConfigBase * config);
	wxConfigBase * bmx_wxconfigbase_get(int onDemand);

	void bmx_wxconfigbase_dontcreateondemand(wxConfigBase * config);

	int bmx_wxconfigbase_deleteall(wxConfigBase * config);
	int bmx_wxconfigbase_deleteentry(wxConfigBase * config, BBString * key, int deleteGroupIfEmpty);
	int bmx_wxconfigbase_deletegroup(wxConfigBase * config, BBString * key);
	int bmx_wxconfigbase_exists(wxConfigBase * config, BBString * name);
	int bmx_wxconfigbase_flush(wxConfigBase * config, int currentOnly);
	BBString * bmx_wxconfigbase_getappname(wxConfigBase * config);
	wxConfigBase::EntryType bmx_wxconfigbase_getentrytype(wxConfigBase * config, BBString * name);
	BBString * bmx_wxconfigbase_getfirstgroup(wxConfigBase * config, int * index, int * cont);
	int bmx_wxconfigbase_getfirstentry(wxConfigBase * config, BBString * name, int * index);
	BBString * bmx_wxconfigbase_getnextgroup(wxConfigBase * config, int * index, int * cont);
	int bmx_wxconfigbase_getnextentry(wxConfigBase * config, BBString * name, int * index);
	unsigned int bmx_wxconfigbase_getnumberofentries(wxConfigBase * config, int recursive);
	unsigned int bmx_wxconfigbase_getnumberofgroups(wxConfigBase * config, int recursive);
	BBString * bmx_wxconfigbase_getpath(wxConfigBase * config);
	BBString * bmx_wxconfigbase_getvendorname(wxConfigBase * config);
	int bmx_wxconfigbase_hasentry(wxConfigBase * config, BBString * name);
	int bmx_wxconfigbase_hasgroup(wxConfigBase * config, BBString * name);
	int bmx_wxconfigbase_isexpandingenvvars(wxConfigBase * config);
	int bmx_wxconfigbase_isrecordingdefaults(wxConfigBase * config);
	BBString * bmx_wxconfigbase_readstring(wxConfigBase * config, BBString * key, BBString * defaultValue);
	int bmx_wxconfigbase_readint(wxConfigBase * config, BBString * key, int defaultValue);
	int bmx_wxconfigbase_readbool(wxConfigBase * config, BBString * key, int defaultValue);
	double bmx_wxconfigbase_readdouble(wxConfigBase * config, BBString * key, double defaultValue);
	int bmx_wxconfigbase_renameentry(wxConfigBase * config, BBString * oldname, BBString * newname);
	int bmx_wxconfigbase_renamegroup(wxConfigBase * config, BBString * oldname, BBString * newname);
	void bmx_wxconfigbase_setexpandenvvars(wxConfigBase * config, int doIt);
	void bmx_wxconfigbase_setpath(wxConfigBase * config, BBString * path);
	void bmx_wxconfigbase_setrecorddefaults(wxConfigBase * config, int doIt);
	int bmx_wxconfigbase_writestring(wxConfigBase * config, BBString * key, BBString * value);
	int bmx_wxconfigbase_writeint(wxConfigBase * config, BBString * key, int value);
	int bmx_wxconfigbase_writebool(wxConfigBase * config, BBString * key, int value);
	int bmx_wxconfigbase_writedouble(wxConfigBase * config, BBString * key, double value);

	void bmx_wxconfigbase_free(wxConfigBase * config);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

