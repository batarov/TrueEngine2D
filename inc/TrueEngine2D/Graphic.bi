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

#Include "ReferenceCounted.bi"

Type Graphic extends ReferenceCounted
	'
 	' If the graphic should update.
 	'
 	active As bool = false

	'
	' If the graphic should render.
	'
	visible as bool = true
 	
	Declare Constructor ()
	
	Declare Virtual Destructor ()
	
	'
 	' Updates the graphic.
 	'
	Declare Virtual Sub Update()
	
	'
	' Renders the graphic to the screen.
	' @param		x		position to draw the graphic.
	' @param		y		position to draw the graphic.
	'
	Declare Virtual Sub Render(ByVal x As Integer, ByVal y As Integer)	
End Type
