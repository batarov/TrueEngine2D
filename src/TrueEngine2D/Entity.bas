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
#Include "World.bi"
#Include "graphics/Image.bi"
#include "Config.bi"

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
    If m_graphic <> nullptr AndAlso m_graphic->visible = true Then m_graphic->Render(x, y)
    PostRender()
End Sub

Sub Entity.PostRender () TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.SetGraphic(ByVal g as GraphicPtr) TRUEENGINE2D_API_EXPORT
    m_graphic = g
End Sub

Sub Entity.SetType(ByRef value As String) TRUEENGINE2D_API_EXPORT
    m_type = value
End Sub

Sub Entity.SetWorld(ByVal world As WorldPtr) TRUEENGINE2D_API_EXPORT
    m_world = world
End Sub

Function Entity.Collide(ByRef type_ As String, ByVal x_ As Single, ByVal y_ As Single) As Entity Ptr TRUEENGINE2D_API_EXPORT
    If m_world = nullptr Then Return nullptr
    
    Dim As EntityPtr e = m_world->m_typeFirst.value(type_, nullptr)
    If e = nullptr Then Return nullptr
    m_x = x
    m_y = y
    x = x_
    y = y_
    
    While e <> nullptr
        If e->collidable = true AndAlso e <> @This _ 
            AndAlso x_ - originX + hitboxWidth > e->x - e->originX _
            AndAlso y_ - originY + hitboxHeight > e->y - e->originY _
            AndAlso x_ - originX < e->x - e->originX + e->hitboxWidth _
            AndAlso y_ - originY < e->y - e->originY + e->hitboxHeight Then
            x = m_x
            y = m_y
            Return e
        End If
        e = e->m_typeNext
    Wend        
    x = m_x
    y = m_y
    Return nullptr    
End Function

Function Entity.CollidePoint(ByVal x_ As Single, ByVal y_ As Single, ByVal pX As Single, ByVal pY As Single) As bool TRUEENGINE2D_API_EXPORT
    If pX >= x_ - originX And pY >= y_ - originY _
        And pX < x_ - originX + hitboxWidth And pY < y_ - originY + hitboxHeight Then
        Return true
    End If   
    Return false
End Function

Sub Entity.MoveBy(ByVal x_ As Single, ByVal y_ As Single) TRUEENGINE2D_API_EXPORT
    m_moveX += x_
    m_moveY += y_
    x_ = iif(m_moveX >= 0, fix(m_moveX + 0.5), fix(m_moveX - 0.5))
    y_ = iif(m_moveY >= 0, fix(m_moveY + 0.5), fix(m_moveY - 0.5))
    m_moveX -= x_
    m_moveY -= y_
    x += x_
    y += y_
End Sub

Sub Entity.Added() TRUEENGINE2D_API_EXPORT
End Sub

Sub Entity.Removed() TRUEENGINE2D_API_EXPORT
End Sub

Function Entity.DistanceToPoint(ByVal px As Single, ByVal py As Single, ByVal useHitbox As bool) As Single TRUEENGINE2D_API_EXPORT
    If useHitbox = false Then
        Var dx = x - px
        Var dy = y - py
        Return Sqr(dx * dx + dy * dy)
    End If
    Return 1
End Function

Function Entity.DistanceFrom(ByRef e As Const Entity, ByVal useHitboxes As bool) As Single TRUEENGINE2D_API_EXPORT
   If useHitboxes = false Then
        Var dx = x - e.x
        Var dy = y - e.y
        Return Sqr(dx * dx + dy * dy)
    End If
    Return 1	
End Function

Const Property Entity.layer() As Integer TRUEENGINE2D_API_EXPORT
    Return m_layer
End Property
    
Property Entity.layer(value As Integer) TRUEENGINE2D_API_EXPORT
    If m_layer = value Then Return
    If m_world = nullptr Then
        m_layer = value
        Return
    End If
    m_world->RemoveRender(@this)
    m_layer = value
    m_world->AddRender(@this)
End Property
