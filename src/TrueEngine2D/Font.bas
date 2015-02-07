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

type FontPrivate
	fnt as irr_font
end type

constructor Font() TRUEENGINE2D_API_EXPORT
	m_d = new FontPrivate
end constructor

destructor Font() TRUEENGINE2D_API_EXPORT
	delete m_d
end destructor

sub Font.Load(byval path as zstring ptr) TRUEENGINE2D_API_EXPORT
	m_d->fnt =  IrrGetFont(path)
end sub

sub Font.DrawText(byval x as integer, byval y as integer, byval width_ as integer, byval height_ as integer, byval text as wstring ptr) TRUEENGINE2D_API_EXPORT
	Irr2DFontDraw(m_d->fnt, text, x, y, x + width_, y + height_)
end sub
