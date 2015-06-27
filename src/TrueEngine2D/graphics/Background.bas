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

#Include "Background.bi"
#Include "TrueEngine2D/Config.bi"

#include once "IrrlichtWrapper.bi"

Type BackgroundImpl_
    sz as Size
    quad As IRR_QUAD
End Type

Constructor Background(ByVal tex As Texture Ptr) TRUEENGINE2D_API_EXPORT
    m_impl = new BackgroundImpl_
    m_impl->sz = tex->GetSize()
    m_impl->quad.tex = *tex
    For i As Integer = 0 To 3
        m_impl->quad.v(i).vcolor = &HFFFFFFFF
    Next
End Constructor

Destructor Background() TRUEENGINE2D_API_EXPORT
    delete m_impl
End Destructor

Const Property Background.Width() As Integer TRUEENGINE2D_API_EXPORT
    Return m_impl->sz.width
End Property

Const Property Background.Height() As Integer TRUEENGINE2D_API_EXPORT
    Return m_impl->sz.height
End Property

Sub Background.Render(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
    Var sz = m_impl->sz
    Dim w As Single = sz.width * scaleX
    Dim h As Single = sz.height * scaleY
    m_impl->quad.v(0).x = x
    m_impl->quad.v(0).y = y
    m_impl->quad.v(1).x = x + w
    m_impl->quad.v(1).y = y
    m_impl->quad.v(2).x = x + w
    m_impl->quad.v(2).y = y + h
    m_impl->quad.v(3).x = x
    m_impl->quad.v(3).y = y + h

    Dim texx1 As Single = 0.0
    Dim texy1 As Single = 0.0
    
    If htiled <> 0 AndAlso hspeed <> 0 Then
        texx1 = m_x / sz.width
    End If
    
    If vtiled <> 0 AndAlso vspeed <> 0 Then
        texy1 = m_y / sz.height
    End If
    
    Dim texx2 As Single = 1.0
    Dim texy2 As Single = 1.0
    
    If htiled <> 0 Then
        texx2 = w / sz.width
        If hspeed <> 0 Then
            texx2 += texx1
        End If
    End If
    
    If vtiled <> 0 Then
        texy2 = h / sz.height
        If vspeed <> 0 Then
            texy2 += texy1
        End If
    End If

    m_impl->quad.v(0).texture_x = texx1
    m_impl->quad.v(0).texture_y = texy1
    m_impl->quad.v(1).texture_x = texx2
    m_impl->quad.v(1).texture_y = texy1
    m_impl->quad.v(2).texture_x = texx2
    m_impl->quad.v(2).texture_y = texy2
    m_impl->quad.v(3).texture_x = texx1
    m_impl->quad.v(3).texture_y = texy2        
        
    IrrDrawQuad(@m_impl->quad)
End Sub

Sub Background.Update()  TRUEENGINE2D_API_EXPORT
    If hspeed = 0 AndAlso vspeed = 0 then return
    Var sz = m_impl->sz
    Var w = sz.width * scaleX
    Var h = sz.height * scaleY
    If hspeed <> 0 Then
        m_x += -hspeed
        If hspeed > 0 AndAlso m_x > w Then m_x = Frac(w / sz.width) * sz.width        
        If hspeed < 0 AndAlso m_x < w Then m_x = w - Frac(w / sz.width) * sz.width
    End If
    
    If vspeed <> 0 Then
        m_y += -vspeed
        if vspeed > 0 AndAlso m_y > h Then m_y = Frac(h / sz.height) * sz.height
        if vspeed < 0 AndAlso m_y < h Then m_y = h - Frac(h / sz.height) * sz.height
    End If
End Sub
