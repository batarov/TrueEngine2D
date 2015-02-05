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

Dim utils.Input.mouseDown As Byte = 0
Dim utils.Input.mouseUp As Byte = 1
Dim utils.Input.mousePressed As Byte = 0
Dim utils.Input.mouseReleased As Byte = 0

Sub utils.Input.onMouseDown() TRUEENGINE2D_API_EXPORT
	if mouseDown = 0 Then
       mouseDown = 1
       mouseUp = 0
       mousePressed = 1
	EndIf      
End Sub

Sub utils.Input.onMouseUp() TRUEENGINE2D_API_EXPORT
	mouseDown = 0
	mouseUp = 1
	mouseReleased = 1
End Sub

Function utils.Input.getMouseX() As Integer TRUEENGINE2D_API_EXPORT
	Dim As Integer x, y
	IrrGetAbsoluteMousePosition(x, y)
	Return x
End Function

Function utils.Input.getMouseY() As Integer TRUEENGINE2D_API_EXPORT
	Dim As Integer x, y
	IrrGetAbsoluteMousePosition(x, y)
	Return y
End Function

Sub utils.Input.Update() TRUEENGINE2D_API_EXPORT
	If mousePressed = 1 Then mousePressed = 0
	if mouseReleased = 1 Then  mouseReleased = 0
End Sub
