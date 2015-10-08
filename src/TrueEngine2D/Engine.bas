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

#Include "Engine.bi"

#include once "IrrlichtWrapper.bi"

#Include "World.bi"
#Include "Input.bi"
#Include "Math.bi"
#include "Matrix.bi"
#Include "Config.bi"

Dim Engine.m_instance As Engine Ptr = nullptr

Constructor Engine() TRUEENGINE2D_API_EXPORT
    m_world = new World
End Constructor

Destructor Engine() TRUEENGINE2D_API_EXPORT
    m_world->Drop()
End Destructor

Sub Engine.SetFrameRate(ByVal frameRate As Single) TRUEENGINE2D_API_EXPORT
	m_frameRate = frameRate
End Sub

Sub Engine.Init(ByVal w As UInteger, ByVal h As UInteger, ByVal frameRate As Single) TRUEENGINE2D_API_EXPORT
	IrrStart(IRR_EDT_OPENGL, w, h, IRR_BITS_PER_PIXEL_16, IRR_WINDOWED, IRR_NO_SHADOWS, IRR_CAPTURE_EVENTS, IRR_VERTICAL_SYNC_ON)
	m_frameRate = frameRate
	m_width = w
	m_height = h
End Sub

Sub Engine.StartMainLoop() TRUEENGINE2D_API_EXPORT
	' switch worlds
	if m_goto <> nullptr Then CheckWorld()
    
    Dim projectionMatrix as Matrix
    projectionMatrix.BuildProjectionMatrixOrthoLH(m_width, - CLng(m_height), -1, 1)
    projectionMatrix.SetTranslation(1, 1, 0)
	IrrSetTransform(ETS_PROJECTION, projectionMatrix)
	
	' fixed framerate
	m_rate = 1000 / m_frameRate
	m_skip = m_rate * (maxFrameSkip + 1)
	m_last = IrrGetTime()
	m_prev = m_last
	
	Dim As Integer dt, t0
	Dim As Single fTime, fDeltaTime
	t0 = IrrGetTime()
	fTime = 0
	While IrrRunning And m_ShutdownRequested = false
		While IrrKeyEventAvailable
				Dim KeyEvent As IRR_KEY_EVENT Ptr = IrrReadKeyEvent
    			If KeyEvent->direction = IRR_KEY_DOWN Then
					utils.Input.OnKeyDown(KeyEvent)
    			ElseIf KeyEvent->direction = IRR_KEY_UP Then
					utils.Input.OnKeyUp(KeyEvent)
    			End If
		Wend
		
		While IrrMouseEventAvailable
			Dim ev As IRR_MOUSE_EVENT Ptr = IrrReadMouseEvent
			If ev->action = IRR_EMIE_LMOUSE_PRESSED_DOWN _
				Or ev->action = IRR_EMIE_RMOUSE_PRESSED_DOWN _
				Or ev->action = IRR_EMIE_MMOUSE_PRESSED_DOWN Then
				utils.Input.OnMouseDown()
			ElseIf ev->action = IRR_EMIE_LMOUSE_LEFT_UP _
				Or ev->action = IRR_EMIE_RMOUSE_LEFT_UP _
				Or ev->action = IRR_EMIE_MMOUSE_LEFT_UP Then
				utils.Input.OnMouseUp()
			End If
		Wend
		
		' update Timer
		m_time = IrrGetTime()
		m_delta += (m_time - m_last)
		m_last = m_time
		If m_delta < m_rate Then Continue While

		' update loop
		If m_delta > m_skip then m_delta = m_skip
		While m_delta >= m_rate
			'update timer
			m_delta -= m_rate
			m_prev = m_time
			
			' update loop
			if paused = false Then Update()
			
			' update input
			utils.Input.Update()
			
			' update timer
 			m_time = IrrGetTime()
		Wend				
		
		' render loop
		if paused = false Then
			IrrBeginScene( 0,0,0 )			
			Render()
			IrrEndScene
		End If
	Wend
End Sub

Sub Engine.StopMainLoop() TRUEENGINE2D_API_EXPORT
	m_shutdownRequested = true
End Sub

Sub Engine.Update() TRUEENGINE2D_API_EXPORT
    m_world->UpdateLists()
    if m_goto <> nullptr Then CheckWorld()
    m_world->Update()
    m_world->UpdateLists(false)
End Sub

Sub Engine.Render() TRUEENGINE2D_API_EXPORT
	if m_world->visible = true then m_world->Render()
End Sub

Sub Engine.CheckWorld() TRUEENGINE2D_API_EXPORT
	If m_goto = nullptr Then Return
	m_world->EndWorld()
	m_world->UpdateLists()
    m_world->Drop()
	m_world = m_goto
	m_goto = nullptr
	m_world->UpdateLists()
	m_world->BeginWorld()
	m_world->UpdateLists()	
End Sub

Function Engine.AddWorld(world As World Ptr) as WorldPtr TRUEENGINE2D_API_EXPORT
    if world = m_world then return world
    m_goto = world
    world->Grab()
    return world
End Function

Function Engine.GetInstance() As Engine Ptr TRUEENGINE2D_API_EXPORT
	If m_instance = nullptr Then m_instance = New Engine()
	Return m_instance
End Function

Sub Engine.Destroy() TRUEENGINE2D_API_EXPORT
	IrrStop
	Delete m_instance
	m_instance = nullptr
End Sub

Function Engine.GetWorld() As WorldPtr TRUEENGINE2D_API_EXPORT
	Return m_world
End Function
