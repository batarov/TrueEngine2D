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

#Include "ReferenceCounted.bi"
#Include "Vector.bi"
#Include Once "Map.bi"

Type EntityT As Entity
Type EntityPtr As Entity Ptr

DECLARE_VECTOR(EntityPtr, EntityPtr)
DECLARE_VECTOR(Int, Integer)
DECLARE_MAP(StrEntityPtr, String, EntityPtr)
DECLARE_MAP(StrInt, String, Integer)

Type BackgroundPtr As Background ptr

Type BackgroundEntity
    bg As BackgroundPtr = nullptr
    x As Long = 0
    y As Long = 0
    htiled As bool = false
    vtiled As bool = false
    hspeed As Single = 0.0
    vspeed As Single = 0.0
End Type

Type World extends ReferenceCounted
    ' If the Render() loop is performed.
    visible As bool = true
    
    Declare Constructor()
    Declare Virtual Destructor()
    
    '
    ' Override this; called when World is switch to, and set to the currently active world.
    '
    Declare Virtual Sub BeginWorld()
        
    '
    ' Override this; called when World is changed, and the active world is no longer this.
    '
    Declare Virtual Sub EndWorld()
    
    '
    ' Performed by the game loop, updates all contained Entities.
    '
    Declare Virtual Sub Update()
    
    '
    ' Performed by the game loop, renders all contained Entities.
    '
    Declare Virtual Sub Render()

    '
    ' Adds the Entity to the World at the end of the frame.
    ' @param        e           Entity object you want to add.
    ' @return                   The added Entity object.
    '
    Declare Function AddEntity(ByVal e As EntityPtr) As EntityPtr
    
    '
    ' Removes the Entity from the World at the end of the frame.
    ' @param        e           Entity object you want to remove.
    ' @return                   The removed Entity object.
    '
    Declare Function RemoveEntity(ByVal e As EntityPtr) As EntityPtr
    
    '
    ' The first Entity in the World.
    '
    Declare Function GetFirst() As EntityPtr
    
    '
    ' The first Entity of the type.
    ' @param        type        The type to check.
    ' @return                   The Entity.
    '
    Declare Function GetTypeFirst(ByRef type_ As Const String) As EntityPtr

    '
    ' How many Entities are in the World.
    '   
    Declare Property count() As UInteger
   
    '
    ' Returns the amount of Entities of the type are in the World.
    ' @param        type        The type (or Class type) to count.
    ' @return                   How many Entities of type exist in the World.
    '
    Declare Function GetTypeCount(ByRef type_ As String) As UInteger
    
    '
    ' Updates the add/remove lists at the end of the frame.
    ' @param        shouldAdd   If false, entities will not be added
    '                           to the world, only removed.
    '

    Declare Sub UpdateLists(ByVal shouldAdd As bool = true)
    
    Declare Virtual Sub Init()
        
    Declare Sub SetBackground(ByVal bg as BackgroundPtr)
    
    Declare Sub SetBackgroundX(ByVal x As Long)
    
    Declare Sub SetBackgroundY(ByVal y As Long)
    
    Declare Sub SetBackgroundScaleX(ByVal xscale As Single)
    
    Declare Sub SetBackgroundScaleY(ByVal yscale As Single)
    
    Declare Sub SetBackgroundHSpeed(ByVal hspeed As Single)
    
    Declare Sub SetBackgroundVSpeed(ByVal vspeed As Single)

    Declare Sub SetBackgroundScrollSpeed(ByVal hspeed As Single, ByVal vspeed As Single)
    
    ' Removes Entity from the render list.
    Declare Sub RemoveRender(ByVal e As EntityPtr)

    
    ' Adds Entity to the render list.
    /' Internal '/ Declare Sub AddRender(e As EntityPtr)    
    
    ' Adds Entity to the type list.
    /' Internal '/ Declare Sub AddType(e As EntityPtr)
    
    ' Removes Entity from the type list.
    /' Internal '/ Declare Sub RemoveType(e As EntityPtr)
    
    ' Register's the Entity's instance name.
    /' Internal '/ Declare Sub RegisterName(e As EntityPtr)
    
    ' Unregister's the Entity's instance name.
    /' Internal '/ Declare Sub UnregisterName(e As EntityPtr)
        
Private:
    Declare Constructor(ByRef As const World)
    Declare operator Let(ByRef As const World)

    ' Adds Entity to the update list.
    Declare Sub AddUpdate(ByVale As EntityPtr)
    
    ' Removes Entity from the update list.
    Declare Sub RemoveUpdate(ByVal e As EntityPtr)

Private:
    m_bg as BackgroundEntity
    
    ' Adding and removal.
    m_add as VectorEntityPtr
    m_remove as VectorEntityPtr

    ' Update information.
    m_updateFirst as EntityPtr
    m_count as UInteger
    
    ' Render information.
    m_renderFirst As VectorEntityPtr
    m_renderLast As VectorEntityPtr
    m_layerList As VectorInt
    m_layerCount As VectorInt
    m_layerSort As bool = false
Public:
    /' Internal '/ m_typeFirst As MapStrEntityPtr
    /' Internal '/ m_entityNames As MapStrEntityPtr
Private:
    m_typeCount As MapStrInt
End Type
