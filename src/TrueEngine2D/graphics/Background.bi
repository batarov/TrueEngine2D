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
#Include "TrueEngine2D/Texture.bi"

Type BackgroundImpl as BackgroundImpl_

Type Background extends Graphic
    Declare Constructor(ByVal tex As Texture Ptr)
    Declare Destructor()
	
    Declare Const Property width() As Integer
    Declare Const Property height() As Integer
	
    scaleX As Single = 1.0
	scaleY As Single = 1.0
	
	htiled As Integer
	vtiled As Integer
	
	hspeed As Single
	vspeed As Single

Private:
	Declare Sub Render(ByVal x As Integer, ByVal y As Integer) override
	Declare Sub Update() override
	
Private:
	m_width As Single
	m_height As Single
	m_x As Single
	m_y As Single
    m_impl as BackgroundImpl Ptr
End Type
