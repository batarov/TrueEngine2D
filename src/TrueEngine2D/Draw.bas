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

#Include "Draw.bi"
#Include "Config.bi"
#Include "Graphic.bi"
		
Sub utils.Draw.Graphic(ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer, g As GraphicPtr, ByVal sx As Integer, ByVal sy As Integer, ByVal sw As Integer, ByVal sh As Integer, ByVal useAlpha As Byte) TRUEENGINE2D_API_EXPORT
	IrrDraw2DImageElementStretch(*g->m_tex, x, y, x + w, y + h, sx, sy, sx + sw, sy + sh, useAlpha)
End Sub
