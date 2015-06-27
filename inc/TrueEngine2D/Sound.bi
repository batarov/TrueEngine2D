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

Type FSOUND_SAMPLEPtr As FSOUND_SAMPLE Ptr
Type FSOUND_STREAMPtr As FSOUND_STREAM Ptr

Type Sound extends ReferenceCounted
    Declare Constructor()
    
    Declare Destructor()
    
    Declare Function Load(ByVal Filename as String) As Byte
    
    Declare Function Play(ByVal ch As Long = -1) As Long
    
    Declare Sub Stop(ByVal ch As Long)
    
    Declare Sub SetLoop(ByVal flag As Byte)
    
Private:
    Static m_init As Byte
    Union
        m_sample As FSOUND_SAMPLEPtr
        m_stream As FSOUND_STREAMPtr
    End Union
    m_loop As Byte
    m_streaming As Byte = 0
End Type
