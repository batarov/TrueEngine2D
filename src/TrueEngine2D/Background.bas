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

#Include once "Background.bi"
#Include "Config.bi"

Sub Background.DrawImage(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
	IrrDraw2DImageElementStretch(*m_tex, 0, 0, m_width, m_height, 0, 0, m_width, m_height, IRR_ON)
End Sub

Sub Background.SetWidth(ByVal w As Integer) TRUEENGINE2D_API_EXPORT
	m_width = w
End Sub

Sub Background.SetHeight(ByVal h As Integer) TRUEENGINE2D_API_EXPORT
	m_height = h
End Sub

Sub Background.Render(ByVal x As Integer, ByVal y As Integer) TRUEENGINE2D_API_EXPORT
	DrawImage(x, y)
End Sub
