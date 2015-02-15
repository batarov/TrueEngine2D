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

#include "IrrlichtWrapper.bi"

#Include "Config.bi"
#Include "World.bi"
#Include "Input.bi"
#Include "Background.bi"

Dim Engine.m_instance As Engine Ptr = 0

Constructor Engine() TRUEENGINE2D_API_EXPORT
	m_world = New World
End Constructor

Destructor Engine() TRUEENGINE2D_API_EXPORT

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
	if m_goto <> 0 Then CheckWorld()
	
	' fixed framerate
	m_rate = 1000 / m_frameRate
	m_skip = m_rate * (maxFrameSkip + 1)
	m_last = IrrGetTime()
	m_prev = m_last
	
	Dim As Integer dt, t0
	Dim As Single fTime, fDeltaTime
	t0 = IrrGetTime()
	fTime = 0
	While IrrRunning And m_ShutdownRequested <> 1
		While IrrKeyEventAvailable
				Dim KeyEvent As IRR_KEY_EVENT Ptr = IrrReadKeyEvent
    			If KeyEvent->direction = IRR_KEY_DOWN Then
					utils.Input.OnKeyDown(KeyEvent)
    			ElseIf KeyEvent->direction = IRR_KEY_UP Then
					utils.Input.OnKeyUp(KeyEvent)
    			EndIf
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
			EndIf
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
			if paused = 0 Then Update()
			
			' update input
			utils.Input.Update()
			
			' update timer
 			m_time = IrrGetTime()
		Wend				
		
		' render loop
		if paused = 0 Then
			IrrBeginScene( 0,0,0 )
			Render()
			IrrEndScene
		EndIf
	Wend
End Sub

Sub Engine.StopMainLoop() TRUEENGINE2D_API_EXPORT
	m_ShutdownRequested = 1
End Sub

Sub Engine.Update() TRUEENGINE2D_API_EXPORT
	m_world->UpdateLists()
 	if m_goto <> 0 Then CheckWorld()
   m_world->Update()
   m_world->UpdateLists(0)
End Sub

Sub Engine.Render() TRUEENGINE2D_API_EXPORT
	m_world->Render()
End Sub

Sub Engine.CheckWorld() TRUEENGINE2D_API_EXPORT
	If m_goto = 0 Then Return
	m_world->EndWorld()
	m_world->UpdateLists() 
	m_world = m_goto
	m_goto = 0
	m_world->UpdateLists()
	m_world->BeginWorld()
	m_world->UpdateLists()	
End Sub

Function Engine.AddWorld(world As World Ptr) as WorldPtr TRUEENGINE2D_API_EXPORT
	m_goto = world 
	return world
End Function

Function Engine.GetInstance() As Engine Ptr TRUEENGINE2D_API_EXPORT
	If m_instance = 0 Then m_instance = New Engine()
	Return m_instance
End Function

Sub Engine.Destroy() TRUEENGINE2D_API_EXPORT
	IrrStop
	Delete m_instance
	m_instance = 0
End Sub

Function Engine.GetWorld() As WorldPtr TRUEENGINE2D_API_EXPORT
	Return m_world
End Function

#include "Input.bas"
#include "Graphic.bas"
#include "Image.bas"
#include "Background.bas"
#include "Font.bas"