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
#include "Size.bi"

Type Texture extends ReferenceCounted
    Declare Constructor()
    Declare Destructor()
    Declare Function Load(ByRef path As Const String) As bool
    Declare Const Function GetSize() as Size
    Declare Operator Cast() as UInteger Ptr

Private:
    Declare Constructor(ByRef as Const Texture)
    Declare Operator Let(ByRef as Const Texture)

Public:
    /'internal'/ m_tex As UInteger Ptr
    /'internal'/ m_size as Size
End Type