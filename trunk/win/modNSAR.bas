Attribute VB_Name = "modNSAR"
' NDStation GUI for Windows v1.3 - package GBA files into NDS files with NDStation
' Copyright (C) 2007 Chaz Schlarp
'
' This program is free software: you can redistribute it and/or modify
' it under the terms of the GNU General Public License as published by
' the Free Software Foundation, either version 2 of the License, or
' (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
' You should have received a copy of the GNU General Public License along
' with this program; if not, write to the Free Software Foundation, Inc.,
' 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.



' NSAR compression
' For an in-depth explanation of this portion of the program:
' http://www.youtube.com/watch?v=oHg5SJYRHA0

Option Explicit

Private Const chunkSize As Long = 131072

Public Sub compressNSAR(inputFile As String, outputFile As String)

    Dim inputHandle As Integer, outputHandle As Integer, tempHandle As Integer
    Dim frameCount As Integer, fileCount As Integer
    
    Dim binDirectory As String
    
    binDirectory = Environ("temp") & "\NDStation"
    
    Call unlink(outputFile)
    
    inputHandle = fopen(inputFile)
    
    ChDrive Left(binDirectory, 2)
    ChDir binDirectory
    
    Do
        frameCount = frameCount + 1
        tempHandle = fopen(binDirectory & "\lzss\uncomp" & frameCount & ".bin")
        Call fwrite(tempHandle, fread(inputHandle, chunkSize))
        Call ShellandWait(binDirectory & "\gbacrusher -l lzss\uncomp" & frameCount & ".bin -o lzss\comp" & frameCount & ".bin")
        Call fclose(tempHandle)
        Call unlink(binDirectory & "\lzss\uncomp" & frameCount & ".bin")
        frmProcessing.lblStep.Caption = "Compressing ROM (" & Trim(Str(Round((frameCount / (filesize(inputFile) / chunkSize)) * 100, 0))) & "%)..."
    Loop Until ftell(inputHandle) >= filesize(inputFile)
    
    Call fclose(inputHandle)
    
    outputHandle = fopen(outputFile)
    Call fwrite(outputHandle, StrConv("NSAR", vbFromUnicode))
    Call fwrite(outputHandle, hex2nds(dec2hex(frameCount)))
    
    Do While fileCount < frameCount
        fileCount = fileCount + 1
        Call fwrite(outputHandle, hex2nds(dec2hex(filesize(binDirectory & "\lzss\comp" & fileCount & ".bin"))))
        tempHandle = fopen(binDirectory & "\lzss\comp" & fileCount & ".bin")
        Call fwrite(outputHandle, fread(tempHandle, filesize(binDirectory & "\lzss\comp" & fileCount & ".bin")))
        Call fclose(tempHandle)
        Call unlink(binDirectory & "\lzss\comp" & fileCount & ".bin")
    Loop
    
    Call fclose(outputHandle)
    
End Sub
