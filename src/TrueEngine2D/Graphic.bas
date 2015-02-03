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

#Include "Graphic.bi"
#Include "Config.bi"

Constructor Graphic() TRUEENGINE2D_API_EXPORT
	m_tex = New wTexture
End Constructor

Destructor Graphic() TRUEENGINE2D_API_EXPORT
	Delete m_tex
End Destructor

Sub Graphic.Release() TRUEENGINE2D_API_EXPORT
	If m_tex <> 0 Then
		wRemoveTexture(Cast(wTexture, *m_tex))
		Delete m_tex
	EndIf
End Sub

Sub Graphic.Load(byval path as zstring Ptr) TRUEENGINE2D_API_EXPORT
	*m_tex = wGetTexture(path)
End Sub
