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

#pragma once

#Include "ReferenceCounted.bi"
#Include "Size.bi"

Type FontPrivatePtr As FontPrivate Ptr

Type Font extends ReferenceCounted
    Declare Constructor()
    
    Declare Destructor()

    Declare Function Load(ByVal path As ZString Ptr) As bool

    Declare Sub DrawText(ByVal x As Integer, ByVal y As Integer, ByVal width_ As Integer, ByVal height_ as integer, ByRef text As Const WString)
    
    Declare Function GetSize(ByRef text As Const WString) As Size 

Private:
    m_d As FontPrivatePtr
End Type