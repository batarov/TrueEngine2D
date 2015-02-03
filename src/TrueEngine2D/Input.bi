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

Namespace utils
	Type Input extends object
		Static mouseDown As Byte
		
		Static mouseUp As Byte
		
		Static mousePressed As Byte
		
		Static mouseReleased As Byte
		
		Declare Static Sub onMouseDown()
		
		Declare Static Sub onMouseUp()
		
		Declare Static Function getMouseX() As Integer
		
		Declare Static Function getMouseY() As Integer
		
		Declare Static Sub Update()
	End Type
End Namespace
