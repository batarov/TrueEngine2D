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

#Include "Sound.bi"
#Include "Config.bi"

#Include once "fmod.bi"

Function init_sound() As Byte
	If (FSOUND_Init(44100, 4, 0) = 0) Then
		Print "Could not initialize FMOD"
		Return 0
	EndIf
	Return 1
End Function

Dim Sound.m_init As Byte = 0

Constructor Sound() TRUEENGINE2D_API_EXPORT
	If m_init = 0 Then m_init = init_sound()
End Constructor

Destructor Sound() TRUEENGINE2D_API_EXPORT
	
End Destructor

Function Sound.Load(byval Filename as String) As Byte export
	m_snd = FSOUND_Sample_Load(FSOUND_FREE, Filename, 0, 0, 0)
	If m_snd = 0 Then
		Print "FMOD could not load '" & Filename & "'"
		Return 0 
	EndIf
	
	Return 1
End Function

Sub Sound.Release() TRUEENGINE2D_API_EXPORT
	FSOUND_Sample_Free(m_snd)
	m_snd = 0
End Sub

Sub Sound.Play() TRUEENGINE2D_API_EXPORT
	If m_loop <> 0 Then FSOUND_Sample_SetMode(m_snd, FSOUND_LOOP_NORMAL)
	FSOUND_PlaySound(FSOUND_FREE, m_snd)
End Sub

Sub Sound.setLoop(ByVal flag As Byte) TRUEENGINE2D_API_EXPORT
	m_loop = flag
End Sub
