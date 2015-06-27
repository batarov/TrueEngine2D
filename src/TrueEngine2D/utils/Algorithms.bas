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

#Include "Algorithms.bi"
#Include "TrueEngine2D/Config.bi"

Sub Sort(a As Integer Ptr, length As Integer, ascending As Integer) TRUEENGINE2D_API_EXPORT
    if length > 1 then 	Quicksort(a, 0, length - 1, ascending)    
End Sub

Sub Quicksort(a As Integer Ptr, left_ As Integer, right_ As Integer, ascending As Integer) TRUEENGINE2D_API_EXPORT
    Var i = left_
    Var j = right_
    Dim t As Integer
    Var p = a[Int((left_ + right_) * .5)]
    If ascending Then        
        while i <= j
            while a[i] < p
                i += 1
            Wend
            while a[j] > p
                j -= 1
            Wend
            if i <= j Then
                t = a[i]
                a[i] = a[j]
                i += 1
                a[j] = t
                j -= 1
            End If            
        Wend
    Else        
        While i <= j        
            While a[i] > p
                i += 1
            Wend
            While a[j] < p
                j -= 1
            Wend
            If i <= j Then
                t = a[i]
                a[i] = a[j]
                i += 1
                a[j] = t
                j -= 1
            End If
        Wend
    EndIf
    If left_ < j Then
        quicksort(a, left_, j, ascending)
    EndIf
    If i < right_ Then
        quicksort(a, i, right_, ascending)
    EndIf
End Sub
