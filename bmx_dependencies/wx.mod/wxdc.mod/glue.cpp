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

MaxMirrorDC::MaxMirrorDC(wxDC * dc, bool mirror)
	: mirrorDC(*dc, mirror)
{
	MaxDC::init(&mirrorDC);
}

MaxClientDC::MaxClientDC(wxWindow * window)
	: clientDC(window)
{
	MaxDC::init(&clientDC);
}


// *********************************************



MaxMirrorDC * bmx_wxmirrordc_create(MaxDC * dc, int mirror) {
	return new MaxMirrorDC(dc->GetDC(), static_cast<bool>(mirror));
}

void bmx_wxdc_clear(MaxDC * dc) {
	dc->GetDC()->Clear();
}

void bmx_wxdc_setbackground(MaxDC * dc, MaxBrush * brush) {
	dc->GetDC()->SetBackground(brush->Brush());
}

void bmx_wxdc_drawtext(MaxDC * dc, BBString * text, int x, int y) {
	dc->GetDC()->DrawText(wxStringFromBBString(text), x, y);
}

int bmx_wxdc_getcharheight(MaxDC * dc) {
	return dc->GetDC()->GetCharHeight();
}

void bmx_wxdc_setfont(MaxDC * dc, MaxFont * font) {
	dc->GetDC()->SetFont(font->Font());
}

void bmx_wxdc_settextbackground(MaxDC * dc, MaxColour * colour) {
	dc->GetDC()->SetTextBackground(colour->Colour());
}

void bmx_wxdc_settextforeground(MaxDC * dc, MaxColour * colour) {
	dc->GetDC()->SetTextForeground(colour->Colour());
}

void bmx_wxdc_gettextextent(MaxDC * dc, BBString * text, int * w, int * h) {
	wxSize s = dc->GetDC()->GetTextExtent(wxStringFromBBString(text));
	*w = s.x;
	*h = s.y;
}

void bmx_wxdc_setmapmode(MaxDC * dc, wxMappingMode mode) {
	dc->GetDC()->SetMapMode(mode);
}

void bmx_wxdc_setpen(MaxDC * dc, MaxPen * pen) {
	dc->GetDC()->SetPen(pen->Pen());
}

void bmx_wxdc_setuserscale(MaxDC * dc, double xscale, double yscale) {
	dc->GetDC()->SetUserScale(xscale, yscale);
}

void bmx_wxdc_drawline(MaxDC * dc, int x1, int y1, int x2, int y2) {
	dc->GetDC()->DrawLine(x1, y1, x2, y2);
}

void bmx_wxdc_setbackgroundmode(MaxDC * dc, int mode) {
	dc->GetDC()->SetBackgroundMode(mode);
}

void bmx_wxdc_setbrush(MaxDC * dc, MaxBrush * brush) {
	dc->GetDC()->SetBrush(brush->Brush());
}

void bmx_wxdc_setclippingregion(MaxDC * dc, int x, int y, int w, int h) {
	dc->GetDC()->SetClippingRegion(x, y, w, h);
}

void bmx_wxdc_setclippingregionregion(MaxDC * dc, MaxRegion * region) {
	dc->GetDC()->SetClippingRegion(region->Region());
}

void bmx_wxdc_setdeviceorigin(MaxDC * dc, int x, int y) {
	dc->GetDC()->SetDeviceOrigin(x, y);
}

void bmx_wxdc_drawellipse(MaxDC * dc, int x, int y, int w, int h) {
	dc->GetDC()->DrawEllipse(x, y, w, h);
}

void bmx_wxdc_drawellipserect(MaxDC * dc, MaxRect * rect) {
	dc->GetDC()->DrawEllipse(rect->Rect());
}

void bmx_wxdc_drawrectangle(MaxDC * dc, int x, int y, int w, int h) {
	dc->GetDC()->DrawRectangle(x, y, w, h);
}

void bmx_wxdc_drawrectanglerect(MaxDC * dc, MaxRect * rect) {
	dc->GetDC()->DrawRectangle(rect->Rect());
}

void bmx_wxdc_drawroundedrectangle(MaxDC * dc, int x, int y, int w, int h, double radius) {
	dc->GetDC()->DrawRoundedRectangle(x, y, w, h, radius);
}

void bmx_wxdc_drawroundedrectanglerect(MaxDC * dc, MaxRect * rect, double radius) {
	dc->GetDC()->DrawRoundedRectangle(rect->Rect(), radius);
}

void wx_wxdc_calcboundingbox(MaxDC * dc, int x, int y) {
	dc->GetDC()->CalcBoundingBox(x, y);
}

//void wx_wxdc_computescaleandorigin(MaxDC * dc) {
//	dc->GetDC()->ComputeScaleAndOrigin();
//}

void wx_wxdc_crosshair(MaxDC * dc, int x, int y) {
	dc->GetDC()->CrossHair(x, y);
}

void wx_wxdc_destroyclippingregion(MaxDC * dc) {
	dc->GetDC()->DestroyClippingRegion();
}

int wx_wxdc_devicetologicalx(MaxDC * dc, int x) {
	return dc->GetDC()->DeviceToLogicalX(x);
}

int wx_wxdc_devicetologicalxrel(MaxDC * dc, int x) {
	return dc->GetDC()->DeviceToLogicalXRel(x);
}

int wx_wxdc_devicetologicaly(MaxDC * dc, int y) {
	return dc->GetDC()->DeviceToLogicalY(y);
}

int wx_wxdc_devicetologicalyrel(MaxDC * dc, int y) {
	return dc->GetDC()->DeviceToLogicalYRel(y);
}

void wx_wxdc_drawarc(MaxDC * dc, int x1, int y1, int x2, int y2, int xc, int yc) {
	dc->GetDC()->DrawArc(x1, y1, x2, y2, xc, yc);
}

void wx_wxdc_drawbitmap(MaxDC * dc, MaxBitmap * bitmap, int x, int y, int transparent) {
	dc->GetDC()->DrawBitmap(bitmap->Bitmap(), x, y, static_cast<bool>(transparent));
}

void wx_wxdc_drawcheckmark(MaxDC * dc, int x, int y, int w, int h) {
	dc->GetDC()->DrawCheckMark(x, y, w, h);
}

void wx_wxdc_drawcheckmarkrect(MaxDC * dc, MaxRect * rect) {
	dc->GetDC()->DrawCheckMark(rect->Rect());
}

void wx_wxdc_drawcircle(MaxDC * dc, int x, int y, int radius) {
	dc->GetDC()->DrawCircle(x, y, radius);
}


void bmx_wxdc_drawellipticarc(MaxDC * dc, int x, int y, int width, int height, double _start, double _end) {
	dc->GetDC()->DrawEllipticArc(x, y, width, height, _start, _end);
}

void bmx_wxdc_drawicon(MaxDC * dc, MaxIcon * icon, int x, int y) {
	dc->GetDC()->DrawIcon(icon->Icon(), x, y);
}

void bmx_wxdc_drawlabel(MaxDC * dc, BBString * text, int x, int y, int w, int h, MaxBitmap * image, int alignment, int indexAccel) {
	if (image) {
		dc->GetDC()->DrawLabel(wxStringFromBBString(text), image->Bitmap(), wxRect(x, y, w, h), alignment, indexAccel);
	} else {
		dc->GetDC()->DrawLabel(wxStringFromBBString(text), wxRect(x, y, w, h), alignment, indexAccel);
	}
}

void bmx_wxdc_drawlabelrect(MaxDC * dc, BBString * text, MaxRect * rect, MaxBitmap * image, int alignment, int indexAccel) {
	if (image) {
		dc->GetDC()->DrawLabel(wxStringFromBBString(text), image->Bitmap(), rect->Rect(), alignment, indexAccel);
	} else {
		dc->GetDC()->DrawLabel(wxStringFromBBString(text), rect->Rect(), alignment, indexAccel);
	}
}


void bmx_wxdc_drawlines(MaxDC * dc, BBArray * p, int xOffset, int yOffset) {
	int n= p->scales[0] / 2;
	int *s=(int*)BBARRAYDATA( p,p->dims );
	wxPoint * points = new wxPoint[n];
	for (int i = 0; i < n; i++) {
		points[i].x = s[i * 2];
		points[i].y = s[i * 2 + 1];
	}
	dc->GetDC()->DrawLines(n, points, xOffset, yOffset);
	delete [] points;
}

void bmx_wxdc_drawpolygon(MaxDC * dc, BBArray * p, int xOffset, int yOffset, wxPolygonFillMode fillStyle) {
	int n= p->scales[0] / 2;
	int *s=(int*)BBARRAYDATA( p,p->dims );
	wxPoint * points = new wxPoint[n];
	for (int i = 0; i < n; i++) {
		points[i].x = s[i * 2];
		points[i].y = s[i * 2 + 1];
	}
	dc->GetDC()->DrawPolygon(n, points, xOffset, yOffset, fillStyle);
	delete [] points;
}

void bmx_wxdc_drawpoint(MaxDC * dc, int x, int y) {
	dc->GetDC()->DrawPoint(x, y);
}

void bmx_wxdc_drawrotatedtext(MaxDC * dc, BBString * text, int x, int y, double angle) {
	dc->GetDC()->DrawRotatedText(wxStringFromBBString(text), x, y, angle);
}

void bmx_wxdc_drawspline(MaxDC * dc, BBArray * p) {
	int n= p->scales[0] / 2;
	int *s=(int*)BBARRAYDATA( p,p->dims );
	wxPoint * points = new wxPoint[n];
	for (int i = 0; i < n; i++) {
		points[i].x = s[i * 2];
		points[i].y = s[i * 2 + 1];
	}
	dc->GetDC()->DrawSpline(n, points);
	delete [] points;
}

void bmx_wxdc_enddoc(MaxDC * dc) {
	dc->GetDC()->EndDoc();
}

void bmx_wxdc_endpage(MaxDC * dc) {
	dc->GetDC()->EndPage();
}

int bmx_wxdc_floodfill(MaxDC * dc, int x, int y, MaxColour * colour, wxFloodFillStyle style) {
	return static_cast<int>(dc->GetDC()->FloodFill(wxPoint(x, y), colour->Colour(), style));
}

MaxBrush * bmx_wxdc_getbackground(MaxDC * dc) {
	wxBrush c(dc->GetDC()->GetBackground());
	return new MaxBrush(c);
}

int bmx_wxdc_getbackgroundmode(MaxDC * dc) {
	return dc->GetDC()->GetBackgroundMode();
}

MaxBrush * bmx_wxdc_getbrush(MaxDC * dc) {
	wxBrush b(dc->GetDC()->GetBrush());
	return new MaxBrush(b);
}

int bmx_wxdc_getcharwidth(MaxDC * dc) {
	return dc->GetDC()->GetCharWidth();
}

void bmx_wxdc_getclippingbox(MaxDC * dc, int * x, int * y, int * w, int * h) {
	dc->GetDC()->GetClippingBox(x, y, w, h);
}

MaxFont * bmx_wxdc_getfont(MaxDC * dc) {
	wxFont f(dc->GetDC()->GetFont());
	return new MaxFont(f);
}

MaxFontMetrics * bmx_wxdc_getfontmetrics(MaxDC * dc) {
	wxFontMetrics f(dc->GetDC()->GetFontMetrics());
	return new MaxFontMetrics(f);
}

int bmx_wxdc_getlayoutdirection(MaxDC * dc) {
	return dc->GetDC()->GetLayoutDirection();
}

int bmx_wxdc_getlogicalfunction(MaxDC * dc) {
	return dc->GetDC()->GetLogicalFunction();
}

wxMappingMode bmx_wxdc_getmapmode(MaxDC * dc) {
	return dc->GetDC()->GetMapMode();
}

void bmx_wxdc_getmultilinetextextent(MaxDC * dc, BBString * text, int * width, int * height, int * heightline) {
	dc->GetDC()->GetMultiLineTextExtent(wxStringFromBBString(text), width, height, heightline);
}

BBArray * bmx_wxdc_getpartialtextextents(MaxDC * dc, BBString * text) {
	wxArrayInt widths;
	dc->GetDC()->GetPartialTextExtents(wxStringFromBBString(text), widths);
	return wxArrayIntToBBIntArray(widths);
}

MaxPen * bmx_wxdc_getpen(MaxDC * dc) {
	wxPen p(dc->GetDC()->GetPen());
	return new MaxPen(p);
}

MaxColour * bmx_wxdc_getpixel(MaxDC * dc, int x, int y) {
	wxColour c;
	dc->GetDC()->GetPixel(x, y, &c);
	return new MaxColour(c);
}

void bmx_wxdc_getppi(MaxDC * dc, int * w, int * h) {
	wxSize s = dc->GetDC()->GetPPI();
	*w = s.x;
	*h = s.y;	
}

void bmx_wxdc_getsize(MaxDC * dc, int * w, int * h) {
	wxSize s = dc->GetDC()->GetSize();
	*w = s.x;
	*h = s.y;
}

void bmx_wxdc_getsizemm(MaxDC * dc, int * w, int * h) {
	wxSize s = dc->GetDC()->GetSizeMM();
	*w = s.x;
	*h = s.y;
}

MaxColour * bmx_wxdc_gettextbackground(MaxDC * dc) {
	wxColour c(dc->GetDC()->GetTextBackground());
	return new MaxColour(c);
}

MaxColour * bmx_wxdc_gettextforeground(MaxDC * dc) {
	wxColour c(dc->GetDC()->GetTextForeground());
	return new MaxColour(c);
}

void bmx_wxdc_getuserscale(MaxDC * dc, double * x, double * y) {
	dc->GetDC()->GetUserScale(x, y);
}

void bmx_wxdc_gradientfillconcentric(MaxDC * dc, int x, int y, int w, int h, MaxColour * initialColour, MaxColour * destColour) {
	dc->GetDC()->GradientFillConcentric(wxRect(x, y, w, h), initialColour->Colour(), destColour->Colour());
}

void bmx_wxdc_gradientfillconcentriccentre(MaxDC * dc, int x, int y, int w, int h, MaxColour * initialColour, MaxColour * destColour, int centreX, int centreY) {
	dc->GetDC()->GradientFillConcentric(wxRect(x, y, w, h), initialColour->Colour(), destColour->Colour(), wxPoint(centreX, centreY));
}

void bmx_wxdc_gradientfilllinear(MaxDC * dc, int x, int y, int w, int h, MaxColour * initialColour, MaxColour * destColour, wxDirection direction) {
	dc->GetDC()->GradientFillLinear(wxRect(x, y, w, h), initialColour->Colour(), destColour->Colour(), direction);
}

void bmx_wxdc_gradientfillconcentricrect(MaxDC * dc, MaxRect * rect, MaxColour * initialColour, MaxColour * destColour) {
	dc->GetDC()->GradientFillConcentric(rect->Rect(), initialColour->Colour(), destColour->Colour());
}

void bmx_wxdc_gradientfillconcentriccentrerect(MaxDC * dc, MaxRect * rect, MaxColour * initialColour, MaxColour * destColour, int centreX, int centreY) {
	dc->GetDC()->GradientFillConcentric(rect->Rect(), initialColour->Colour(), destColour->Colour(), wxPoint(centreX, centreY));
}

void bmx_wxdc_gradientfilllinearrect(MaxDC * dc, MaxRect * rect, MaxColour * initialColour, MaxColour * destColour, wxDirection direction) {
	dc->GetDC()->GradientFillLinear(rect->Rect(), initialColour->Colour(), destColour->Colour(), direction);
}

int bmx_wxdc_logicaltodevicex(MaxDC * dc, int x) {
	return dc->GetDC()->LogicalToDeviceX(x);
}

int bmx_wxdc_logicaltodevicexrel(MaxDC * dc, int x) {
	return dc->GetDC()->LogicalToDeviceXRel(x);
}

int bmx_wxdc_logicaltodevicey(MaxDC * dc, int y) {
	return dc->GetDC()->LogicalToDeviceY(y);
}

int bmx_wxdc_logicaltodeviceyrel(MaxDC * dc, int y) {
	return dc->GetDC()->LogicalToDeviceYRel(y);
}

int bmx_wxdc_maxx(MaxDC * dc) {
	return dc->GetDC()->MaxX();
}

int bmx_wxdc_maxy(MaxDC * dc) {
	return dc->GetDC()->MaxY();
}

int bmx_wxdc_minx(MaxDC * dc) {
	return dc->GetDC()->MinX();
}

int bmx_wxdc_miny(MaxDC * dc) {
	return dc->GetDC()->MinY();
}

int bmx_wxdc_isok(MaxDC * dc) {
	return static_cast<int>(dc->GetDC()->IsOk());
}

void bmx_wxdc_resetboundingbox(MaxDC * dc) {
	dc->GetDC()->ResetBoundingBox();
}

void bmx_wxdc_setaxisorientation(MaxDC * dc, int leftRight, int topBottom) {
	dc->GetDC()->SetAxisOrientation(static_cast<bool>(leftRight), static_cast<bool>(topBottom));
}

void bmx_wxdc_setlayoutdirection(MaxDC * dc, wxLayoutDirection dir) {
	dc->GetDC()->SetLayoutDirection(dir);
}

void bmx_wxdc_setlogicalfunction(MaxDC * dc, wxRasterOperationMode func) {
	dc->GetDC()->SetLogicalFunction(func);
}

void bmx_wxdc_setpalette(MaxDC * dc, MaxPalette * palette) {
	dc->GetDC()->SetPalette(palette->Palette());
}

void bmx_wxdc_startdoc(MaxDC * dc, BBString * message) {
	dc->GetDC()->StartDoc(wxStringFromBBString(message));
}

void bmx_wxdc_startpage(MaxDC * dc) {
	dc->GetDC()->StartPage();
}

void bmx_wxdc_delete(MaxDC * dc) {
	delete dc;
}

void bmx_wxdc_free(MaxDC * dc) {
	delete dc;
}

int wx_wxdc_blit(MaxDC * dc, int xdest, int ydest, int width, int height, MaxDC * source, int xsrc, int ysrc, int logicalFunc,
		int useMask, int xsrcMask, int ysrcMask) {
	return static_cast<int>(dc->GetDC()->Blit(xdest, ydest, width, height, source->GetDC(), xsrc, ysrc, static_cast<wxRasterOperationMode>(logicalFunc), useMask, xsrcMask, ysrcMask));
}

int wx_wxdc_stretchblit(MaxDC * dc, int xdest, int ydest, int dstWidth, int dstHeight, MaxDC * source, int xsrc, int ysrc, int srcWidth, int srcHeight,
		int logicalFunc, int useMask, int xsrcMask, int ysrcMask) {
#ifndef __WXGTK__
	return static_cast<int>(dc->GetDC()->StretchBlit(xdest, ydest, dstWidth, dstHeight, source->GetDC(), xsrc, ysrc, srcWidth, srcHeight,
		static_cast<wxRasterOperationMode>(logicalFunc), useMask, xsrcMask, ysrcMask));
#else
	return 0;
#endif
}

void * bmx_wxdc_gethandle(MaxDC * dc) {
	return dc->GetDC()->GetHandle();
}

// *********************************************

MaxClientDC * bmx_wxclientdc_create(wxWindow * window) {
	return new MaxClientDC(window);
}

void bmx_wxclientdc_delete(MaxClientDC * dc) {
	delete dc;
}

// *********************************************
