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

#Include "Input.bi"

Dim utils.Input.m_mouseDown As Byte = 0
Dim utils.Input.m_mouseUp As Byte = 1
Dim utils.Input.m_mousePressed As Byte = 0
Dim utils.Input.m_mouseReleased As Byte = 0

Dim utils.Input.m_key(255) as Byte
Dim utils.Input.m_press(255) as Integer
Dim utils.Input.m_release(255) as Integer
Dim utils.Input.lastKey as Integer = 0
Dim utils.Input.m_keyNum as Integer = 0
Dim utils.Input.m_pressNum as Integer = 0
Dim utils.Input.m_releaseNum as Integer = 0

Sub utils.Input.OnMouseDown() TRUEENGINE2D_API_EXPORT
	if m_mouseDown = 0 Then
		m_mouseDown = 1
		m_mouseUp = 0
		m_mousePressed = 1
	EndIf      
End Sub

Sub utils.Input.OnMouseUp() TRUEENGINE2D_API_EXPORT
	m_mouseDown = 0
	m_mouseUp = 1
	m_mouseReleased = 1
End Sub

Sub utils.Input.OnKeyDown(e as KeyEventPtr) TRUEENGINE2D_API_EXPORT	' get the keycode
	' get the keycode
	lastKey = e->key
	Dim code as Integer = lastKey
	if (code < 0 Or code > 255) then return
	if (m_key(code) = 0) Then
		m_key(code) = 1
		m_keyNum += 1
		m_press(m_pressNum) = code
		m_pressNum += 1
	EndIf
End Sub

Sub utils.Input.OnKeyUp(e as KeyEventPtr) TRUEENGINE2D_API_EXPORT
	' get the keycode
	Dim code as Integer = e->key			
	if (code < 0 Or code > 255) then return			
	if (m_key(code) <> 0) then
		m_key(code) = 0
		m_keyNum -= 1
		m_release(m_releaseNum) = code
		m_releaseNum += 1
	EndIf
End Sub

Function utils.Input.GetMouseX() As Integer TRUEENGINE2D_API_EXPORT
	Dim As Integer x, y
	IrrGetAbsoluteMousePosition(x, y)
	Return x
End Function

Function utils.Input.GetMouseY() As Integer TRUEENGINE2D_API_EXPORT
	Dim As Integer x, y
	IrrGetAbsoluteMousePosition(x, y)
	Return y
End Function

Function utils.Input.Check(key as Integer) As Byte TRUEENGINE2D_API_EXPORT
	Return IIf(key < 0, (m_keyNum > 0), m_key(key))
End Function

Function utils.Input.Pressed(key as Integer) As Byte TRUEENGINE2D_API_EXPORT
	if key < 0 then
		return  m_pressNum
	else
		for i as Integer = 0 to 255
			if m_press(i) = key then
				return 1
			endif
		next
		return 0
	EndIf
End Function

Function utils.Input.Released(ByVal key as Integer) As Byte TRUEENGINE2D_API_EXPORT
	If key < 0 Then
		Return m_releaseNum
	Else
		for i as Integer = 0 to 255
			if m_release(i) = key then
				return 1
			endif
		next
		return 0
	EndIf
End Function

Sub utils.Input.Update() TRUEENGINE2D_API_EXPORT
	while m_pressNum
		m_pressNum -= 1	
		m_press(m_pressNum) = -1
	wend
	m_pressNum = 0
	while (m_releaseNum)
		m_releaseNum -= 1
		m_release(m_releaseNum) = -1
	wend
	m_releaseNum = 0
	If m_mousePressed = 1 Then m_mousePressed = 0
	if m_mouseReleased = 1 Then  m_mouseReleased = 0
End Sub

Function utils.Input.MouseDown() As Byte TRUEENGINE2D_API_EXPORT
	Return m_mouseDown
End Function
		
Function utils.Input.MouseUp() As Byte TRUEENGINE2D_API_EXPORT
	Return m_mouseUp
End Function

Function utils.Input.MousePressed() As Byte TRUEENGINE2D_API_EXPORT
	Return m_mousePressed
End Function

Function utils.Input.MouseReleased() As Byte TRUEENGINE2D_API_EXPORT
	Return m_mouseReleased
End Function
