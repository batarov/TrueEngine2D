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

#Macro DEFINE_VECTOR(N_, T_)
Constructor Vector##N_(s As Integer) TRUEENGINE2D_API_EXPORT
	If s > 0 Then elem = New T_[s]
	sz = s
End Constructor

Destructor Vector##N_() TRUEENGINE2D_API_EXPORT
	Delete[] elem
End Destructor

Function Vector##N_.size() As Integer TRUEENGINE2D_API_EXPORT
	Return sz
End Function

Sub Vector##N_.push_back(e As T_)
	Dim As T_ Ptr buf = New T_[sz+1]
	For i As Integer = 0 To sz-1
		buf[i] = elem[i]	
	Next
	Delete[] elem
	elem = buf
	elem[sz] = e
	sz += 1
End Sub

Function Vector##N_.at( ByVal index As Integer ) ByRef As T_ TRUEENGINE2D_API_EXPORT
        return elem[index]
End Function
#EndMacro

