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

type KeyEventPtr as IRR_KEY_EVENT Ptr

Namespace utils
	Type Input extends object
		Static mouseDown As Byte
		
		Static mouseUp As Byte
		
		Static mousePressed As Byte
		
		Static mouseReleased As Byte
		
		Static lastKey As Integer
		
		Declare Static Sub OnMouseDown()
		
		Declare Static Sub OnMouseUp()
		
		Declare Static Sub OnKeyDown(ByVal e as KeyEventPtr)
		
		Declare Static Sub OnKeyUp(ByVal e as KeyEventPtr)
		
		Declare Static Function GetMouseX() As Integer
		
		Declare Static Function GetMouseY() As Integer
		
		Declare Static Function Check(ByVal key as Integer) As Byte
		
		Declare Static Function Pressed(ByVal key as Integer) As Byte
		
		Declare Static Function Released(ByVal key as Integer) As Byte

		Declare Static Sub Update()
		
		Private:
			Static m_keyNum as Integer
			
			Static m_key(255) as Byte
			
			Static m_press(255) as Integer
			
			Static m_release(255) as Integer
			
			Static m_pressNum as Integer
			
			Static m_releaseNum as Integer
	End Type
End Namespace
