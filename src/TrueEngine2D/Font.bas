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


#include "Font.bi"
#include "Config.bi"

#include once "IrrlichtWrapper.bi"

type FontPrivate
    fnt as irr_font
end type

constructor Font() TRUEENGINE2D_API_EXPORT
    m_d = new FontPrivate
end constructor

destructor Font() TRUEENGINE2D_API_EXPORT
    delete m_d
end destructor

Function Font.Load(ByVal path As zstring ptr) As bool TRUEENGINE2D_API_EXPORT
    m_d->fnt = IrrGetFont(path)
    Return m_d->fnt <> nullptr
End Function

sub Font.DrawText(ByVal x As Integer, ByVal y As Integer, byval width_ as integer, byval height_ as integer, ByRef text As Const WString) TRUEENGINE2D_API_EXPORT
    Irr2DFontDraw(m_d->fnt, @text, x, y, x + width_, y + height_)
end sub

Function Font.GetSize(ByRef text As Const WString) As Size TRUEENGINE2D_API_EXPORT
    Dim sz As Size
    IrrFontGetDimension(m_d->fnt, @text, sz.width, sz.height)
    Return sz
End Function
