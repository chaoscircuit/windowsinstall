!include MUI.nsh
!include x64.nsh

Name "ChaosConnect"

OutFile "install.exe"
InstallDir "$PROGRAMFILES\ChaosConnect"

SetCompressor /SOLID lzma

RequestExecutionLevel admin

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Section "ChaosConnect"
    SectionIn RO

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
    File drivers\dpinst.exe
    File drivers\dpinst_x64.exe
    
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
    createDirectory "$SMPROGRAMS\ChaosConnect\"
    createShortCut "$SMPROGRAMS\ChaosConnect\ChaosConnect.lnk" "$INSTDIR\ChaosConnect.exe"
SectionEnd

Section "Run Driver Installation"
    SetShellVarContext all
    # run driver installation
    ${If} ${RunningX64}
        DetailPrint "Installing 64 bit drivers"
        Exec "$INSTDIR\driver\dpinst_x64.exe /lm /sw"
    ${Else}
        DetailPrint "Installing 32 bit drivers"
        Exec "$INSTDIR\driver\dpinst.exe /lm /sw"
    ${EndIf}
    
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
    Delete "$INSTDIR\driver\dpinst.exe"
    Delete "$INSTDIR\driver\dpinst_x64.exe"
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