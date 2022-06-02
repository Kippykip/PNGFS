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

wxStandardPathsBase * bmx_wxstandardpaths_get() {
	return &wxStandardPaths::Get();
}

BBString * bmx_wxstandardpaths_getconfigdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetConfigDir());
}

BBString * bmx_wxstandardpaths_getdatadir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetDataDir());
}

BBString * bmx_wxstandardpaths_getdocumentsdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetDocumentsDir());
}

BBString * bmx_wxstandardpaths_getexecutablepath(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetExecutablePath());
}


#ifdef __WXGTK__
BBString * bmx_wxstandardpaths_getinstallprefix(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetInstallPrefix());
}
#endif

BBString * bmx_wxstandardpaths_getlocaldatadir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetLocalDataDir());
}

BBString * bmx_wxstandardpaths_getpluginsdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetPluginsDir());
}

BBString * bmx_wxstandardpaths_getresourcesdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetResourcesDir());
}

BBString * bmx_wxstandardpaths_gettempdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetTempDir());
}

BBString * bmx_wxstandardpaths_getuserconfigdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetUserConfigDir());
}

BBString * bmx_wxstandardpaths_getuserdatadir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetUserDataDir());
}

BBString * bmx_wxstandardpaths_getuserlocaldatadir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetUserLocalDataDir());
}


#ifdef __WXGTK__
void bmx_wxstandardpaths_setinstallprefix(wxStandardPaths * sp, BBString * prefix) {
	sp->SetInstallPrefix(wxStringFromBBString(prefix));
}
#endif

BBString * bmx_wxstandardpaths_getappdocumentsdir(wxStandardPaths * sp) {
	return bbStringFromWxString(sp->GetAppDocumentsDir());
}

#ifdef __WXMSW__
void bmx_wxstandardpaths_dontignoreappsubdir(wxStandardPaths * sp) {
	sp->DontIgnoreAppSubDir();
}

void bmx_wxstandardpaths_ignoreappbuidsubdirs(wxStandardPaths * sp) {
	sp->IgnoreAppBuildSubDirs();
}

void bmx_wxstandardpaths_ignoreappsubdir(wxStandardPaths * sp, BBString * subdirPattern) {
	sp->IgnoreAppSubDir(wxStringFromBBString(subdirPattern));
}

BBString * bmx_wxstandardpaths_mswgetshelldir(int csidl) {
	return bbStringFromWxString(wxStandardPaths::MSWGetShellDir(csidl));
}
#endif

BBString * bmx_wxstandardpaths_getuserdir(wxStandardPaths * sp, int dir) {
	return bbStringFromWxString(sp->GetUserDir(static_cast<wxStandardPaths::Dir>(dir)));
}


