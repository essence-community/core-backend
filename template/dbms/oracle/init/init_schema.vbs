Const ForReading = 1
Const ForWriting = 2

Dim currDir, WshShell, sUser, sPw, connectionPreBd, connectionBd, sMetaUser, sMetaPw, connectionMetaBd, newDataBase, newSchema, commadLiquibase

set WshShell = WScript.CreateObject("WScript.Shell")

Set fso = CreateObject("Scripting.FileSystemObject")
currDir = fso.GetParentFolderName(Wscript.ScriptFullName)

WshShell.CurrentDirectory = currDir

If fso.FileExists(currDir & "\liquibase.init.properties") Then
    commadLiquibase = "cd " & currDir & "\.. && gradlew.bat update -PrunList=init"

    set WshExec = WshShell.Exec(commadLiquibase)
    Set TextStream = WshExec.StdOut
    While Not TextStream.AtEndOfStream
        WScript.StdOut.Write TextStream.ReadLine() & vbCrLf
    Wend
    WScript.Quit 0
End If

WScript.StdOut.Write "Connection(jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=LOCALHOST)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=NAME)))): "
connectionPreBd = WScript.StdIn.ReadLine

If Len(connectionPreBd) = 0 Then
    WScript.StdOut.Write "Error empty Connection"
    WScript.Quit 1
End if

WScript.StdOut.Write "Superadmin User (s_su): "
sUser = WScript.StdIn.ReadLine

If Len(sUser) = 0 Then
    sUser = "s_su"
End if

WScript.StdOut.Write "Superadmin Password (s_su): "
sPw = WScript.StdIn.ReadLine

If Len(sPw) = 0 Then
    sPw = "s_su"
End if

WScript.StdOut.Write "Connection Meta(jdbc:postgresql://127.0.0.1:5432/core): "
connectionMetaBd = WScript.StdIn.ReadLine

If Len(connectionMetaBd) = 0 Then
    connectionMetaBd = "jdbc:postgresql://127.0.0.1:5432/core"
End if

WScript.StdOut.Write "Superadmin Meta User (s_su): "
sMetaUser = WScript.StdIn.ReadLine

If Len(sMetaUser) = 0 Then
    sMetaUser = "s_su"
End if

WScript.StdOut.Write "Superadmin Meta Password (s_su): "
sMetaPw = WScript.StdIn.ReadLine

If Len(sMetaPw) = 0 Then
    sMetaPw = "s_su"
End if

WScript.StdOut.Write "Prefix Schema: "
newSchema = WScript.StdIn.ReadLine

If Len(newSchema) = 0 Then
    WScript.StdOut.Write "Error empty prefix Schema"
    WScript.Quit 1
End if

newSchema = UCase(newSchema)

Function ReplaceSchema(strFileName)
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objFile = objFSO.OpenTextFile(strFileName, ForReading)
    strText = objFile.ReadAll
    objFile.Close

    strNewText = Replace(strText, "#user.update#", newSchema & "P")
    strNewText = Replace(strNewText, "#user.table#", newSchema & "T")
    strNewText = Replace(strNewText, "#user.connect#", newSchema & "C")
    strNewText = Replace(strNewText, "#user.prefix#", newSchema)
    strNewText = Replace(strNewText, "#user.admin#", sUser)
    strNewText = Replace(strNewText, "#schemaConnection#", connectionPreBd)
    strNewText = Replace(strNewText, "#schemaConnectionAdmin#", sUser)
    strNewText = Replace(strNewText, "#schemaConnectionAdminPw#", sPw)
    strNewText = Replace(strNewText, "#metaConnection#", connectionMetaBd)
    strNewText = Replace(strNewText, "#metaConnectionAdmin#", sMetaUser)
    strNewText = Replace(strNewText, "#metaConnectionAdminPw#", sMetaPw)
    Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
    objFile.Write strNewText
    objFile.Close
End Function

ReplaceSchema(currDir & "\db.sql")
ReplaceSchema(currDir & "\db.changelog.init.xml")

commadLiquibase = "cd " & currDir & "\.. && gradlew.bat update -PrunList=init -Pliquibase.username=#schemaConnectionAdmin# -Pliquibase.password=#schemaConnectionAdminPw# -Pliquibase.url=""#schemaConnection#"" -Pliquibase.driver=oracle.jdbc.OracleDriver"
commadLiquibase = Replace(commadLiquibase, "#schemaConnection#", connectionPreBd)
commadLiquibase = Replace(commadLiquibase, "#schemaConnectionAdmin#", sUser)
commadLiquibase = Replace(commadLiquibase, "#schemaConnectionAdminPw#", sPw)
set WshExec = WshShell.Exec(commadLiquibase)
Set TextStream = WshExec.StdOut
While Not TextStream.AtEndOfStream
    WScript.StdOut.Write TextStream.ReadLine() & vbCrLf
Wend

ReplaceSchema(currDir & "\..\db.changelog.meta.xml")
ReplaceSchema(currDir & "\..\db.changelog.schema.xml")
ReplaceSchema(currDir & "\..\liquibase.meta.properties")
ReplaceSchema(currDir & "\..\liquibase.schema.properties")

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile( currDir & "\liquibase.init.properties", True)
objFile.WriteLine "driver: oracle.jdbc.OracleDriver"
objFile.WriteLine "url: " & connectionPreBd
objFile.WriteLine "username: " & sUser
objFile.WriteLine "password: " & sPw
objFile.Close