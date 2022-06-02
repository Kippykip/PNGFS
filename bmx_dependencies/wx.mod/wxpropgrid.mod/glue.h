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
#include "wx/propgrid/propgrid.h"
#include "wx/propgrid/advprops.h"
#include "../wxdatetime.mod/glue.h"
#include "../wxbitmap.mod/glue.h"
#include "wx/xml/xml.h"


class MaxPropertyGrid;
class MaxPGPropArg;
class MaxColourPropertyValue;
class MaxPGChoices;
class MaxPGChoiceEntry;
class MaxIntProperty;
class MaxUIntProperty;
class MaxFloatProperty;
class MaxBoolProperty;
class MaxFlagsProperty;
class MaxFileProperty;
class MaxLongStringProperty;
class MaxDirProperty;
class MaxArrayStringProperty;
class MaxCursorProperty;
class MaxImageFileProperty;
class MaxDateProperty;
class MaxMultiChoiceProperty;
class MaxColourProperty;

extern "C" {

#include <blitz.h>

	BBArray * CB_PREF(wx_wxpropgrid_wxPropertyGrid__newPropertiesArray)(int size);
	void CB_PREF(wx_wxpropgrid_wxPropertyGrid__addProperty)(BBArray * props, int i, wxPGProperty * prop);
	wxPGProperty * CB_PREF(wx_wxpropgrid_wxPropertyGrid__getProperty)(BBArray * props, int i);
	BBObject * CB_PREF(wx_wxpropgrid_wxPropertyGrid__xrcNew)(wxPropertyGrid * grid);

	wxPropertyGrid * bmx_wxpropertygrid_create(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, int style);
	wxPGProperty * bmx_wxpropertycontainermethods_append(wxPropertyGridInterface * prop, wxPGProperty * property);
	wxPropertyGrid * bmx_wxpropertygrid_getgrid(wxPropertyGrid * grid);
	wxPGProperty * bmx_wxpropertygrid_append(wxPropertyGrid * prop, wxPGProperty * property);
	wxPGProperty * bmx_wxpropertygrid_appendin(wxPropertyGrid * prop, wxPGProperty * parent, wxPGProperty * newproperty);
	MaxColour * bmx_wxpropertygrid_getcaptionbackgroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcaptionforegroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcellbackgroundcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcelldisabledtextcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getcelltextcolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getlinecolour(wxPropertyGrid * grid);
	MaxColour * bmx_wxpropertygrid_getmargincolour(wxPropertyGrid * grid);
	
	wxPGProperty * bmx_wxstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	
	wxPGProperty * bmx_wxpropertycategory_create(BBObject * handle, BBString * label, BBString * name);

	wxPGProperty * bmx_wxfontproperty_create(BBObject * handle, BBString * label, BBString * name, MaxFont * font);

	void bmx_wxpropertygrid_setpropertyhelpstring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * helpString);
	void bmx_wxpropertygrid_setpropertyhelpstringbyname(wxPropertyGrid * grid, BBString * name, BBString * helpString);

	wxSystemColourProperty * bmx_wxsystemcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * value);
	MaxColour * bmx_wxsystemcolourproperty_getcolour(wxSystemColourProperty * prop, int index);

	void bmx_wxcolourpropertyvalue_delete(MaxColourPropertyValue * value);
	
	void bmx_wxpgproparg_delete(MaxPGPropArg * id);

	int bmx_wxpropertygriditeratorbase_atend(wxPropertyGridIteratorBase * iter);
	wxPGProperty * bmx_wxpropertygriditeratorbase_getproperty(wxPropertyGridIteratorBase * iter);
	void bmx_wxpropertygriditeratorbase_nextproperty(wxPropertyGridIteratorBase * iter, int iterateChildren);
	void bmx_wxpropertygriditeratorbase_prevproperty(wxPropertyGridIteratorBase * iter);
	void bmx_wxpropertygriditeratorbase_setbaseparent(wxPropertyGridIteratorBase * iter, wxPGProperty * baseParent);

	wxIntProperty * bmx_wxintproperty_create(BBObject * handle, BBString * label, BBString * name, int value);
	wxUIntProperty * bmx_wxuintproperty_create(BBObject * handle, BBString * label, BBString * name, int value);
	wxFloatProperty * bmx_wxdoubleproperty_create(BBObject * handle, BBString * label, BBString * name, double value);
	wxBoolProperty * bmx_wxboolproperty_create(BBObject * handle, BBString * label, BBString * name, int value);
	wxFlagsProperty * bmx_wxflagsproperty_create(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * values, int value);
	wxFileProperty * bmx_wxfileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxLongStringProperty * bmx_wxlongstringproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxDirProperty * bmx_wxdirproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxArrayStringProperty * bmx_wxarraystringproperty_create(BBObject * handle, BBString * label, BBString * name, BBArray * value);
	wxCursorProperty * bmx_wxcursorproperty_create(BBObject * handle, BBString * label, BBString * name, int value);
	wxImageFileProperty * bmx_wximagefileproperty_create(BBObject * handle, BBString * label, BBString * name, BBString * value);
	wxDateProperty * bmx_wxdateproperty_create(BBObject * handle, BBString * label, BBString * name, MaxDateTime * value);
	wxColourProperty * bmx_wxcolourproperty_create(BBObject * handle, BBString * label, BBString * name, MaxColour * colour);
	wxFloatProperty * bmx_wxfloatproperty_create(BBObject * handle, BBString * label, BBString * name, double value);

	MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolour(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxColour * bmx_wxpropertygrid_getpropertytextcolour(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxColour * bmx_wxpropertygrid_getpropertybackgroundcolourbyname(wxPropertyGrid * grid, BBString * name);
	MaxColour * bmx_wxpropertygrid_getpropertytextcolourbyname(wxPropertyGrid * grid, BBString * name);

	void bmx_wxpropertygrid_beginaddchildren(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_beginaddchildrenbyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_clearselection(wxPropertyGrid * grid, int validation);
	int bmx_wxpropertygrid_collapse(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_collapsebyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_deleteproperty(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_deletepropertybyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_disableproperty(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_disablepropertybyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_enableproperty(wxPropertyGrid * grid, wxPGProperty * prop, int enable);
	int bmx_wxpropertygrid_enablepropertybyname(wxPropertyGrid * grid, BBString * name, int enable);
	void bmx_wxpropertygrid_endaddchildren(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_endaddchildrenbyname(wxPropertyGrid * grid, BBString * name);


	void bmx_wxpropertygrid_setpropertyattribute(wxPropertyGrid * grid, wxPGProperty * prop, BBString * attrName, int value, int argFlags);
	void bmx_wxpropertygrid_setpropertyattributebyname(wxPropertyGrid * grid, BBString * name, BBString * attrName, int value, int argFlags);
	void bmx_wxpropertygrid_setpropertyattributestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * attrName, BBString * value, int argFlags);
	void bmx_wxpropertygrid_setpropertyattributestringbyname(wxPropertyGrid * grid, BBString * name, BBString * attrName, BBString * value, int argFlags);

	int bmx_wxpropertygrid_expand(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_expandbyname(wxPropertyGrid * grid, BBString * name);
	wxPGProperty * bmx_wxpropertygrid_getfirst(wxPropertyGrid * grid, int flags);
	MaxPGChoices * bmx_wxpropertygrid_getpropertychoices(wxPropertyGrid * grid, wxPGProperty * prop);
	BBObject * bmx_wxpropertygrid_getpropertyclientdata(wxPropertyGrid * grid, wxPGProperty * prop);
	const wxPGEditor * bmx_wxpropertygrid_getpropertyeditor(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyhelpstring(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxBitmap * bmx_wxpropertygrid_getpropertyimage(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertylabel(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyname(wxPropertyGrid * grid, wxPGProperty * prop);
	wxPGProperty * bmx_wxpropertygrid_getpropertyparent(wxPropertyGrid * grid, wxPGProperty * prop);

	void bmx_wxpropertygrid_addpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int value);
	void bmx_wxpropertygrid_addpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int value);
	int bmx_wxpropertygrid_setpropertymaxlength(wxPropertyGrid * grid, wxPGProperty * prop, int maxLen);
	int bmx_wxpropertygrid_setpropertymaxlengthbyname(wxPropertyGrid * grid, BBString * name, int maxLen);
	int bmx_wxpropertygrid_expandall(wxPropertyGrid * grid, int expand);
	int bmx_wxpropertygrid_collapseall(wxPropertyGrid * grid);

	wxPGProperty * bmx_wxpropertygrid_getpropertyptr(wxPropertyGrid * grid, wxPGProperty * prop);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayint(wxPropertyGrid * grid, wxPGProperty * prop);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarrayintbyname(wxPropertyGrid * grid, BBString * name);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystring(wxPropertyGrid * grid, wxPGProperty * prop);
	BBArray * bmx_wxpropertygrid_getpropertyvalueasarraystringbyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_getpropertyvalueasbool(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_getpropertyvalueasboolbyname(wxPropertyGrid * grid, BBString * name);
	MaxDateTime * bmx_wxpropertygrid_getpropertyvalueasdatetime(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxDateTime * bmx_wxpropertygrid_getpropertyvalueasdatetimebyname(wxPropertyGrid * grid, BBString * name);
	double bmx_wxpropertygrid_getpropertyvalueasdouble(wxPropertyGrid * grid, wxPGProperty * prop);
	double bmx_wxpropertygrid_getpropertyvalueasdoublebyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_getpropertyvalueasint(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_getpropertyvalueasintbyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_getpropertyvalueaslong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 * value);
	void bmx_wxpropertygrid_getpropertyvalueaslongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 * value);
	void bmx_wxpropertygrid_getpropertyvalueaspoint(wxPropertyGrid * grid, wxPGProperty * prop, int * x, int * y);
	void bmx_wxpropertygrid_getpropertyvalueaspointbyname(wxPropertyGrid * grid, BBString * name, int * x, int * y);
	void bmx_wxpropertygrid_getpropertyvalueassize(wxPropertyGrid * grid, wxPGProperty * prop, int * w, int * h);
	void bmx_wxpropertygrid_getpropertyvalueassizebyname(wxPropertyGrid * grid, BBString * name, int * w, int * h);
	BBString * bmx_wxpropertygrid_getpropertyvalueasstring(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyvalueasstringbyname(wxPropertyGrid * grid, BBString * name);
	BBString * bmx_wxpropertygrid_getpropertyvaluetype(wxPropertyGrid * grid, wxPGProperty * prop);
	BBString * bmx_wxpropertygrid_getpropertyvaluetypebyname(wxPropertyGrid * grid, BBString * name);
	wxPGProperty * bmx_wxpropertygrid_getselection(wxPropertyGrid * grid);
	int bmx_wxpropertygrid_ispropertcategory(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_ispropertyenabled(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_ispropertyexpanded(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_ispropertymodified(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_ispropertyshown(wxPropertyGrid * grid, wxPGProperty * prop);


	MaxPGChoices * bmx_wxpgchoices_create();
	void bmx_wxpgchoices_delete(MaxPGChoices * choices);
	MaxPGChoiceEntry * bmx_wxpgchoices_add(MaxPGChoices * choices, BBString * label, int value);
	void bmx_wxpgchoices_addentries(MaxPGChoices * choices, BBArray * labels, BBArray * values);
	MaxPGChoiceEntry * bmx_wxpgchoices_addassorted(MaxPGChoices * choices, BBString * label, int value);
	int bmx_wxpgchoices_getcount(MaxPGChoices * choices);
	BBString * bmx_wxpgchoices_getlabel(MaxPGChoices * choices, int index);
	BBArray * bmx_wxpgchoices_getlabels(MaxPGChoices * choices);
	int bmx_wxpgchoices_getvalue(MaxPGChoices * choices, int index);
	int bmx_wxpgchoices_index(MaxPGChoices * choices, int value);
	int bmx_wxpgchoices_indexforlabel(MaxPGChoices * choices, BBString * label);
	MaxPGChoiceEntry * bmx_wxpgchoices_insert(MaxPGChoices * choices, BBString * label, int index, int value);
	int bmx_wxpgchoices_isok(MaxPGChoices * choices);
	MaxPGChoiceEntry * bmx_wxpgchoices_item(MaxPGChoices * choices, int index);
	void bmx_wxpgchoices_removeat(MaxPGChoices * choices, int index, int count);
	void bmx_wxpgchoices_set(MaxPGChoices * choices, BBArray * labels, BBArray * values);
	void bmx_wxpgchoices_clear(MaxPGChoices * choices);


	MaxColour * bmx_wxpgchoiceentry_getbgcol(MaxPGChoiceEntry * entry);
	MaxBitmap * bmx_wxpgchoiceentry_getbitmap(MaxPGChoiceEntry * entry);
	MaxColour * bmx_wxpgchoiceentry_getfgcol(MaxPGChoiceEntry * entry);
	BBString * bmx_wxpgchoiceentry_gettext(MaxPGChoiceEntry * entry);
	void bmx_wxpgchoiceentry_setbgcol(MaxPGChoiceEntry * entry, MaxColour * col);
	void bmx_wxpgchoiceentry_setbitmap(MaxPGChoiceEntry * entry, MaxBitmap * bitmap);
	void bmx_wxpgchoiceentry_setfgcol(MaxPGChoiceEntry * entry, MaxColour * col);
	void bmx_wxpgchoiceentry_settext(MaxPGChoiceEntry * entry, BBString * text);
	void bmx_wxpgchoiceentry_delete(MaxPGChoiceEntry * entry);

	int bmx_wxpgchoiceentry_getvalue(MaxPGChoiceEntry * entry);
	void bmx_wxpgchoiceentry_setvalue(MaxPGChoiceEntry * entry, int value);

	void bmx_wxpgproperty_setattributestring(wxPGProperty * prop, BBString * name, BBString * value);
	void bmx_wxpgproperty_setattributeint(wxPGProperty * prop, BBString * name, int value);
	void bmx_wxpgproperty_setattributedouble(wxPGProperty * prop, BBString * name, double value);
	void bmx_wxpgproperty_setattributebool(wxPGProperty * prop, BBString * name, int value);

	void bmx_wxpgproperty_addchild(wxPGProperty * prop, wxPGProperty * child);
	int bmx_wxpgproperty_addchoice(wxPGProperty * prop, BBString * label, int value);
	void bmx_wxpgproperty_deletechoice(wxPGProperty * prop, int index);
	void bmx_wxpgproperty_deletechildren(wxPGProperty * prop);
	//bool bmx_wxpgproperty_ensuredataext(wxPGProperty * prop);
	BBString * bmx_wxpgproperty_getbasename(wxPGProperty * prop);
	unsigned int bmx_wxpgproperty_getchildcount(wxPGProperty * prop);
	int bmx_wxpgproperty_getchildrenheight(wxPGProperty * prop, int lh, int iMax);
	int bmx_wxpgproperty_getcommonvalue(wxPGProperty * prop);
	unsigned int bmx_wxpgproperty_getdepth(wxPGProperty * prop);
	int bmx_wxpgproperty_getdisplayedcommonvaluecount(wxPGProperty * prop);
	MaxColour * bmx_wxpgproperty_getvalueascolour(wxPGProperty * prop);
	BBString * bmx_wxpgproperty_getvalueasstring(wxPGProperty * prop, int argFlags);
	int bmx_wxpgproperty_gety(wxPGProperty * prop);
	int bmx_wxpgproperty_hasflag(wxPGProperty * prop, int flag);
	int bmx_wxpgproperty_hide(wxPGProperty * prop, int hide);
	int bmx_wxpgproperty_iscategory(wxPGProperty * prop);
	int bmx_wxpgproperty_isenabled(wxPGProperty * prop);
	int bmx_wxpgproperty_isexpanded(wxPGProperty * prop);
	int bmx_wxpgproperty_isroot(wxPGProperty * prop);
	int bmx_wxpgproperty_issubproperty(wxPGProperty * prop);
	int bmx_wxpgproperty_isvalueunspecified(wxPGProperty * prop);
	int bmx_wxpgproperty_isvisible(wxPGProperty * prop);
	wxPGProperty * bmx_wxpgproperty_item(wxPGProperty * prop, int i);
	wxPGProperty * bmx_wxpgproperty_last(wxPGProperty * prop);
	int bmx_wxpgproperty_recreateeditor(wxPGProperty * prop);
	void bmx_wxpgproperty_refreshchildren(wxPGProperty * prop);
	void bmx_wxpgproperty_refresheditor(wxPGProperty * prop);
	void bmx_wxpgproperty_setexpanded(wxPGProperty * prop, int expanded);
	void bmx_wxpgproperty_changeflag(wxPGProperty * prop, int flag, int set);
	void bmx_wxpgproperty_setflagsfromstring(wxPGProperty * prop, BBString * s);
	void bmx_wxpgproperty_sethelpstring(wxPGProperty * prop, BBString * helpString);
	void bmx_wxpgproperty_setlabel(wxPGProperty * prop, BBString * label);
	int bmx_wxpgproperty_setmaxlength(wxPGProperty * prop, int maxLen);
	int bmx_wxpgproperty_getattributeasint(wxPGProperty * prop, BBString * name, int defVal);
	BBString * bmx_wxpgproperty_getattributeasstring(wxPGProperty * prop, BBString * name, BBString * defVal);
	double bmx_wxpgproperty_getattributeasdouble(wxPGProperty * prop, BBString * name);
	void bmx_wxpgproperty_getattributeaslong(wxPGProperty * prop, BBString * name, BBInt64 * value);
	
	BBString * bmx_wxpgproperty_getdisplayedstring(wxPGProperty * prop);
	int bmx_wxpgproperty_getflags(wxPGProperty * prop);
	BBString * bmx_wxpgproperty_getflagsasstring(wxPGProperty * prop, int flagsMask);
	wxPropertyGrid * bmx_wxpgproperty_getgrid(wxPGProperty * prop);
	BBString * bmx_wxpgproperty_gethelpstring(wxPGProperty * prop);
	void bmx_wxpgproperty_getimagesize(wxPGProperty * prop, int * w, int * h);
	unsigned int bmx_wxpgproperty_getindexinparent(wxPGProperty * prop);
	wxPGProperty * bmx_wxpgproperty_getitematy(wxPGProperty * prop, unsigned int y, unsigned int lh, unsigned int *nextItemY);
	BBString * bmx_wxpgproperty_getlabel(wxPGProperty * prop);
	const wxPGProperty * bmx_wxpgproperty_getlastvisiblesubitem(wxPGProperty * prop);
	wxPGProperty * bmx_wxpgproperty_getmainparent(wxPGProperty * prop);
	int bmx_wxpgproperty_getmaxlength(wxPGProperty * prop);
	BBString * bmx_wxpgproperty_getname(wxPGProperty * prop);
	wxPGProperty * bmx_wxpgproperty_getparent(wxPGProperty * prop);
	wxPGProperty * bmx_wxpgproperty_getpropertybyname(wxPGProperty * prop, BBString * name);
	BBString * bmx_wxpgproperty_getvaluetype(wxPGProperty * prop);
	void bmx_wxpgproperty_setvalueulong(wxPGProperty * prop, BBInt64 value);
	void bmx_wxpgproperty_setvaluelong(wxPGProperty * prop, BBInt64 value);
	void bmx_wxpgproperty_setvaluesize(wxPGProperty * prop, int w, int h);
	void bmx_wxpgproperty_setvaluepoint(wxPGProperty * prop, int x, int y);
	void bmx_wxpgproperty_setvaluebyteptr(wxPGProperty * prop, void * value);
	void bmx_wxpgproperty_setvaluestring(wxPGProperty * prop, BBString * value);
	void bmx_wxpgproperty_setvaluestringarray(wxPGProperty * prop, BBArray * value);
	void bmx_wxpgproperty_setvalueintarray(wxPGProperty * prop, BBArray * value);
	void bmx_wxpgproperty_setvaluebool(wxPGProperty * prop, int value);
	void bmx_wxpgproperty_setvaluedouble(wxPGProperty * prop, double value);
	void bmx_wxpgproperty_setvalueint(wxPGProperty * prop, int value);
	BBArray * bmx_wxpgproperty_getvalueasarrayint(wxPGProperty * prop);
	BBArray * bmx_wxpgproperty_getvalueasarraystring(wxPGProperty * prop);
	double bmx_wxpgproperty_getvalueasdouble(wxPGProperty * prop);
	int bmx_wxpgproperty_getvalueasbool(wxPGProperty * prop);
	int bmx_wxpgproperty_getvalueasint(wxPGProperty * prop);
	void bmx_wxpgproperty_getvalueaslong(wxPGProperty * prop, BBInt64 * value);
	void bmx_wxpgproperty_getvalueaspoint(wxPGProperty * prop, int * x, int * y);
	void bmx_wxpgproperty_getvalueassize(wxPGProperty * prop, int * w, int * h);
	void bmx_wxpgproperty_setvaluecolour(wxPGProperty * prop, MaxColour * value);
	unsigned int bmx_wxpgproperty_getchoicecount(wxPGProperty * prop);
	void bmx_wxpgproperty_setchoiceselection(wxPGProperty * prop, int newValue);
	void bmx_wxpgproperty_setwasmodified(wxPGProperty * prop, int set);
	void bmx_wxpgproperty_setvalueimage(wxPGProperty * prop, MaxBitmap * bmp);
	void bmx_wxpgproperty_setvaluetounspecified(wxPGProperty * prop);
	int bmx_wxpgproperty_usesautounspecified(wxPGProperty * prop);

	int bmx_wxdateproperty_getdatepickerstyle(wxDateProperty * prop);
	MaxDateTime * bmx_wxdateproperty_getdatevalue(wxDateProperty * prop);
	BBString * bmx_wxdateproperty_getformat(wxDateProperty * prop);
	void bmx_wxdateproperty_setdatevalue(wxDateProperty * prop, MaxDateTime * dt);
	void bmx_wxdateproperty_setformat(wxDateProperty * prop, BBString * format);


	wxEnumProperty * bmx_wxenumproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * values, int value);
	wxEnumProperty * bmx_wxenumproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, int value);
	int bmx_wxenumproperty_getindexforvalue(wxEnumProperty * prop, int value);
	int bmx_wxenumproperty_getitemcount(wxEnumProperty * prop);
	int bmx_wxenumproperty_getchoiceselection(wxEnumProperty * prop);

	wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwitharrays(BBObject * handle, BBString * label, BBString * name, BBArray * labels, BBArray * value);
	wxMultiChoiceProperty * bmx_wxmultichoiceproperty_createwithchoices(BBObject * handle, BBString * label, BBString * name, MaxPGChoices * choices, BBArray * value);
	BBArray * bmx_wxmultichoiceproperty_getvalueasarrayint(wxMultiChoiceProperty * prop);
	void bmx_wxmultichoiceproperty_setvalueintarray(MaxMultiChoiceProperty * prop, BBArray * value);

	int bmx_wxpropertygrid_geteventtype(int type);

	wxPGProperty * bmx_wxpropertygridevent_getmainparent(wxPropertyGridEvent & event);
	wxPGProperty * bmx_wxpropertygridevent_getproperty(wxPropertyGridEvent & event);
	int bmx_wxpropertygridevent_canveto(wxPropertyGridEvent & event);
	void bmx_wxpropertygridevent_veto(wxPropertyGridEvent & event, int value);
	BBArray * bmx_wxpropertygridevent_getvalueasarrayint(wxPropertyGridEvent & event);
	BBArray * bmx_wxpropertygridevent_getvalueasarraystring(wxPropertyGridEvent & event);
	int bmx_wxpropertygridevent_getvalueasbool(wxPropertyGridEvent & event);
	double bmx_wxpropertygridevent_getvalueasdouble(wxPropertyGridEvent & event);
	int bmx_wxpropertygridevent_getvalueasint(wxPropertyGridEvent & event);
	void bmx_wxpropertygridevent_getvalueaspoint(wxPropertyGridEvent & event, int * x, int * y);
	void bmx_wxpropertygridevent_getvalueassize(wxPropertyGridEvent & event, int * w, int * h);
	BBString * bmx_wxpropertygridevent_getvalueasstring(wxPropertyGridEvent & event);

	wxPGProperty * bmx_wxpropertygrid_getpropertybysubname(wxPropertyGrid * grid, BBString * name, BBString * subName);
	wxPGProperty * bmx_wxpropertygrid_getpropertybyname(wxPropertyGrid * grid, BBString * name);
	wxPropertyCategory * bmx_wxpropertygrid_getpropertycategory(wxPropertyGrid * grid, wxPGProperty * prop);
	int bmx_wxpropertygrid_hideproperty(wxPropertyGrid * grid, wxPGProperty * prop, int hide);
	wxPGProperty * bmx_wxpropertygrid_insert(wxPropertyGrid * grid, wxPGProperty * parent, int index, wxPGProperty * newproperty);
	void bmx_wxpropertygrid_insertpropertychoice(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label, int index, int value);
	int bmx_wxpropertygrid_ispropertyunspecified(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_limitpropertyediting(wxPropertyGrid * grid, wxPGProperty * prop, int limit);
	wxPGProperty * bmx_wxpropertygrid_replaceproperty(wxPropertyGrid * grid, wxPGProperty * prop, wxPGProperty * property);
	void bmx_wxpropertygrid_setpropertycell(wxPropertyGrid * grid, wxPGProperty * prop, int column, BBString * text, MaxBitmap * bitmap, MaxColour * fgCol, MaxColour * bgCol);
	wxPropertyCategory * bmx_wxpropertygrid_getpropertycategorybyname(wxPropertyGrid * grid, BBString * name);
	MaxPGChoices * bmx_wxpropertygrid_getpropertychoicesbyname(wxPropertyGrid * grid, BBString * name);
	BBString * bmx_wxpropertygrid_getpropertyhelpstringbyname(wxPropertyGrid * grid, BBString * name);
	MaxBitmap * bmx_wxpropertygrid_getpropertyimagebyname(wxPropertyGrid * grid, BBString * name);
	BBString * bmx_wxpropertygrid_getpropertylabelbyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_insertpropertychoicebyname(wxPropertyGrid * grid, BBString * name, BBString * label, int index, int value);
	int bmx_wxpropertygrid_ispropertycategorybyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_ispropertyenabledbyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_ispropertyexpandedbyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_ispropertymodifiedbyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_ispropertyshownbyname(wxPropertyGrid * grid, BBString * name);
	int bmx_wxpropertygrid_ispropertyunspecifiedbyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_limitpropertyeditingbyname(wxPropertyGrid * grid, BBString * name, int limit);
	wxPGProperty * bmx_wxpropertygrid_replacepropertybyname(wxPropertyGrid * grid, BBString * name, wxPGProperty * property);
	void bmx_wxpropertygrid_setpropertycellbyname(wxPropertyGrid * grid, BBString * name, int column, BBString * text, MaxBitmap * bitmap, MaxColour * fgCol, MaxColour * bgCol);
	void bmx_wxpropertygrid_setpropertyimage(wxPropertyGrid * grid, wxPGProperty * prop, MaxBitmap * bmp);
	void bmx_wxpropertygrid_setpropertylabel(wxPropertyGrid * grid, wxPGProperty * prop, BBString * label);
	void bmx_wxpropertygrid_setpropertyreadonly(wxPropertyGrid * grid, wxPGProperty * prop, int set);
	void bmx_wxpropertygrid_setpropertyunspecified(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_setpropertyvalueintarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value);
	void bmx_wxpropertygrid_setpropertyvalueulong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value);
	void bmx_wxpropertygrid_setpropertyvaluelong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value);
	void bmx_wxpropertygrid_setpropertyvaluesize(wxPropertyGrid * grid, wxPGProperty * prop, int w, int h);
	void bmx_wxpropertygrid_setpropertyvaluepoint(wxPropertyGrid * grid, wxPGProperty * prop, int x, int y);
	void bmx_wxpropertygrid_setpropertyvaluebyteptr(wxPropertyGrid * grid, wxPGProperty * prop, void * value);
	void bmx_wxpropertygrid_setpropertyvaluestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * value);
	void bmx_wxpropertygrid_setpropertyvaluedatetime(wxPropertyGrid * grid, wxPGProperty * prop, MaxDateTime * time);
	void bmx_wxpropertygrid_setpropertyvaluestringarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value);
	void bmx_wxpropertygrid_setpropertyvaluebool(wxPropertyGrid * grid, wxPGProperty * prop, int value);
	void bmx_wxpropertygrid_setpropertyvaluedouble(wxPropertyGrid * grid, wxPGProperty * prop, double value);
	void bmx_wxpropertygrid_setpropertyvalueint(wxPropertyGrid * grid, wxPGProperty * prop, int value);

	void bmx_wxpropertygrid_setpropertyreadonlybyname(wxPropertyGrid * grid, BBString * name, int set);
	void bmx_wxpropertygrid_setpropertyunspecifiedbyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_setpropertyvalueintarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value);
	void bmx_wxpropertygrid_setpropertyvalueulongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value);
	void bmx_wxpropertygrid_setpropertyvaluelongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value);
	void bmx_wxpropertygrid_setpropertyvaluesizebyname(wxPropertyGrid * grid, BBString * name, int w, int h);
	void bmx_wxpropertygrid_setpropertyvaluepointbyname(wxPropertyGrid * grid, BBString * name, int x, int y);
	void bmx_wxpropertygrid_setpropertyvaluebyteptrbyname(wxPropertyGrid * grid, BBString * name, void * value);
	void bmx_wxpropertygrid_setpropertyvaluestringbyname(wxPropertyGrid * grid, BBString * name, BBString * value);
	void bmx_wxpropertygrid_setpropertyvaluedatetimebyname(wxPropertyGrid * grid, BBString * name, MaxDateTime * time);
	void bmx_wxpropertygrid_setpropertyvaluestringarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value);
	void bmx_wxpropertygrid_setpropertyvalueboolbyname(wxPropertyGrid * grid, BBString * name, int value);
	void bmx_wxpropertygrid_setpropertyvaluedoublebyname(wxPropertyGrid * grid, BBString * name, double value);
	void bmx_wxpropertygrid_setpropertyvalueintbyname(wxPropertyGrid * grid, BBString * name, int value);
	void bmx_wxpropertygrid_setpropertyimagebyname(wxPropertyGrid * grid, BBString * name, MaxBitmap * bmp);
	void bmx_wxpropertygrid_setpropertylabelbyname(wxPropertyGrid * grid, BBString * name, BBString * newproplabel);
	int bmx_wxpropertygrid_hidepropertybyname(wxPropertyGrid * grid, BBString * name, int hide);
	wxPGProperty * bmx_wxpropertygrid_insertbyname(wxPropertyGrid * grid, BBString * parent, int index, wxPGProperty * newproperty);
	int bmx_wxpropertygrid_changepropertyvalueintarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value);
	int bmx_wxpropertygrid_changepropertyvalueintarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value);
	int bmx_wxpropertygrid_changepropertyvalueulong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value);
	int bmx_wxpropertygrid_changepropertyvalueulongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value);
	int bmx_wxpropertygrid_changepropertyvaluelong(wxPropertyGrid * grid, wxPGProperty * prop, BBInt64 value);
	int bmx_wxpropertygrid_changepropertyvaluelongbyname(wxPropertyGrid * grid, BBString * name, BBInt64 value);
	int bmx_wxpropertygrid_changepropertyvaluesize(wxPropertyGrid * grid, wxPGProperty * prop, int w, int h);
	int bmx_wxpropertygrid_changepropertyvaluesizebyname(wxPropertyGrid * grid, BBString * name, int w, int h);
	int bmx_wxpropertygrid_changepropertyvaluepoint(wxPropertyGrid * grid, wxPGProperty * prop, int x, int y);
	int bmx_wxpropertygrid_changepropertyvaluepointbyname(wxPropertyGrid * grid, BBString * name, int x, int y);
	int bmx_wxpropertygrid_changepropertyvaluebyteptr(wxPropertyGrid * grid, wxPGProperty * prop, void * value);
	int bmx_wxpropertygrid_changepropertyvaluebyteptrbyname(wxPropertyGrid * grid, BBString * name, void * value);
	int bmx_wxpropertygrid_changepropertyvaluestring(wxPropertyGrid * grid, wxPGProperty * prop, BBString * value);
	int bmx_wxpropertygrid_changepropertyvaluestringbyname(wxPropertyGrid * grid, BBString * name, BBString * value);
	int bmx_wxpropertygrid_changepropertyvaluedatetime(wxPropertyGrid * grid, wxPGProperty * prop, MaxDateTime * time);
	int bmx_wxpropertygrid_changepropertyvaluedatetimebyname(wxPropertyGrid * grid, BBString * name, MaxDateTime * time);
	int bmx_wxpropertygrid_changepropertyvaluestringarray(wxPropertyGrid * grid, wxPGProperty * prop, BBArray * value);
	int bmx_wxpropertygrid_changepropertyvaluestringarraybyname(wxPropertyGrid * grid, BBString * name, BBArray * value);
	int bmx_wxpropertygrid_changepropertyvaluebool(wxPropertyGrid * grid, wxPGProperty * prop, int value);
	int bmx_wxpropertygrid_changepropertyvalueboolbyname(wxPropertyGrid * grid, BBString * name, int value);
	int bmx_wxpropertygrid_changepropertyvaluedouble(wxPropertyGrid * grid, wxPGProperty * prop, double value);
	int bmx_wxpropertygrid_changepropertyvaluedoublebyname(wxPropertyGrid * grid, BBString * name, double value);
	int bmx_wxpropertygrid_changepropertyvalueint(wxPropertyGrid * grid, wxPGProperty * prop, int value);
	int bmx_wxpropertygrid_changepropertyvalueintbyname(wxPropertyGrid * grid, BBString * name, int value);

	
	void bmx_wxpropertygrid_clear(wxPropertyGrid * grid);
	void bmx_wxpropertygrid_clearmodifiedstatus(wxPropertyGrid * grid);
	void bmx_wxpropertygrid_clearpropertymodifiedstatus(wxPropertyGrid * grid, wxPGProperty * prop);
	void bmx_wxpropertygrid_clearpropertymodifiedstatusbyname(wxPropertyGrid * grid, BBString * name);

	MaxColour * bmx_wxpropertygrid_getpropertyvalueascolour(wxPropertyGrid * grid, wxPGProperty * prop);
	MaxColour * bmx_wxpropertygrid_getpropertyvalueascolourbyname(wxPropertyGrid * grid, BBString * name);
	void bmx_wxpropertygrid_setpropertyvaluecolour(wxPropertyGrid * grid, wxPGProperty * prop, MaxColour * value);
	void bmx_wxpropertygrid_setpropertyvaluecolourbyname(wxPropertyGrid * grid, BBString * name, MaxColour * value);

	BBArray * bmx_wxpropertygrid_getpropertieswithflag(wxPropertyGrid * grid, int flags, int inverse, int iterFlags);
	BBArray * bmx_wxpropertygrid_propertiestonames(wxPropertyGrid * grid, BBArray * props);
	BBArray * bmx_wxpropertygrid_namestoproperties(wxPropertyGrid * grid, BBArray * names);

	void bmx_wxpropertygrid_centersplitter(wxPropertyGrid * grid, int enableAutoCentering);
	int bmx_wxpropertygrid_getsplitterposition(wxPropertyGrid * grid);
	void bmx_wxpropertygrid_setsplitterleft(wxPropertyGrid * grid, int subProps);
	void bmx_wxpropertygrid_setsplitterposition(wxPropertyGrid * grid, int xPos, int refresh);
	int bmx_wxpropertygrid_commitchangesfromeditor(wxPropertyGrid * grid, int flags);
	int bmx_wxpropertygrid_selectproperty(wxPropertyGrid * grid, wxPGProperty * prop, int focus);

	wxPGEditor * bmx_wxpgtextctrleditor_init(BBObject * obj);
	wxPGEditor * bmx_wxpgchoiceeditor_init(BBObject * obj);
	wxPGEditor * bmx_wxpgcomboboxeditor_init(BBObject * obj);
	wxPGEditor * bmx_wxpgcheckboxeditor_init(BBObject * obj);
	wxPGEditor * bmx_wxpgtextctrlandbuttoneditor_init(BBObject * obj);
	wxPGEditor * bmx_wxpgchoiceandbuttoneditor_init(BBObject * obj);

	void bmx_wxpropertygrid_addresourcehandler();

}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class MaxPGPropArg
{
public:
	MaxPGPropArg(wxPGPropArg p);
	wxPGPropArgCls & PGId();

private:
	wxPGPropArgCls pgId;

};

class MaxPropertyGrid : public wxPropertyGrid
{
public:
	MaxPropertyGrid(BBObject * handle, wxWindow * parent, wxWindowID id, int x, int y, int w, int h, long style);
	MaxPropertyGrid();
	~ MaxPropertyGrid();
	
	void MaxBind(BBObject * handle);
	
private:
    DECLARE_EVENT_TABLE();
};

class MaxColourPropertyValue
{
public:
	MaxColourPropertyValue(const wxColourPropertyValue & v);
	wxColourPropertyValue & Value();

private:
	wxColourPropertyValue value;

};

class MaxPGChoices
{
public:
	MaxPGChoices(const wxPGChoices & c);
	MaxPGChoices();
	wxPGChoices & Choices();

private:
	wxPGChoices choices;
};

class MaxPGChoiceEntry
{
public:
	MaxPGChoiceEntry(const wxPGChoiceEntry & e);
	wxPGChoiceEntry & Entry();

private:
	wxPGChoiceEntry entry;

};

class MaxPropertyCategory : public wxPropertyCategory
{
public:
	MaxPropertyCategory(BBObject * handle, const wxString &label, const wxString &name);
	~MaxPropertyCategory();
};

class MaxStringProperty : public wxStringProperty
{
public:
	MaxStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxStringProperty();
};

class MaxFontProperty : public wxFontProperty
{
public:
	MaxFontProperty(BBObject * handle, const wxString &label, const wxString &name, const wxFont &value);
	~MaxFontProperty();
};

class MaxSystemColourProperty : public wxSystemColourProperty
{
public:
	MaxSystemColourProperty(BBObject * handle, const wxString &label, const wxString &name, const wxColour &value);
	~MaxSystemColourProperty();
};

class MaxColourProperty : public wxColourProperty
{
public:
	MaxColourProperty(BBObject * handle, const wxString &label, const wxString &name, const wxColour &value);
	~MaxColourProperty();
};

class MaxIntProperty : public wxIntProperty
{
public:
	MaxIntProperty(BBObject * handle, const wxString &label, const wxString &name, long value);
	~MaxIntProperty();
};

class MaxUIntProperty : public wxUIntProperty
{
public:
	MaxUIntProperty(BBObject * handle, const wxString &label, const wxString &name, unsigned long value);
	~MaxUIntProperty();
};

class MaxFloatProperty : public wxFloatProperty
{
public:
	MaxFloatProperty(BBObject * handle, const wxString &label, const wxString &name, double value);
	~MaxFloatProperty();
};

class MaxBoolProperty : public wxBoolProperty
{
public:
	MaxBoolProperty(BBObject * handle, const wxString &label, const wxString &name, bool value);
	~MaxBoolProperty();
};

class MaxFlagsProperty : public wxFlagsProperty
{
public:
	MaxFlagsProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &values, int value);
	~MaxFlagsProperty();
};

class MaxFileProperty : public wxFileProperty
{
public:
	MaxFileProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxFileProperty();
};

class MaxLongStringProperty : public wxLongStringProperty
{
public:
	MaxLongStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxLongStringProperty();
};

class MaxDirProperty : public wxDirProperty
{
public:
	MaxDirProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxDirProperty();
};

class MaxArrayStringProperty : public wxArrayStringProperty
{
public:
	MaxArrayStringProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &value);
	~MaxArrayStringProperty();
};

class MaxCursorProperty : public wxCursorProperty
{
public:
	MaxCursorProperty(BBObject * handle, const wxString &label, const wxString &name, int value);
	~MaxCursorProperty();
};

class MaxImageFileProperty : public wxImageFileProperty
{
public:
	MaxImageFileProperty(BBObject * handle, const wxString &label, const wxString &name, const wxString &value);
	~MaxImageFileProperty();
};

class MaxDateProperty : public wxDateProperty
{
public:
	MaxDateProperty(BBObject * handle, const wxString &label, const wxString &name, const wxDateTime &value);
	~MaxDateProperty();
};

class MaxEnumProperty : public wxEnumProperty
{
public:
	MaxEnumProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayInt &values, int value);
	MaxEnumProperty(BBObject * handle, const wxString &label, const wxString &name, wxPGChoices &choices, int value);
	~MaxEnumProperty();
};

class MaxMultiChoiceProperty : public wxMultiChoiceProperty
{
public:
	MaxMultiChoiceProperty(BBObject * handle, const wxString &label, const wxString &name, const wxArrayString &labels, const wxArrayString &value);
	MaxMultiChoiceProperty(BBObject * handle, const wxString &label, const wxString &name, wxPGChoices &choices, const wxArrayString &value);
	~MaxMultiChoiceProperty();
	void SetValueIntArray(wxArrayInt array);
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
class MaxPropertyGridXmlHandler : public wxPropertyGridXmlHandler
{
    DECLARE_DYNAMIC_CLASS(MaxPropertyGridXmlHandler)

public:
    MaxPropertyGridXmlHandler();
    virtual wxObject *DoCreateResource();
    virtual bool CanHandle(wxXmlNode *node);


    wxPropertyGridManager*      m_manager;
    wxPropertyGrid*             m_pg;
    wxPropertyGridPopulator*    m_populator;
};
*/