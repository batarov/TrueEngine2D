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

Type GraphicPtr As Graphic Ptr
Type WorldPtr As World ptr

Type Entity extends object
	' X position of the Entity in the World.
	x As Single = 0
	
	' Y position of the Entity in the World.	
	y As Single = 0
	
	' If the Entity should render.
	visible As Byte = 1
	
	' If the Entity should respond to collision checks.
	collidable As Byte = 1
	
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
	
	Declare Sub SetGraphic(g as GraphicPtr)
	
	Declare Sub SetType(ByRef value As string)
	
	Declare Sub SetWorld(byval world As WorldPtr)
	
	Declare Function Collide(ByRef type_ As String, ByVal x_ As Single, ByVal y_ As Single) As Entity Ptr
	
	Declare Function CollidePoint(x_ As Single, y_ As Single, pX As Single, pY As Single) As Byte
	
	Declare Sub MoveBy(x_ As Single, y_ As Single)
	
	'
	'	Override this, called when the Entity is added to a World.
	'
	Declare Virtual Sub Added()
	
	'
	' Override this, called when the Entity is removed from a World.
	'
	Declare Virtual Sub Removed()
  
Public:
' Entity information.
/' Internal '/ m_world As WorldPtr
/' Internal '/ m_type As String
/' Internal '/ m_name As String
/' Internal '/ m_layer As Integer
/' Internal '/	m_updatePrev As Entity Ptr
/' Internal '/	m_updateNext As Entity Ptr
/' Internal '/	m_renderPrev As Entity Ptr
/' Internal '/	m_renderNext As Entity Ptr
/' Internal '/	m_typePrev As Entity Ptr
/' Internal '/	m_typeNext As Entity Ptr
/' Internal '/	m_recycleNext As Entity Ptr

Private:
' Collision information.
	m_x as Single
	m_y as Single
	m_moveX as Single = 0
	m_moveY as Single = 0

' Rendering information.	
/' Internal '/ Public: m_graphic As GraphicPtr
End Type
