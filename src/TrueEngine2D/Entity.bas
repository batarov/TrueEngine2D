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

End Constructor

Destructor Entity () TRUEENGINE2D_API_EXPORT
End Destructor

Sub Entity.Update () TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.PreRender () TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.Render () TRUEENGINE2D_API_EXPORT
	PreRender()
	If m_graphic <> 0 And visible <> 0 Then m_graphic->Render(x, y)
	PostRender()
End Sub

Sub Entity.PostRender () TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.SetGraphic(g as GraphicPtr) TRUEENGINE2D_API_EXPORT
	m_graphic = g
End Sub

Sub Entity.SetType(ByRef value As string) TRUEENGINE2D_API_EXPORT
	m_type = value
End Sub

Sub Entity.SetWorld(ByVal world As WorldPtr) TRUEENGINE2D_API_EXPORT
	m_world = world
End Sub

Function Entity.Collide(ByRef type_ As String, ByVal x_ As Single, ByVal y_ As Single) As Entity Ptr TRUEENGINE2D_API_EXPORT
	If m_world = 0 Then Return 0
	
	Dim As EntityPtr e = m_world->m_typeFirst.value(type_, 0)
	If e = 0 Then Return 0
	m_x = x
	m_y = y
	x = x_
	y = y_
	
	While e <> 0
		If e->collidable <> 0 And e <> @This _ 
			And x_ - originX + hitboxWidth > e->x - e->originX _
			And y_ - originY + hitboxHeight > e->y - e->originY _
			And x_ - originX < e->x - originX + e->hitboxWidth _
			And y_ - originY < e->y - originY + e->hitboxHeight Then
			x = m_x
			y = m_y
			Return e
		EndIf
		e = e->m_typeNext
	Wend		
	x = m_x
	y = m_y
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
	m_moveX += x_
	m_moveY += y_
 	x_ = iif(m_moveX >=0, fix(m_moveX + 0.5), fix(m_moveX - 0.5))
 	y_ = iif(m_moveY >=0, fix(m_moveY + 0.5), fix(m_moveY - 0.5))
 	m_moveX -= x_
 	m_moveY -= y_
	x += x_
	y += y_
End Sub

Sub Entity.Added() TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.Removed() TRUEENGINE2D_API_EXPORT
End Sub
