/////////////////////////////////////////////////////////////////////////////
// Name:        wxGradientButton.h
// Purpose:     
// Author:      Volodymir (T-Rex) Tryapichko
// Modified by: 
// Created:     01/08/2008 20:25:42
// RCS-ID:      
// Copyright:   Volodymir (T-Rex) Tryapichko, 2008
// Licence:     
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXGRADIENTBUTTON_H_
#define _WXGRADIENTBUTTON_H_


/*!
 * Includes
 */

////@begin includes
////@end includes

/*!
 * Forward declarations
 */

////@begin forward declarations
class wxGradientButton;
////@end forward declarations

/*!
 * Control identifiers
 */

////@begin control identifiers
#define ID_WXGRADIENTBUTTON 10003
#define SYMBOL_WXGRADIENTBUTTON_STYLE wxSIMPLE_BORDER|wxFULL_REPAINT_ON_RESIZE
#define SYMBOL_WXGRADIENTBUTTON_IDNAME ID_WXGRADIENTBUTTON
#define SYMBOL_WXGRADIENTBUTTON_SIZE wxSize(100, 100)
#define SYMBOL_WXGRADIENTBUTTON_POSITION wxDefaultPosition
////@end control identifiers


/*!
 * wxGradientButton class declaration
 */

class wxGradientButton: public wxWindow
{    
    DECLARE_DYNAMIC_CLASS( wxGradientButton )
    DECLARE_EVENT_TABLE()

	wxSize DoGetBestSize() const;
public:
    /// Constructors
    wxGradientButton();
    wxGradientButton(wxWindow* parent, wxWindowID id = ID_WXGRADIENTBUTTON, const wxString & label = wxEmptyString, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize(100, 100), long style = wxSIMPLE_BORDER);

    /// Creation
    bool Create(wxWindow* parent, wxWindowID id = ID_WXGRADIENTBUTTON, const wxString & label = wxEmptyString, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize(100, 100), long style = wxSIMPLE_BORDER);

    /// Destructor
    ~wxGradientButton();

    /// Initialises member variables
    void Init();

    /// Creates the controls and sizers
    void CreateControls();

////@begin wxGradientButton event handler declarations

    /// wxEVT_SIZE event handler for ID_WXGRADIENTBUTTON
    void OnSize( wxSizeEvent& event );

    /// wxEVT_PAINT event handler for ID_WXGRADIENTBUTTON
    void OnPaint( wxPaintEvent& event );

    /// wxEVT_ERASE_BACKGROUND event handler for ID_WXGRADIENTBUTTON
    void OnEraseBackground( wxEraseEvent& event );

    /// wxEVT_LEFT_DOWN event handler for ID_WXGRADIENTBUTTON
    void OnLeftDown( wxMouseEvent& event );

    /// wxEVT_LEFT_UP event handler for ID_WXGRADIENTBUTTON
    void OnLeftUp( wxMouseEvent& event );

////@end wxGradientButton event handler declarations

////@begin wxGradientButton member function declarations

    wxString GetLabel() const { return m_Label ; }
    void SetLabel(wxString value) { m_Label = value ; }

    wxColour GetGradientTopStartColour() const { return m_GradientTopStartColour ; }
    void SetGradientTopStartColour(wxColour value) { m_GradientTopStartColour = value ; }

    wxColour GetGradientTopEndColour() const { return m_GradientTopEndColour ; }
    void SetGradientTopEndColour(wxColour value) { m_GradientTopEndColour = value ; }

    wxColour GetGradientBottomStartColour() const { return m_GradientBottomStartColour ; }
    void SetGradientBottomStartColour(wxColour value) { m_GradientBottomStartColour = value ; }

    wxColour GetGradientBottomEndColour() const { return m_GradientBottomEndColour ; }
    void SetGradientBottomEndColour(wxColour value) { m_GradientBottomEndColour = value ; }

    wxColour GetPressedColourTop() const { return m_PressedColourTop ; }
    void SetPressedColourTop(wxColour value) { m_PressedColourTop = value ; }

    wxColour GetPressedColourBottom() const { return m_PressedColourBottom ; }
    void SetPressedColourBottom(wxColour value) { m_PressedColourBottom = value ; }

    /// Retrieves bitmap resources
    wxBitmap GetBitmapResource( const wxString& name );

    /// Retrieves icon resources
    wxIcon GetIconResource( const wxString& name );
////@end wxGradientButton member function declarations

    /// Should we show tooltips?
    static bool ShowToolTips();

////@begin wxGradientButton member variables
    wxString m_Label;
    wxColour m_GradientTopStartColour;
    wxColour m_GradientTopEndColour;
    wxColour m_GradientBottomStartColour;
    wxColour m_GradientBottomEndColour;
    wxColour m_PressedColourTop;
    wxColour m_PressedColourBottom;
////@end wxGradientButton member variables
};

#endif
    // _WXGRADIENTBUTTON_H_
