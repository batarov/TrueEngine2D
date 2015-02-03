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

#Include "Entity.bi"''
#include "Config.bi"
#Include "World.bi"
#Include "Image.bi"

Type Image_t As Image

Constructor Entity() TRUEENGINE2D_API_EXPORT
	collidable = 1
End Constructor

Destructor Entity () TRUEENGINE2D_API_EXPORT
	Delete m_image
End Destructor

Sub Entity.Update () TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.Render () TRUEENGINE2D_API_EXPORT
	If m_image Then m_image->DrawImage(x, y)
End Sub

Sub Entity.SetImage(byval path as zstring Ptr) TRUEENGINE2D_API_EXPORT
	m_image = New Image_t
	m_image->Load(path)
End Sub

Sub Entity.SetGraphic(g as GraphicPtr) TRUEENGINE2D_API_EXPORT
	m_image = g
End Sub

Sub Entity.SetType(ByRef value As string) TRUEENGINE2D_API_EXPORT
	m_type = value
End Sub

Sub Entity.SetWorld(ByVal world As WorldPtr) TRUEENGINE2D_API_EXPORT
	m_world = world
End Sub

Function Entity.Collide(ByRef type_ As String, ByVal x_ As Single, ByVal y_ As Single) As Entity Ptr TRUEENGINE2D_API_EXPORT
	If m_world = 0 Then Return 0
	
	For i As Integer = 0 To m_world->m_updateList.size()-1
		Dim As EntityPtr e = m_world->m_updateList.at(i)
		If e <> @this And e->m_type = type_ _ 
			And x_ + hitboxWidth > e->x _
			And y_ + hitboxHeight > e->y _
			And x_ < e->x + e->hitboxWidth _
			And y_ < e->y + e->hitboxHeight Then
				Return e
		EndIf
	Next
	
	Return 0	
End Function

Function Entity.CollidePoint(x_ As Single, y_ As Single, pX As Single, pY As Single) As Byte TRUEENGINE2D_API_EXPORT
	If pX >= x_ - originX And pY >= y_ - originY _
		And pX < x_ - originX + hitboxWidth And pY < y_ - originY + hitboxHeight Then
		Return 1
	EndIf
	
	Return 0
End Function

Sub Entity.MoveBy(x_ As Single, y_ As Single) TRUEENGINE2D_API_EXPORT
	x += x_
	y += y_
End Sub
