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

#Macro DECLARE_PAIR(N_, T1_, T2_)
Type Pair##N_
	Declare Constructor()
	
	Declare Constructor(ByRef value1 As Const T1_, ByRef value2 As Const T2_)

	first As T1_
	second As T2_
End Type

Declare Operator = (ByRef lhs As Pair##N_, ByRef rhs As Pair##N_) As Integer
#EndMacro

#Macro DEFINE_PAIR(N_, T1_, T2_)
Constructor Pair##N_() TRUEENGINE2D_API_EXPORT
End Constructor

Constructor Pair##N_(ByRef value1 As Const T1_, ByRef value2 As Const T2_) TRUEENGINE2D_API_EXPORT
	first = value1
	second = value2
End Constructor

Operator = (ByRef lhs As Pair##N_, ByRef rhs As Pair##N_) As Integer TRUEENGINE2D_API_EXPORT
	If lhs.first = rhs.first AndAlso lhs.second = rhs.second Then Return 1
	Return 0 
End Operator
#EndMacro