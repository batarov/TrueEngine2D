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

#Include "crt/mem.bi"

Type Matrix    
    Declare Sub BuildProjectionMatrixOrthoLH(ByVal widthOfViewVolume As Single, _
                                             ByVal heightOfViewVolume As Single, _
                                             ByVal zNear As Single, zFar As Single)
    
    Declare Sub SetTranslation(ByVal x As Single, ByVal y As Single, ByVal z As Single)
    
    Declare Sub MakeIdentity()
    
    Declare Operator [] (ByRef i As Integer) ByRef As Single
    Declare Operator Cast() As Single Ptr
    
Private:
    m_m(15) As Single => {1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1}
End Type


Private Sub Matrix.BuildProjectionMatrixOrthoLH(ByVal widthOfViewVolume As Single, _
                                        ByVal heightOfViewVolume As Single, _
                                        ByVal zNear As Single, zFar As Single)
    m_m(0) = (2 / widthOfViewVolume)
    m_m(5) = (2 / heightOfViewVolume)
    m_m(10) = 1 / (zFar - zNear)
    m_m(14) = zNear / (zNear - zFar)          
End Sub

Private Sub Matrix.SetTranslation(ByVal x As Single, ByVal y As Single, ByVal z As Single)
    m_m(12) = x
	m_m(13) = y
    m_m(14) = z
End Sub
                                              
Private Sub Matrix.MakeIdentity()
    memset(@m_m(0), 0, 16*SizeOf(Single))
    m_m(0) = 1
    m_m(5) = 1
    m_m(10) = 1
    m_m(15) = 1    
End Sub

Private Operator Matrix.[] (ByRef i As Integer) ByRef As Single
    Return m_m(i)
End Operator

Private Operator Matrix.Cast() As Single Ptr
    Return @m_m(0)
End Operator
