Attribute VB_Name = "Module1"
Option Explicit

'1�}�C�N���b�Ԃɑ�����J�E���g�����擾����
Declare PtrSafe Function QueryPerformanceFrequency Lib "kernel32" (ByRef freq As LongLong) As Long
'�V�X�e�����N�����Ă���̃J�E���g�����擾����
Declare PtrSafe Function QueryPerformanceCounter Lib "kernel32" (ByRef procTime As LongLong) As Long

Public freq As LongLong

Public TimerStart As Double
Public TimerStop As Double

Public Record As Boolean
Public flag As Boolean

Function GetMicroSecond(ByVal freq As LongLong) As Double
    
    Dim procTime As LongLong
    
    '�O�̂��ߏ�����
    GetMicroSecond = 0
    
    '�J�E���g�����u1�}�C�N���b�Ԃɑ�����J�E���g���v�Ŋ��邱�ƂŃ}�C�N���b���擾�ł���
    Call QueryPerformanceCounter(procTime)
    GetMicroSecond = procTime / freq
    
End Function

Sub Main()
    
    TimerStart = 0
    TimerStop = 0
    
    Record = False
    flag = False
    
    QueryPerformanceFrequency freq

    UserForm1.Show
    
    Do While flag = False
    
        If Record = True Then
            Do While Record = True
                UserForm1.Label1.Caption = translate(GetMicroSecond(freq) - TimerStart)
                DoEvents
            Loop
            
            UserForm1.Label1.Caption = translate(TimerStop - TimerStart)
            
            TimerStart = 0
            TimerStop = 0
            
        End If
        
        DoEvents
    Loop
        
End Sub

Function translate(ByVal temp As Double) As String
    Dim h As Long
    Dim m As Long
    Dim s As Long
    Dim ms As Long
    
    h = Application.WorksheetFunction.RoundDown(Application.WorksheetFunction.RoundDown(temp, 0) / 60 / 60, 0)
    m = Application.WorksheetFunction.RoundDown((Application.WorksheetFunction.RoundDown(temp, 0) - (h * 60 * 60)) / 60, 0)
    s = Application.WorksheetFunction.RoundDown(temp, 0) - (h * 60 * 60) - (m * 60)
    ms = (temp - Application.WorksheetFunction.RoundDown(temp, 0)) * 10000
    
    translate = Right("0" & CStr(h), 2) & ":" & Right("0" & CStr(m), 2) & ":" & Right("0" & CStr(s), 2) & "." & Right("000" & CStr(ms), 4)
    
End Function
