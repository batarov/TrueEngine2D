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

#Include "Image.bi"
#Include "TrueEngine2D/Math.bi"
#include "TrueEngine2D/Config.bi"

#include once "IrrlichtWrapper.bi"

Type ImageImpl
    quad As IRR_QUAD
End Type

Constructor Image(ByVal tex As Texture Ptr) TRUEENGINE2D_API_EXPORT
    m_alpha = 1
    Var sz = tex->GetSize()
    m_width = sz.width
    m_height = sz.height
    m_impl = New ImageImpl
    m_impl->quad.tex = *tex
    m_impl->quad.v(0).texture_x = 0
    m_impl->quad.v(0).texture_y = 0
    m_impl->quad.v(1).texture_x = 1
    m_impl->quad.v(1).texture_y = 0
    m_impl->quad.v(2).texture_x = 1
    m_impl->quad.v(2).texture_y = 1
    m_impl->quad.v(3).texture_x = 0
    m_impl->quad.v(3).texture_y = 1
    
    For i As Integer = 0 To 3
        m_impl->quad.v(i).vcolor = &HFFFFFFFF
    Next
End Constructor

Destructor Image() TRUEENGINE2D_API_EXPORT
    Delete m_impl
End Destructor

Sub Image.Render(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
    Var sx = scaleX * scale
    Var sy = scaleY * scale
    Var tx1 = -m_originX * sx
    Var ty1 = -m_originY * sy
    Var tx2 = (m_width - m_originX) * sx
    Var ty2 = (m_height - m_originY) * sy
    
    If m_angle <> 0 Then
        Var c = Cos(m_angle)
        Var s = Sin(m_angle)
        
        m_impl->quad.v(0).x  = tx1*c - ty1*s + x
        m_impl->quad.v(0).y  = tx1*s + ty1*c + y
        m_impl->quad.v(1).x  = tx2*c - ty1*s + x
        m_impl->quad.v(1).y  = tx2*s + ty1*c + y
        m_impl->quad.v(2).x  = tx2*c - ty2*s + x
        m_impl->quad.v(2).y  = tx2*s + ty2*c + y
        m_impl->quad.v(3).x  = tx1*c - ty2*s + x
        m_impl->quad.v(3).y  = tx1*s + ty2*c + y        
    Else
        m_impl->quad.v(0).x = x + tx1
        m_impl->quad.v(0).y = y + ty1
        m_impl->quad.v(1).x = x + tx2
        m_impl->quad.v(1).y = y + ty1
        m_impl->quad.v(2).x = x + tx2
        m_impl->quad.v(2).y = y + ty2
        m_impl->quad.v(3).x = x + tx1
        m_impl->quad.v(3).y = y + ty2
    End If
    IrrDrawQuad(@m_impl->quad)
End Sub

Sub Image.SetScaledWidth(w as Integer) TRUEENGINE2D_API_EXPORT
    scaleY =  w / scale / m_width
End Sub

Sub Image.SetScaledHeight(h as Integer) TRUEENGINE2D_API_EXPORT
    m_height = h / scale / m_height
End Sub

Sub Image.SetAlpha(flag as Byte) TRUEENGINE2D_API_EXPORT
    m_alpha = flag
End Sub

Property Image.angle(value As Single) TRUEENGINE2D_API_EXPORT
    m_angle = value * degtorad
End Property

Property Image.angle() As Single TRUEENGINE2D_API_EXPORT
    Return m_angle * radtodeg
End Property

Property Image.originX(x As Single) TRUEENGINE2D_API_EXPORT
    m_originX = x
End Property

Property Image.originY(y As Single) TRUEENGINE2D_API_EXPORT
    m_originY = y   
End Property

Sub Image.CenterOrigin() TRUEENGINE2D_API_EXPORT
    m_originX = Int(m_width / 2)
    m_originY = Int(m_height / 2)
End Sub

Const Property Image.ScaledWidth() As Single TRUEENGINE2D_API_EXPORT
    Return m_width * scaleX * scale
End Property

Const Property Image.ScaledHeight() As Single TRUEENGINE2D_API_EXPORT
    Return m_height * scaleX * scale 
End Property