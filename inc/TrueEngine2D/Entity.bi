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

Type GraphicPtr As Graphic Ptr
Type WorldPtr As World ptr

Type Entity extends ReferenceCounted
    ' X position of the Entity in the World.
    x As Single = 0
    
    ' Y position of the Entity in the World.    
    y As Single = 0
    
    ' If the Entity should render.
    visible As bool = true
    
    ' If the Entity should respond to collision checks.
    collidable As bool = true
    
    ' Width of the Entity's hitbox.
    hitboxWidth As Integer

    ' Height of the Entity's hitbox.
    hitboxHeight As Integer

    ' X origin of the Entity's hitbox.
    originX As Integer

    ' Y origin of the Entity's hitbox.
    originY As Integer
    
    Declare Constructor()
    
    Declare Virtual Destructor ()
    
    Declare Virtual Sub Update ()
    
    Declare virtual Sub PreRender ()

    Declare virtual Sub Render ()

    Declare virtual Sub PostRender ()
    
    Declare Sub SetGraphic(ByVal g as GraphicPtr)
    
    Declare Sub SetType(ByRef value As String)
    
    Declare Sub SetWorld(ByVal world As WorldPtr)
    
    Declare Function Collide(ByRef type_ As String, ByVal x_ As Single, ByVal y_ As Single) As Entity Ptr
    
    Declare Function CollidePoint(ByVal x_ As Single, ByVal y_ As Single, ByVal pX As Single, ByVal pY As Single) As bool
    
    Declare Sub MoveBy(ByVal x_ As Single, ByVal y_ As Single)
    
    '
    '   Override this, called when the Entity is added to a World.
    '
    Declare Virtual Sub Added()
    
    '
    ' Override this, called when the Entity is removed from a World.
    '
    Declare Virtual Sub Removed()
    
    '
    ' Calculates the distance from another Entity.
    ' @param        e                       The other Entity.
    ' @param        useHitboxes         If hitboxes should be used to determine the distance. If not, the Entities' x/y positions are used.
    ' @return                               The distance.
    '
    Declare Function DistanceToPoint(ByVal px As Single, ByVal py As Single, ByVal useHitbox As bool = false) As Single
    
    '
    ' Calculates the distance from another Entity.
    ' @param   e               The other Entity.
    ' @param   useHitboxes     If hitboxes should be used to determine the distance. If not, the Entities' x/y positions are used.
    ' @return  The distance.
    '
    Declare Function DistanceFrom(ByRef e As Const Entity, ByVal useHitboxes As bool = false) As Single

    '
    ' The rendering layer of this Entity. Higher layers are rendered first.
    '
    Declare Const Property layer() As Integer    
    Declare Property layer(value As Integer)
  
Public:
' Entity information.
/' Internal '/ m_world As WorldPtr
/' Internal '/ m_type As String
/' Internal '/ m_name As String
/' Internal '/ m_layer As Integer
/' Internal '/  m_updatePrev As Entity Ptr
/' Internal '/  m_updateNext As Entity Ptr
/' Internal '/  m_renderPrev As Entity Ptr
/' Internal '/  m_renderNext As Entity Ptr
/' Internal '/  m_typePrev As Entity Ptr
/' Internal '/  m_typeNext As Entity Ptr
/' Internal '/  m_recycleNext As Entity Ptr

Private:
' Collision information.
    m_x as Single
    m_y as Single
    m_moveX as Single = 0
    m_moveY as Single = 0

' Rendering information.    
/' Internal '/ Public: m_graphic As GraphicPtr
End Type