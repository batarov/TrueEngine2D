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

#Include "World.bi"
#Include "Config.bi"
#Include "Entity.bi"
#Include "Background.bi"
#Include "Vector.bas"

DEFINE_VECTOR(EntityPtr, EntityPtr)

Destructor World() TRUEENGINE2D_API_EXPORT
End Destructor

Sub World.Init() TRUEENGINE2D_API_EXPORT
End Sub

Function World.AddEntity(ByVal e As EntityPtr) As EntityPtr TRUEENGINE2D_API_EXPORT
	m_updateList.push_back(e)
	e->setWorld(@this)
	Return e
End Function

Sub World.Update() TRUEENGINE2D_API_EXPORT
	For i As Integer = 0 To m_updateList.size() - 1
		m_updateList.at(i)->Update()
	Next
End Sub

Sub World.Render() TRUEENGINE2D_API_EXPORT
	If m_bg <> 0 Then m_bg->DrawImage(0, 0)
	For i As Integer = 0 To m_updateList.size() - 1
		m_updateList.at(i)->Render()
	Next
End Sub

Sub World.SetBackground(ByVal bg as BackgroundPtr) TRUEENGINE2D_API_EXPORT
	m_bg = bg
End Sub
