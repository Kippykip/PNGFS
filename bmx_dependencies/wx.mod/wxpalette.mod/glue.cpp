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

MaxPalette::MaxPalette(const wxPalette& p)
{
	palette = wxPalette(p);
}

wxPalette & MaxPalette::Palette() {
	return palette;
}


// *********************************************


MaxPalette * bmx_wxpalette_create(BBArray * r, BBArray * g, BBArray *b) {
	wxPalette p(r->scales[0], (unsigned char*)BBARRAYDATA( r,r->dims ),
		(unsigned char*)BBARRAYDATA( g,g->dims ), (unsigned char*)BBARRAYDATA( b,b->dims ));
	return new MaxPalette(p);
}

int bmx_wxpalette_getcolourscount(MaxPalette * palette) {
	return palette->Palette().GetColoursCount();
}

int bmx_wxpalette_getpixel(MaxPalette * palette, int red, int green, int blue) {
	return palette->Palette().GetPixel(static_cast<unsigned char>(red),
		static_cast<unsigned char>(green), static_cast<unsigned char>(blue));
}

int bmx_wxpalette_getrgb(MaxPalette * palette, int pixel, int * red, int * green, int * blue) {
	unsigned char* r, *g, *b;
	bool ret = palette->Palette().GetRGB(pixel, r, g, b);
	*red = static_cast<int>(*r);
	*green = static_cast<int>(*g);
	*blue = static_cast<int>(*b);
	return static_cast<int>(ret);
}

int bmx_wxpalette_isok(MaxPalette * palette) {
	return static_cast<int>(palette->Palette().IsOk());
}

void bmx_wxpalette_delete(MaxPalette * palette) {
	delete palette;
}
