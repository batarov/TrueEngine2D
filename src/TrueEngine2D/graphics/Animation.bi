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

#Pragma Once

#Include "TrueEngine2D/Graphic.bi"
#include "TrueEngine2D/Texture.bi"
#include "TrueEngine2D/AnimationListener.bi"

type AnimationImpl as AnimationImpl_

type Animation extends Graphic
    listener as AnimationListener ptr
    scaleX as f32 = 1
    scaleY as f32 = 1
    rate as f32 = 1

    declare constructor(byval tex as Texture ptr, byval frames as long, byval listener as AnimationListener ptr = nullptr)
    declare destructor()

    declare const property originX() as f32
    declare property originX(byval x as f32)

    declare const property originY() as f32
    declare property originY(byval y as f32)

    '
    ' Center's the Animation's origin (half width & height).
    '
    declare sub CenterOrigin()

private:
    declare sub Update() override
    declare sub Render(ByVal x As Integer, ByVal y As Integer) override

    m_index As UInteger
    m_frames As Long
    m_speed As f32 = 1.0
    m_frameWidth As UInteger = Any
    m_frameHeight As UInteger = Any
    m_frame As f32 = -1
    m_endFrame As UInteger = Any
    m_counter As f32 = 0
	
    m_originX as f32 = 0.0
    m_originY as f32 = 0.0
    
    m_impl as AnimationImpl ptr
end type
