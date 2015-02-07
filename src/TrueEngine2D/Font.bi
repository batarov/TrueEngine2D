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

type FontPrivatePtr as FontPrivate ptr

type Font
	declare constructor()
	
	declare destructor()

	declare sub Load(byval path as zstring ptr)

	declare sub DrawText(byval x as integer, byval y as integer, byval width_ as integer, byval height_ as integer, byval text as wstring ptr)

private:
	m_d as FontPrivatePtr
end type