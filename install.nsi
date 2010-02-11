!include MUI.nsh
Name "ChaosConnect"
OutFile "install.exe"
RequestExecutionLevel admin

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Section "ChaosConnect"
    SetShellVarContext all
    # executables
    SetOutPath "$INSTDIR"
    File chaosconnect\ChaosConnect.exe
    WriteUninstaller "uninstall.exe"

    # driver files
    SetOutPath "$INSTDIR\driver"
    File drivers\libusb0.sys
    File drivers\libusb0_x64.sys
    File drivers\libusb0.dll
    File drivers\libusb0_x64.dll
    File drivers\chaos.inf
    File drivers\chaos.cat
    File drivers\chaos_x64.cat
    
    # Add/Remove Programs Entry
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ChaosConnect" \
                 "DisplayName" "ChaosConnect"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ChaosConnect" \
                 "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ChaosConnect" \
                 "Publisher" "Taylor University"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ChaosConnect" \
                 "DisplayIcon" "$\"$INSTDIR\ChaosConnect.exe$\""
                 
SectionEnd
                 
Section "Start Menu Shortcuts"
    SetShellVarContext all
    #start menu shortcuts
    createShortCut "$SMPROGRAMS\ChaosConnect\ChaosConnect.lnk" "$\"$INSTDIR\ChaosConnect.exe$\""
SectionEnd

Section "Uninstall"
    SetShellVarContext all
    #executables
    Delete "$INSTDIR\ChaosConnect.exe"
    Delete "$INSTDIR\uninstall.exe"
    
    #driver files
    Delete "$INSTDIR\driver\libusb0.sys"
    Delete "$INSTDIR\driver\libusb0_x64.sys"
    Delete "$INSTDIR\driver\libusb0.dll"
    Delete "$INSTDIR\driver\libusb0_x64.dll"
    Delete "$INSTDIR\driver\chaos.inf"
    Delete "$INSTDIR\driver\chaos.cat"
    Delete "$INSTDIR\driver\chaos_x64.cat"
    Delete "$INSTDIR\driver\*.*"
    
    #start menu shortcuts
    Delete "$SMPROGRAMS\ChaosConnect\ChaosConnect.lnk"
    
    #directories
    RMDir "$SMPROGRAMS\ChaosConnect"
    RMDir "$INSTDIR\driver"
    RMDir "$INSTDIR"
    
    # Add/Remove Programs Entry
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ChaosConnect"
SectionEnd