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

#Pragma once

#Include "Vector.bi"
Type EntityPtr As Entity ptr
DECLARE_VECTOR(EntityPtr, EntityPtr)

Type Background_t As Background

Type World extends object
	
	Declare Sub Update()
	Declare virtual Destructor()
	
	Declare Function AddEntity(ByVal e As EntityPtr) As EntityPtr
	Declare virtual Sub Init()
	
	Declare Sub SetBackground(byval path as zstring Ptr, ByVal w As Integer, ByVal h As Integer)
	
	Declare Sub Render()
	visible As Byte
	
	m_updateList As VectorEntityPtr
Private:
	m_bg As Background_t ptr
End Type
