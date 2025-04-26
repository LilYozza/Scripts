#Persistent

scriptDir := A_ScriptDir

Gui, Add, Text, x10 y10, Folder Path:
Gui, Add, Button, x150 y10 w100 h30 gBrowseFolder, Open Folder
Gui, Add, Edit, x10 y50 w300 h25 vSearchTerm, ; Input for line to find
Gui, Add, Edit, x10 y90 w300 h25 vReplaceTerm, ; Input for new line
Gui, Add, CheckBox, x10 y130 vDeleteLine, Delete Matching Lines
Gui, Add, CheckBox, x150 y130 vInsertMode, Insert into Matching Lines
Gui, Add, Edit, x10 y170 w145 h25 vInsertLineNum, Line Number to Insert At
Gui, Add, Edit, x165 y170 w145 h25 vInsertLineText, Line to Insert
Gui, Add, Button, x10 y210 w100 h30 gProcessFiles, Process Files
Gui, Show, w320 h260, File Processor

GuiControl,, FolderPath, % scriptDir
return

BrowseFolder:
FileSelectFolder, folderPath, % scriptDir, 3, Select Folder
if (folderPath != "")
    GuiControl,, FolderPath, % folderPath
return

ProcessFiles:
Gui, Submit

if (folderPath = "") {
    MsgBox, Please select a folder.
    return
}

Loop, Files, % folderPath "\*.txt"
{
    FileRead, fileContent, % A_LoopFileFullPath
    lines := StrSplit(fileContent, "`n")
    newContent := ""

    ; If InsertLineNum and InsertLineText provided, do insert-at-line-number
    if (InsertLineNum != "" && InsertLineText != "")
    {
        InsertAt := InsertLineNum + 0
        loopCount := lines.Length()
        Loop % loopCount + 1
        {
            if (A_Index = InsertAt)
                newContent .= InsertLineText . "`n"
            if (A_Index <= loopCount)
                newContent .= lines[A_Index] . "`n"
        }
    }
    else
    {
        for index, line in lines
        {
            if InStr(line, SearchTerm)
            {
                if (DeleteLine)
                    continue
                else if (InsertMode)
                    newContent .= line . ReplaceTerm . "`n"
                else
                    newContent .= StrReplace(line, SearchTerm, ReplaceTerm) . "`n"
            }
            else
                newContent .= line . "`n"
        }
    }

    FileDelete, % A_LoopFileFullPath
    FileAppend, % newContent, % A_LoopFileFullPath
}

ExitApp
return

GuiClose:
ExitApp
