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

Type FSOUND_SAMPLEPtr As FSOUND_SAMPLE Ptr

Type Sound extends object
	Declare Constructor()
	
	Declare Destructor()
	
	Declare Function Load(ByVal Filename as String) As Byte
	
	Declare Sub Release()
	
	Declare Sub Play()
	
	Declare Sub setLoop(ByVal flag As Byte)
	
Private:
	Static m_init As Byte
	as Integer hWave,hSound
	m_snd As FSOUND_SAMPLEPtr
	m_loop As Byte
End Type
