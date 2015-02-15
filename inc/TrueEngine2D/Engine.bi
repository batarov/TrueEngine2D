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

#inclib "TrueEngine2D"

Type WorldPtr As World ptr

Type Engine Extends Object
	'
	' If the game should stop updating/rendering.
	'
	paused As Byte = 0
	
	'
	' The max amount of frames that can be skipped in fixed framerate mode.
	'
	maxFrameSkip As UInteger = 5
	
	Declare Virtual Destructor ()
	
	Declare Static Function GetInstance() As Engine Ptr
	
	Declare Sub Destroy()
	
	' Constructor. Defines startup information about your game.
	' @param       w           The width of your game.
	' @param       h           The height of your game.
	' @param       frameRate   The game framerate, in frames per second.	
	Declare Sub Init(ByVal w As UInteger, ByVal h As UInteger, ByVal frameRate As Single = 60)
	
	' Updates the game, updating the World and Entities.	
	Declare Sub Update()

	' Renders the game, rendering the World and Entities.
	Declare Sub Render()
	
	Declare Sub StartMainLoop()
	
	Declare Sub StopMainLoop()
	
	Declare Function AddWorld(world As WorldPtr) as WorldPtr
	
	Declare Function GetWorld() As WorldPtr
		
	Declare Sub SetFrameRate(ByVal frameRate As single)

Private:	
	' Switch Worlds if they've changed.	
	Declare Sub CheckWorld()

	Static m_instance As Engine Ptr
	
Protected:
	Declare Constructor ()
	Declare Constructor (ByRef rhs As Engine)
	m_width As UInteger
	m_height As UInteger
	m_frameRate As Single
	m_world As WorldPtr
	m_goto As WorldPtr
	m_ShutdownRequested As Byte
	
Private:
	' Timing information.
	m_delta As Single = 0
	m_time As Single
	m_last As Single
	m_prev As Single
	m_rate As Single
	m_skip As Single
End Type

#define GE Engine.GetInstance()
