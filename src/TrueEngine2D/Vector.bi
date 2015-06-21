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
 
#Macro DECLARE_VECTOR(N_, T_)
Type Vector##N_
	Declare Constructor(ByVal s As Integer = 0)

	Declare Destructor()
	
	Declare Sub push_back(ByRef e As Const T_)
	
	Declare Function size() As Integer
	
	Declare Function at (ByVal index As Integer) ByRef As T_
	
	Declare Function indexOf(ByRef e As Const T_) As Integer
	
	Declare Property length(ByVal value As UInteger)
	
	Declare Property length() As UInteger
	
	Declare Sub replace(ByVal i As Integer, ByVal value As T_)
	
	Declare Function last() ByRef As T_
	
	Declare Sub remove(ByVal i As UInteger)
	
	Declare Sub remove (ByVal i As UInteger, ByVal count_ As UInteger)

    Declare Function data() as T_ Ptr
	
Private:
	elem As T_ Ptr = 0
	sz As UInteger
	m_capacity As UInteger
End Type
#EndMacro

#Macro DEFINE_VECTOR(N_, T_)
Constructor Vector##N_(s As Integer) TRUEENGINE2D_API_EXPORT
	If s > 0 Then elem = New T_[s]
	sz = s
	m_capacity = sz
End Constructor

Destructor Vector##N_() TRUEENGINE2D_API_EXPORT
	Delete[] elem
End Destructor

Function Vector##N_.size() As Integer TRUEENGINE2D_API_EXPORT
	Return sz
End Function

Sub Vector##N_.push_back(ByRef e As Const T_) TRUEENGINE2D_API_EXPORT
	length = sz + 1
	elem[sz + 1] = e
End Sub

Function Vector##N_.at(ByVal index As Integer) ByRef As T_ TRUEENGINE2D_API_EXPORT
        return elem[index]
End Function

Function Vector##N_.indexOf(ByRef e As Const T_) As Integer TRUEENGINE2D_API_EXPORT
	For i As Integer = 0 To sz - 1
		If elem[i] = e Then Return i
	Next
	Return -1
End Function

Property Vector##N_.length(ByVal value As UInteger) TRUEENGINE2D_API_EXPORT
	If value = sz OrElse value < 0 Then Return
	If value = 0 Then
		Delete[] elem
		elem = 0
		sz = 0
		m_capacity = size
	ElseIf value < sz OrElse value <= m_capacity Then
		sz = value
	Else
		Dim As T_ Ptr buf = New T_[value]
		For i As Integer = 0 To sz - 1
			buf[i] = elem[i]	
		Next
		Delete[] elem
		elem = buf
		sz = value
		m_capacity = size
	EndIf
End Property

Property Vector##N_.length() As UInteger TRUEENGINE2D_API_EXPORT
	Return sz
End Property

Sub Vector##N_.replace(ByVal i As Integer, ByVal value As T_) TRUEENGINE2D_API_EXPORT
	elem[i] = value
End Sub

Function Vector##N_.last() ByRef As T_ TRUEENGINE2D_API_EXPORT
	Return elem[sz - 1]
End Function

Sub Vector##N_.remove(ByVal i As UInteger) TRUEENGINE2D_API_EXPORT
	remove(i, 1)
End Sub

Sub Vector##N_.remove(ByVal i As UInteger, ByVal count_ As UInteger) TRUEENGINE2D_API_EXPORT
	Var j = i + count_
	While j < sz - 1
		elem[i] = elem[j]
		i += 1
		j += 1
	Wend
	sz -= count_
End Sub

Function Vector##N_.data() as T_ Ptr TRUEENGINE2D_API_EXPORT
    Return elem
End Function
#EndMacro
