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

#Include "Texture.bi"
#include "Config.bi"

#include once "IrrlichtWrapper.bi"

Constructor Texture() TRUEENGINE2D_API_EXPORT
End Constructor

Destructor Texture() TRUEENGINE2D_API_EXPORT
	If m_tex <> nullptr Then
        IrrRemoveTexture(m_tex)
    End If
End Destructor

Function Texture.Load(ByRef path As Const String) As bool TRUEENGINE2D_API_EXPORT
    If m_tex <> nullptr Then
        IrrRemoveTexture(m_tex)
    End If
#Ifdef __FB_WIN32__
    Dim ustr as WString ptr = Allocate((len(path) + 1) * sizeof(wstring))
    *ustr = WStr(path)
	m_tex = IrrGetTexture(ustr)
    Deallocate(ustr)
#Else
	m_tex = IrrGetTexture(StrPtr(path))
#EndIf
	If m_tex <> nullptr Then
		Dim imagePitch as UInteger
		Dim imageFormat as IRR_COLOR_FORMAT
		IrrGetTextureInformation(m_tex, m_size.width, m_size.height, imagePitch, imageFormat)
        Return true
	End If
	Return false
End Function

Const Function Texture.GetSize() as Size
    Return m_size
End Function

Operator Texture.Cast() as UInteger Ptr
    return m_tex
End Operator