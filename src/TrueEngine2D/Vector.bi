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

#Macro DECLARE_VECTOR(N_, T_)
#Define VECTOR_NAME Vector##N_
Type Vector##N_
	Declare Constructor(ByVal s As Integer = 0)

	Declare Destructor()
	
	Declare Sub push_back(e As T_)
	
	Declare Function size() As Integer
	
	Declare Function at ( ByVal index As Integer ) byref as T_

Private:
	elem As T_ ptr
	sz As uinteger
End Type
#EndMacro

