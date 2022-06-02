/*
  Copyright (c) 2007-2018 Bruce A Henderson & Oliver Skawronek
 
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
#include "wx/sound.h"

class MaxSound;

extern "C" {

#include <blitz.h>
	MaxSound * bmx_wxsound_create(BBObject * handle, BBString * fileName, int isResource);
	int bmx_wxsound_isok(wxSound * sound);
	// bool bmx_wxsound_isplaying(wxSound * sound);
	int bmx_wxsound_play(wxSound * sound, int flags);
	void bmx_wxsound_stop(wxSound * sound);
	void bmx_wxsound_free(wxSound * sound);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxSound : public wxSound
{
public:
	MaxSound(BBObject * handle, BBString * fileName, bool isResource);
	~MaxSound();

};
