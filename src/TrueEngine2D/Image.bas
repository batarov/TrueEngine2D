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

#Include "Image.bi"
#include "Config.bi"

Constructor Image() TRUEENGINE2D_API_EXPORT
	base()
	m_alpha = 1
	m_width = -1
	m_height = -1
End Constructor

Sub Image.Render(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
	DrawImage(x, y)
End Sub

Sub Image.DrawImage(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
	DrawImage(x, y, 0, 0, m_width, m_height)
End Sub

Sub Image.DrawImage(ByVal x As Integer, ByVal y As Integer, subrectX As Integer, subrectY As Integer, subrectW As Integer, subrectH As Integer) TRUEENGINE2D_API_EXPORT
	IrrDraw2DImageElement(*m_tex, x, y, subrectX, subrectY, subrectX + subrectW, subrectY + subrectH, m_alpha)
End Sub

Sub Image.DrawImage(ByVal x As Integer, ByVal y As Integer, scaleX As Single, scaleY As Single) TRUEENGINE2D_API_EXPORT
	IrrDraw2DImageElementStretch(*m_tex, x, y, x + m_width * scaleX, y + m_height * scaleY, 0, 0, m_width, m_height, m_alpha)
End Sub

Sub Image.SetWidth(w as Integer) TRUEENGINE2D_API_EXPORT
	m_width = w
End Sub

Sub Image.SetHeight(h as Integer) TRUEENGINE2D_API_EXPORT
	m_height = h
End Sub

Sub Image.SetAlpha(flag as Byte) TRUEENGINE2D_API_EXPORT
	m_alpha = flag
End Sub