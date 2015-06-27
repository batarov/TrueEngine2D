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

#Include "TrueEngine2D/Graphic.bi"
#include "TrueEngine2D/Texture.bi"

Type ImageImplPtr As ImageImpl Ptr

Type Image extends Graphic
    '
    ' Rotation of the image, in degrees.
    '
    Declare Property angle(value As Single)
    Declare Property angle() As Single
    
    '
    ' Scale of the image, affects both x and y scale.
    '
    scale As Single = 1

    '
    ' X scale of the image.
    '
    scaleX As Single = 1
    
    '
    ' Y scale of the image.
    '
    scaleY As Single = 1
    
    '
    ' X origin of the image, determines transformation point.
    ' Defaults to top-left corner.
    '
    Declare Property originX(x As Single)
    
    ' Y origin of the image, determines transformation point.
    ' Defaults to top-left corner.
    '
    Declare Property originY(y As Single)
    
    Declare Constructor(ByVal tex As Texture Ptr)

    Declare Destructor()
    
    Declare Virtual Sub Render(ByVal x As Integer, ByVal y As Integer)
    
    Declare Sub SetAlpha(flag as Byte)

    Declare Sub SetScaledWidth(w as Integer)

    Declare Sub SetScaledHeight(h as Integer)

    '
    ' Center's the Image's origin (half width & height).
    '
    Declare Sub CenterOrigin()
    
    '
    ' The scaled width of the image.
    '
    Declare Const Property ScaledWidth() As Single
    
    '
    ' The scaled height of the image.
    '
    Declare Const Property ScaledHeight() As Single
    
Protected:
    m_width as Integer
    m_height as Integer
    m_alpha as Byte = 1
    m_angle As Single = 0
    m_originX As Single = 0
    m_originY As Single = 0
    
    m_impl As ImageImplPtr
End Type
