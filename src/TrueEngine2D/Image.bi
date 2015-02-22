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

#Include "Graphic.bi"

Type Image extends Graphic
	'
	' Scale of the image, affects both x and y scale.
	'
	scale As Single = 1

	'
	' X scale of the image.
	'
	scaleX As Single = 1
	
	'
	' Y scale of the image.
	'
	scaleY As Single = 1
	
	'
	' X origin of the image, determines transformation point.
	' Defaults to top-left corner.
	'
	originX As Integer = 0
	
	' Y origin of the image, determines transformation point.
	' Defaults to top-left corner.
	'
	originY As Integer = 0
	
	Declare Constructor()
	
	Declare Virtual Sub Render(ByVal x As Integer, ByVal y As Integer)
	
	Declare Sub SetAlpha(flag as Byte)

	Declare Sub SetWidth(w as Integer)

	Declare Sub SetHeight(h as Integer)

Protected:
	m_width as Integer
	m_height as Integer
	m_alpha as Byte = 1
End Type
