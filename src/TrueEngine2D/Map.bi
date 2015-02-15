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
#Include "Pair.bi"

#Macro DECLARE_MAP(N_, KEY_, T_)
DECLARE_PAIR(N_, KEY_, T_)
DECLARE_VECTOR(Pair##N_, Pair##N_)

Type Map##N_
	Declare Constructor()
	
	Declare Sub insert(key As KEY_, value_ As T_)
	
	Declare Function remove(ByRef key As Const KEY_) As Integer
	
	Declare Function value(ByRef key As Const KEY_, ByRef defaultValue As const T_) As Const T_ 	

Private:
	m_d As VectorPair##N_
	sz As uinteger
End Type
#EndMacro


#Macro DEFINE_MAP(N_, KEY_, T_)
DEFINE_PAIR(N_, KEY_, T_)
DEFINE_VECTOR(Pair##N_, Pair##N_)

Constructor Map##N_() TRUEENGINE2D_API_EXPORT
	sz = 0
End Constructor

Sub Map##N_.insert(key As KEY_,  value_ As T_) TRUEENGINE2D_API_EXPORT
	Var size = m_d.length - 1
	For i As Integer = 0 To size
		If m_d.at(i).first = key Then
			m_d.at(i).second = value_
			Return
		EndIf
	Next
	m_d.length = m_d.length + 1
	size = m_d.length - 1
	m_d.at(size).first = key
	m_d.at(size).second = value_
End Sub
	
Function Map##N_.remove(ByRef key As Const KEY_) As Integer TRUEENGINE2D_API_EXPORT
	Var size = m_d.length - 1
	For i As Integer = 0 To size
		If m_d.at(i).first = key Then
			m_d.remove(i)
			Return 1 
		EndIf
	Next
	Return 0
End Function
	
Function Map##N_.value(ByRef key As Const KEY_, ByRef defaultValue As const T_) As Const T_ TRUEENGINE2D_API_EXPORT
	Var size = m_d.length - 1
	For i As Integer = 0 To size
		If m_d.at(i).first = key Then Return m_d.at(i).second 
	Next
	Return defaultValue
End Function
#EndMacro