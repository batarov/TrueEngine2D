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

Type GraphicPtr As Graphic Ptr
Type FontPtr as Font Ptr

Namespace utils
    Enum
        AlignLeft   =   1
        AlignRight  =   2
        AlignTop    =   3
        AlignBottom =   4
        AlignCenter =   5
    End Enum
    
    Type Draw extends Object
        Declare Static Sub Graphic(ByVal g As GraphicPtr, ByVal x As Integer = 0, ByVal y As Integer = 0)
        Declare Static Sub SetAlpha(ByVal a As ULong)
        Declare Static Sub SetColor(ByVal r As ULong, ByVal g As ULong, ByVal b As ULong)
        Declare Static Sub SetColor(ByVal col As ULong)
        Declare Static Sub SetHAlign(ByVal flag As Integer)
        Declare Static Sub SetVAlign(ByVal flag As Integer)
        Declare Static Sub SetFont(ByVal font As FontPtr)
        Declare Static Sub Text(ByVal x As Integer, ByVal y As Integer, ByRef text_ As Const WString)
        declare static sub RectColor(byval x1 as single, byval y1 as single, _
                                     byval x2 as single, byval y2 as single, _
                                     byval col1 as ulong, byval col2 as ulong, _
                                     byval col3 as ulong, byval col4 as ulong)

    Private:
        Static m_font as FontPtr
        Static m_halign as Integer
        Static m_valign as Integer
    End Type
End Namespace
