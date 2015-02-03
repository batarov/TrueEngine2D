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

#include "WorldSim3d.bi"

#Include "Config.bi"
#Include "World.bi"
#Include "Input.bi"
#Include "Background.bi"

Dim Engine.m_instance As Engine Ptr = 0

Dim Shared key_down As UInteger

Function keyboard_check_pressed(key As uinteger) As Byte TRUEENGINE2D_API_EXPORT
	If key <> key_down Then
		Return 0
	Else
		Return 1
	EndIf
End Function

Constructor Engine() TRUEENGINE2D_API_EXPORT
	m_world = New World
End Constructor

Destructor Engine() TRUEENGINE2D_API_EXPORT

End Destructor

Sub Engine.SetFrameRate(ByVal frameRate As Single) TRUEENGINE2D_API_EXPORT
	Print "Engine.SetFrameRate"
	Print m_frameRate
End Sub

Sub Engine.Init(ByVal w As UInteger, ByVal h As UInteger, ByVal frameRate As Single) TRUEENGINE2D_API_EXPORT
	Print "Engine.init"
	wStart( wDT_OPENGL, w, h, wBITS_PER_PIXEL_32, wWINDOWED, wNO_SHADOWS, wCAPTURE_EVENTS, wVERTICAL_SYNC_ON )
	m_frameRate = frameRate
	m_width = w
	m_height = h
End Sub

Sub Engine.StartMainLoop() TRUEENGINE2D_API_EXPORT
	While wRunning And m_ShutdownRequested <> 1
		Dim KeyEvent As wKEY_EVENT Ptr
		If wKeyEventAvailable Then
    		KeyEvent = wReadKeyEvent
    		If KeyEvent->direction = wKEY_DOWN Then
    			key_down = KeyEvent->key
    		EndIf
		EndIf
		
		While wMouseEventAvailable
			Dim ev As wMOUSE_EVENT Ptr = wReadMouseEvent
			If ev->action = wME_LMOUSE_PRESSED_DOWN _
				Or ev->action = wME_RMOUSE_PRESSED_DOWN _
				Or ev->action = wME_MMOUSE_PRESSED_DOWN Then
				utils.Input.onMouseDown()
			ElseIf ev->action = wME_LMOUSE_LEFT_UP _
				Or ev->action = wME_RMOUSE_LEFT_UP _
				Or ev->action = wME_MMOUSE_LEFT_UP Then
				utils.Input.onMouseUp()
			EndIf
		Wend
		
		Update()
		
		utils.Input.Update()
		
		wBeginScene( 0,0,0 )
		Render()
		wEndScene
		wSetFPS(m_frameRate)
	Wend
End Sub

Sub Engine.StopMainLoop() TRUEENGINE2D_API_EXPORT
	m_ShutdownRequested = 1
End Sub

Sub Engine.Update() TRUEENGINE2D_API_EXPORT
	m_world->Update()
End Sub

Sub Engine.Render() TRUEENGINE2D_API_EXPORT
	m_world->Render()
End Sub

Sub Engine.CheckWorld() TRUEENGINE2D_API_EXPORT
	
End Sub

Sub Engine.AddWorld(world As World Ptr) TRUEENGINE2D_API_EXPORT
	m_world = world
	m_world->Init()
End Sub

Function Engine.GetInstance() As Engine Ptr TRUEENGINE2D_API_EXPORT
	If m_instance = 0 Then m_instance = New Engine()
	Return m_instance
End Function

Sub Engine.Destroy() TRUEENGINE2D_API_EXPORT
	wStop
	Delete m_instance
	m_instance = 0
End Sub

#include "Input.bas"
#include "Graphic.bas"
#include "Image.bas"
#include "Background.bas"