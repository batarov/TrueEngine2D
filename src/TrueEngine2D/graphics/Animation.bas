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

#Include "Animation.bi"
#Include "TrueEngine2D/Config.bi"

#include once "IrrlichtWrapper.bi"

type AnimationImpl_
    sz as Size
    quad As IRR_QUAD
end type

constructor Animation(ByVal tex As Texture Ptr, ByVal frames As Long, ByVal listener As AnimationListener Ptr) TRUEENGINE2D_API_EXPORT
    m_impl = new AnimationImpl_
    m_impl->sz = tex->GetSize()
    m_impl->quad.tex = *tex
    For i As Integer = 0 To 3
        m_impl->quad.v(i).vcolor = &HFFFFFFFF
    Next
	m_frames = frames
    Var sz = m_impl->sz
	m_frameWidth = sz.width / m_frames
	m_frameHeight = sz.height
	m_endFrame = m_frames
	active = true
    if listener <> nullptr then
        this.listener = listener
        listener->Grab()        
    end if
end constructor

destructor Animation() TRUEENGINE2D_API_EXPORT
    if listener <> nullptr then listener->Drop()
    delete m_impl
end destructor

sub Animation.Update() TRUEENGINE2D_API_EXPORT
    m_counter += 1
	If m_counter < rate Then Return
	Var i = m_counter * m_speed
	While m_counter > 0
		m_index = (m_index + 1) Mod m_endFrame
        If m_index = 0 AndAlso listener <> nullptr Then
            listener->OnAnimationEnd(@this)
        End If
		m_counter -= 1
	Wend
	m_counter = 0 	
end sub

sub Animation.Render(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
    dim v_top as f32 = x + -originX
    dim v_left as f32 = y + -originY 
    dim v_right as f32 = x + (m_frameWidth - originX)
    dim v_bottom as f32 = y + (m_frameHeight - originY)

    dim w as f32 = m_frameWidth
    dim h as f32 = m_frameHeight
    
    m_impl->quad.v(0).x = v_top
    m_impl->quad.v(0).y = v_left
    m_impl->quad.v(1).x = v_right
    m_impl->quad.v(1).y = v_left
    m_impl->quad.v(2).x = v_right
    m_impl->quad.v(2).y = v_bottom
    m_impl->quad.v(3).x = v_top
    m_impl->quad.v(3).y = v_bottom
    
    Var dt = 1.0 / m_frames
    dim texx1 As f32 = dt * m_index
    dim texy1 As f32 = 0.0
     
    dim texx2 As f32 = texx1 + dt
    dim texy2 As f32 = 1.0

    m_impl->quad.v(0).texture_x = texx1
    m_impl->quad.v(0).texture_y = texy1
    m_impl->quad.v(1).texture_x = texx2
    m_impl->quad.v(1).texture_y = texy1
    m_impl->quad.v(2).texture_x = texx2
    m_impl->quad.v(2).texture_y = texy2
    m_impl->quad.v(3).texture_x = texx1
    m_impl->quad.v(3).texture_y = texy2
    
    IrrDrawQuad(@m_impl->quad)
end sub

const property Animation.originX() as single TRUEENGINE2D_API_EXPORT
	return m_originX
end property

property Animation.originX(byval x as single) TRUEENGINE2D_API_EXPORT
	m_originX = x
end property

const property Animation.originY() as single TRUEENGINE2D_API_EXPORT
	return m_originY
end property

property Animation.originY(byval y as single) TRUEENGINE2D_API_EXPORT
	m_originY = y
end property

sub Animation.CenterOrigin() TRUEENGINE2D_API_EXPORT
    m_originX = Int(m_frameWidth / 2)
    m_originY = Int(m_frameHeight / 2)
end sub