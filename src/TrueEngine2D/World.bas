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

#Include "Debug.bi"

DEFINE_VECTOR(EntityPtr, EntityPtr)
DEFINE_VECTOR(Int, Integer)
DEFINE_MAP(StrEntityPtr, String, EntityPtr)
DEFINE_MAP(StrInt, String, Integer)

Destructor World() TRUEENGINE2D_API_EXPORT
End Destructor

Sub World.Init() TRUEENGINE2D_API_EXPORT
End Sub

Function World.AddEntity(ByVal e As EntityPtr) As EntityPtr TRUEENGINE2D_API_EXPORT
	m_add.push_back(e)
	Return e
End Function

Function World.RemoveEntity(ByVal e As EntityPtr) As EntityPtr TRUEENGINE2D_API_EXPORT
	m_remove.push_back(e)
	Return e
End Function

Sub World.Update() TRUEENGINE2D_API_EXPORT
	' update the entities
	Dim e As EntityPtr = m_updateFirst
	While e <> 0
		e->Update()
		If e->m_graphic <> 0 AndAlso e->m_graphic->active Then e->m_graphic->Update()
		e = e->m_updateNext
	Wend
End Sub

Sub World.Render() TRUEENGINE2D_API_EXPORT
	If m_bg <> 0 Then m_bg->DrawImage(0, 0)
	
	' sort the depth list
	if m_layerSort <> 0 Then 
		
	EndIf

	' render the entities in order of depth
	Dim e As EntityPtr
   Dim i As Integer = m_layerList.length
	While i <> 0
		i -= 1
		e = m_renderLast.at(m_layerList.at(i))
      While e <> 0
      	if e->visible Then e->Render()
         e = e->m_renderPrev
      Wend
	Wend
End Sub

Sub World.SetBackground(ByVal bg as BackgroundPtr) TRUEENGINE2D_API_EXPORT
	m_bg = bg
End Sub

Sub World.BeginWorld() TRUEENGINE2D_API_EXPORT
End Sub

Sub World.EndWorld() TRUEENGINE2D_API_EXPORT
End Sub

Sub World.UpdateLists(ByVal shouldAdd As Byte) TRUEENGINE2D_API_EXPORT
		Dim e As EntityPtr
		Dim index As Integer
		Dim size As Integer
			
		' remove entities
		size = m_remove.length 
		if size > 0 Then
			For i As Integer = 0 To size - 1
				e = m_remove.at(i)
				If e->m_world = 0 Then
					index = m_add.indexOf(e)
					If index >= 0 Then m_add.replace(index, 0)
					Continue	For				
				EndIf
				If e->m_world <> @This Then Continue For
				
				e->Removed()
				e->m_world = 0
				
				RemoveUpdate(e)
				RemoveRender(e)
				If Len(e->m_type) > 0 Then RemoveType(e)
				If Len(e->m_name) > 0 Then UnregisterName(e)
			Next
			m_remove.length = 0
		EndIf
		' add entities
		size = m_add.length
		If shouldAdd <> 0 AndAlso size > 0 Then
			For i As Integer = 0 To size - 1
				e = m_add.at(i)
				If  e->m_world <> 0 Then Continue For
				AddUpdate(e)
				AddRender(e)
				If Len(e->m_type) > 0 Then AddType(e)
				If Len(e->m_name) > 0 Then RegisterName(e)
				
				e->m_world = @this
            e->Added() 
			Next
			m_add.length = 0
		EndIf
End Sub

Sub World.AddUpdate(e As EntityPtr)
	' add to update list
	If m_updateFirst <> 0 Then		
		m_updateFirst->m_updatePrev = e
      e->m_updateNext = m_updateFirst
	Else
		e->m_updateNext = 0
	EndIf
	e->m_updatePrev = 0
	m_updateFirst = e
	m_count += 1
End Sub

Sub World.RemoveUpdate(ByVal e As EntityPtr)
	' remove from the update list
	if m_updateFirst = e Then m_updateFirst = e->m_updateNext
	if e->m_updateNext <> 0 Then e->m_updateNext->m_updatePrev = e->m_updatePrev
	if e->m_updatePrev <> 0 Then e->m_updatePrev->m_updateNext = e->m_updateNext
	e->m_updateNext = 0
	e->m_updatePrev = 0
	m_count -= 1
End Sub

Sub World.AddRender(e As EntityPtr) TRUEENGINE2D_API_EXPORT
	Dim f As EntityPtr = 0
	If e->m_layer < m_renderFirst.length Then f = m_renderFirst.at(e->m_layer)
	If f <> 0 Then
		' Append entity to existing layer.
		e->m_renderNext = f
      f->m_renderPrev = e
      Var count = m_layerCount.at(e->m_layer) + 1
      m_layerCount.replace(e->m_layer, count)
	Else
		' Create new layer with entity.
		If e->m_layer >= m_renderLast.length Then
			m_renderLast.length = e->m_layer + 1 
		EndIf
		m_renderLast.replace(e->m_layer, e)
		m_layerList.push_back(e->m_layer)
		m_layerSort = 1
		e->m_renderNext = 0
		If e->m_layer >= m_layerCount.length Then
			m_layerCount.length = e->m_layer + 1
		EndIf
		m_layerCount.replace(e->m_layer, 1)
	EndIf
	If e->m_layer >= m_renderFirst.length Then
		m_renderFirst.length = e->m_layer + 1
	EndIf
	m_renderFirst.replace(e->m_layer, e)
	e->m_renderPrev = 0
End Sub

Sub World.RemoveRender(ByVal e As EntityPtr) TRUEENGINE2D_API_EXPORT
	If e->m_renderNext <> 0 Then
		e->m_renderNext->m_renderPrev = e->m_renderPrev
	Else
		m_renderLast.replace(e->m_layer, e->m_renderPrev)
	EndIf
	If e->m_renderPrev <> 0 Then
		e->m_renderPrev->m_renderNext = e->m_renderNext
	Else
		' Remove this entity from the layer.
		m_renderFirst.replace(e->m_layer, e->m_renderNext)
		If e->m_renderNext = 0 Then
			' Remove the layer from the layer list if this was the last entity.
			If m_layerList.length > 1 Then
				m_layerList.replace(m_layerList.indexOf(e->m_layer), m_layerList.last())
				m_layerSort = 1
			EndIf
			m_layerList.length = m_layerList.length - 1
		EndIf
	EndIf
	m_layerCount.replace(e->m_layer, m_layerCount.at(e->m_layer) - 1)
	e->m_renderNext = 0 
	e->m_renderPrev = 0
End Sub

Sub World.AddType(e As EntityPtr) TRUEENGINE2D_API_EXPORT
	' add to type list
	Dim f As EntityPtr = m_typeFirst.value(e->m_type, 0) 
	if f <> 0 Then
		f->m_typePrev = e
		e->m_typeNext = f
		m_typeCount.insert(e->m_type, m_typeCount.value(e->m_type, 0) + 1)
	Else
		e->m_typeNext = 0
		m_typeCount.insert(e->m_type, 1)
	EndIf
	e->m_typePrev = 0
 	m_typeFirst.insert(e->m_type, e)
End Sub

Sub World.RemoveType(e As EntityPtr) TRUEENGINE2D_API_EXPORT
	' remove from the type list
	if m_typeFirst.value(e->m_type, 0) = e Then m_typeFirst.insert(e->m_type, e->m_typeNext)
	If e->m_typeNext <> 0 Then e->m_typeNext->m_typePrev = e->m_typePrev
	if e->m_typePrev <> 0 Then e->m_typePrev->m_typeNext = e->m_typeNext
	e->m_typeNext = 0
	e->m_typePrev = 0
	m_typeCount.insert(e->m_type, m_typeCount.value(e->m_type, 1) - 1)
End Sub

Sub World.RegisterName(e As EntityPtr) TRUEENGINE2D_API_EXPORT
	m_entityNames.insert(e->m_name, e)
End Sub

Sub World.UnregisterName(e As EntityPtr) TRUEENGINE2D_API_EXPORT
	if m_entityNames.value(e->m_name, 0) = e Then m_entityNames.remove(e->m_name)
End Sub

Function World.GetFirst() As EntityPtr TRUEENGINE2D_API_EXPORT
	Return m_updateFirst
End Function

Function World.GetTypeFirst(ByRef type_ As Const String) As EntityPtr TRUEENGINE2D_API_EXPORT
	If m_updateFirst = 0 Then Return 0
	Return m_typeFirst.value(type_, 0)
End Function
