#Persistent

; Get the script's directory
scriptDir := A_ScriptDir

; Create GUI
Gui, Add, Text, x10 y10, Folder Path:
Gui, Add, Button, x150 y10 w100 h30 gBrowseFolder, Open Folder
Gui, Add, Edit, x10 y50 w300 h25 vSearchTerm, ; Input for line to find
Gui, Add, Edit, x10 y90 w300 h25 vReplaceTerm, ; Input for new line
Gui, Add, CheckBox, x10 y130 vDeleteLine, Delete Matching Lines
Gui, Add, Button, x10 y170 w100 h30 gProcessFiles, Process Files
Gui, Show, w320 h220, File Processor

; Set the folder path to the script's directory
GuiControl,, FolderPath, % scriptDir

return

BrowseFolder:
    ; Open the folder explorer in the script's directory
    FileSelectFolder, folderPath, % scriptDir, 3, Select Folder
    if (folderPath != "")
    {
        GuiControl,, FolderPath, % folderPath
    }
return

ProcessFiles:
    Gui, Submit ; Get values from input fields
    if (folderPath = "")
    {
        MsgBox, Please select a folder.
        return
    }
    if (SearchTerm = "")
    {
        MsgBox, Please enter the line to find.
        return
    }

    Loop, Files, % folderPath "\*.txt"
    {
        FileRead, fileContent, % A_LoopFileFullPath

        ; Loop through each line in the file
        lines := StrSplit(fileContent, "`n")
        newContent := ""
        
        for index, line in lines
        {
            if InStr(line, SearchTerm) ; Check if the line contains the search term
            {
                if (DeleteLine)
                    continue ; Skip this line (effectively deletes it)
                else
                    newContent .= StrReplace(line, SearchTerm, ReplaceTerm) . "`n" ; Replace the term
            }
            else
                newContent .= line . "`n" ; Keep the line unchanged
        }

        ; Save the modified content back to the file
        FileDelete, % A_LoopFileFullPath
        FileAppend, % newContent, % A_LoopFileFullPath
    }

    MsgBox, Process complete!
return

GuiClose:
    ExitApp
