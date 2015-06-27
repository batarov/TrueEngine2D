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
    If (FSOUND_Init(44100, 128, 0) = 0) Then
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
    If m_streaming <> 0 Then
        FSOUND_Stream_Close(m_stream)
        m_stream = 0
    Else
        FSOUND_Sample_Free(m_sample)
        m_sample = 0
    EndIf
End Destructor

Function Sound.Load(ByVal Filename as String) As Byte Export
    Var ext = LCase(Right(Filename, 4))
    If ext = ".wav" Then 
        m_sample = FSOUND_Sample_Load(FSOUND_FREE, Filename, 0, 0, 0)
        If m_sample = 0 Then
            Print "FMOD could not load '" & Filename & "'"
            Return 0 
        EndIf
    ElseIf ext = ".ogg" OrElse ext = ".mp3" Then
        m_stream = FSOUND_Stream_Open(Filename, 0, 0, 0)
        m_streaming = -1
        If m_stream = 0 Then
            Print "FMOD could not load '" & Filename & "'"
            Return 0 
        EndIf
    EndIf   
    
    Print "Loaded sound: " + fileName    
    Return 1
End Function

Function Sound.Play(ByVal ch As Long = -1) As Long TRUEENGINE2D_API_EXPORT
    If m_streaming <> 0 Then
        Return FSOUND_Stream_Play(FSOUND_FREE, m_stream)
    Else
        If ch <> -1 AndAlso FSOUND_IsPlaying(ch) <> 0 Then
            Return ch
        Else
            Return FSOUND_PlaySound(FSOUND_FREE, m_sample)
        EndIf        
    EndIf
End Function

Sub Sound.Stop(ByVal ch As Long) TRUEENGINE2D_API_EXPORT
    If m_streaming <> 0 Then
        FSOUND_Stream_Stop(m_stream)
    Else
        FSOUND_StopSound(ch)
    EndIf
End Sub

Sub Sound.SetLoop(ByVal flag As Byte) TRUEENGINE2D_API_EXPORT
    m_loop = flag
    If m_loop <> 0 Then
        If m_streaming <> 0 Then
            FSOUND_Stream_SetMode(m_stream, FSOUND_LOOP_NORMAL)
        Else
            FSOUND_Sample_SetMode(m_sample, FSOUND_LOOP_NORMAL)
        EndIf   
    Else
        If m_streaming <> 0 Then
            FSOUND_Stream_SetMode(m_stream, FSOUND_LOOP_OFF)
        Else
            FSOUND_Sample_SetMode(m_sample, FSOUND_LOOP_OFF)
        EndIf
    EndIf
End Sub
