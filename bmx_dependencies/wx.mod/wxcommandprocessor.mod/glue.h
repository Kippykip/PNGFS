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
#include "wx/cmdproc.h"

class MaxCommandProcessor;

extern "C" {

#include <blitz.h>

	wxCommandProcessor * bmx_wxcommandprocessor_create(BBObject * handle, int maxCommands);
	int bmx_wxcommandprocessor_canundo(wxCommandProcessor * proc);
	void bmx_wxcommandprocessor_clearcommands(wxCommandProcessor * proc);
	int bmx_wxcommandprocessor_redo(wxCommandProcessor * proc);
	int bmx_wxcommandprocessor_getmaxcommands(wxCommandProcessor * proc);
	wxMenu * bmx_wxcommandprocessor_geteditmenu(wxCommandProcessor * proc);
	BBString * bmx_wxcommandprocessor_getredoaccelerator(wxCommandProcessor * proc);
	BBString * bmx_wxcommandprocessor_getredomenulabel(wxCommandProcessor * proc);
	BBString * bmx_wxcommandprocessor_getundoaccelerator(wxCommandProcessor * proc);
	BBString * bmx_wxcommandprocessor_getundomenulabel(wxCommandProcessor * proc);
	void bmx_wxcommandprocessor_initialize(wxCommandProcessor * proc);
	int bmx_wxcommandprocessor_isdirty(wxCommandProcessor * proc);
	void bmx_wxcommandprocessor_markassaved(wxCommandProcessor * proc);
	void bmx_wxcommandprocessor_seteditmenu(wxCommandProcessor * proc, wxMenu * menu);
	void bmx_wxcommandprocessor_setmenustrings(wxCommandProcessor * proc);
	void bmx_wxcommandprocessor_setredoaccelerator(wxCommandProcessor * proc, BBString * accel);
	void bmx_wxcommandprocessor_setundoaccelerator(wxCommandProcessor * proc, BBString * accel);
	int bmx_wxcommandprocessor_submit(wxCommandProcessor * proc, wxCommand * command, int storeIt);
	int bmx_wxcommandprocessor_undo(wxCommandProcessor * proc);

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class MaxCommandProcessor : public wxCommandProcessor
{
public:
	MaxCommandProcessor(BBObject * handle, int maxCommands);
	~MaxCommandProcessor();

private:
	BBObject * maxHandle;
};

