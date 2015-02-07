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
	x As Single
	
	' Y position of the Entity in the World.	
	y As Single
	
	' If the Entity should render.
	visible As Byte
	
	' If the Entity should respond to collision checks.
	collidable As byte
	
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
	
Protected:
	m_image As GraphicPtr
	m_type As String
	m_world As WorldPtr
End Type

