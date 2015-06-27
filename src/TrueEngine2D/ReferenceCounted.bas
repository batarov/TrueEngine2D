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

#Include "ReferenceCounted.bi"
#Include "Config.bi"

Constructor ReferenceCounted() TRUEENGINE2D_API_EXPORT
End Constructor

Destructor ReferenceCounted() TRUEENGINE2D_API_EXPORT
End Destructor

Const Sub ReferenceCounted.Grab() TRUEENGINE2D_API_EXPORT
	*Cast(Integer Ptr, @m_referenceCounter) += 1
End Sub
    
Const Function ReferenceCounted.Drop() As bool TRUEENGINE2D_API_EXPORT
	*Cast(Integer Ptr, @m_referenceCounter) -= 1 
    If m_referenceCounter = 0 Then
    	Delete Cast(ReferenceCounted Ptr, @this)
    	Return true
    End If    
    Return false
End Function
    
Const Function ReferenceCounted.GetReferenceCount() As Integer TRUEENGINE2D_API_EXPORT
    Return m_referenceCounter
End Function
