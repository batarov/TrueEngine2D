''
'' Copyright (C) 2015 Dmitry Batarov (nonetype@gmail.com)
''
'' This file is part of TrueEngine2D.
''
'' TrueEngine2D is free software: you can redistribute it and/or modify
'' it under the terms of the GNU Lesser General Public License as published by
'' the Free Software Foundation, either version 3 of the License, or
'' (at your option) any later version.
''
'' TrueEngine2D is distributed in the hope that it will be useful,
'' but WITHOUT ANY WARRANTY; without even the implied warranty of
'' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'' GNU Lesser General Public License for more details.
''
'' You should have received a copy of the GNU Lesser General Public License
'' along with TrueEngine2D.  If not, see <http://www.gnu.org/licenses/>.
''
''

#Include "Draw.bi"
#Include "Graphic.bi"
#include "Font.bi"
#Include "Config.bi"

#include once "IrrlichtWrapper.bi"

#define RGBA_A( c ) ( CULng( c ) Shr 24         )
#define RGBA_R( c ) ( CULng( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CULng( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CULng( c )        And 255 )
        
Dim utils.Draw.m_font as FontPtr
Dim utils.Draw.m_halign as Integer = utils.AlignLeft
Dim utils.Draw.m_valign as Integer = utils.AlignLeft			

Sub utils.Draw.Graphic(ByVal g As GraphicPtr, ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
    g->Render(x, y)    '    
End Sub

Sub utils.Draw.SetAlpha(ByVal a As ULong) TRUEENGINE2D_API_EXPORT
    IrrSetAlpha(a)
End Sub

Sub utils.Draw.SetColor(ByVal r As ULong, ByVal g As ULong, ByVal b As ULong) TRUEENGINE2D_API_EXPORT
    IrrSetColor(r, g, b)    
End Sub

Sub utils.Draw.SetColor(ByVal col As ULong) TRUEENGINE2D_API_EXPORT
    Dim r As ULong = RGBA_R(col)
    Dim g As ULong = RGBA_G(col)
    Dim b As ULong = RGBA_B(col)
    IrrSetColor(r, g, b)
End Sub

Sub utils.Draw.SetHAlign(ByVal flag As Integer) TRUEENGINE2D_API_EXPORT
    If flag = utils.AlignLeft Then
        IrrSetHCenter(0)
    ElseIf flag = utils.AlignCenter Then
        IrrSetHCenter(1)
    ElseIf flag = utils.AlignRight Then
        IrrSetHCenter(0)
        m_halign = utils.AlignRight
    End If
End Sub

Sub utils.Draw.SetVAlign(ByVal flag As Integer) TRUEENGINE2D_API_EXPORT
    If flag = utils.AlignTop Then
        IrrSetVCenter(0)
    ElseIf flag = utils.AlignCenter Then
        IrrSetVCenter(1)
    ElseIf flag = utils.AlignBottom Then
        IrrSetVCenter(0)
        m_valign = utils.AlignBottom
    End If
End Sub

Sub utils.Draw.SetFont(ByVal font As FontPtr) TRUEENGINE2D_API_EXPORT
    m_font = font
End Sub

Sub utils.Draw.Text(ByVal x As Integer, ByVal y As Integer, ByRef text_ As Const WString) TRUEENGINE2D_API_EXPORT
    Dim sz as Size => (0, 0)
    sz.width = 0
    sz.height = 0
    if m_halign = utils.AlignRight OrElse m_valign = utils.AlignBottom Then sz = m_font->GetSize(text_)
    m_font->DrawText(x - sz.width, y - sz.height, 0, 0, text_)
End Sub

sub utils.Draw.RectColor(byval x1 as single, byval y1 as single, byval x2 as single, byval y2 as single, _
    byval col1 as ulong, byval col2 as ulong, byval col3 as ulong, byval col4 as ulong) TRUEENGINE2D_API_EXPORT
    IrrDraw2DRectangle(x1, y1, x2, y2, col1, col2, col4, col3)
end sub