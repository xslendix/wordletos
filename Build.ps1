#!/usr/bin/env pwsh

param ([bool]$zeal=$false)

if ($env:ZEAL = 'ON') {
    $zeal = $true
}

Write-Output 'INFO: Copying original source files'

Remove-Item generated -Recurse -ErrorAction Ignore -Force
Copy-Item -Path src -Destination generated -Recurse -Force

Write-Output 'INFO: Generating code'

Write-Output 'INFO: Patching code'

Get-ChildItem generated -Recurse -Include *.HC | 
Select-Object -Expand fullname |
ForEach-Object {
    ((Get-Content $_) -Replace '\(\);',';' -Replace '\/\/.*' -Replace "(?m)^\s*`r`n",'' -Replace ', +',',' -Replace '; +',';' -Replace ' +$').trim() -match '\S' | Set-Content $_
}

if ( $zeal ) {
    Get-ChildItem -Recurse generated/*.HC | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "ZC") }
    Move-Item generated/PaletteZeal.ZC generated/Palette.ZC -Force

    Get-ChildItem generated -Recurse -Include *.ZC | 
    Select-Object -Expand fullname |
    ForEach-Object {
        (Get-Content $_) -Replace 'DirMk','DirMake' -Replace 'StrCmp','StrCompare' -Replace 'GetKey','KeyGet' | Set-Content $_
    }
} else {
    Remove-Item generated/*.ZC
}

Write-Output 'INFO: Creating CD image'

if ( $zeal ) {
    if ( $IsLinux ) {
        ./RedSeaGen generated/ wordle_zeal.ISO.C
    } else {
        .\RedSeaGen.exe generated\ wordle_zeal.ISO.C
    }

    if (Test-Path -Path 'wordle_zeal.ISO.C' -PathType Leaf) {
        Write-Output 'INFO: ISO generated succesfully.'
    } else {
        Write-Warning 'ISO NOT GENERATED!'
    }
} else {
    if ( $IsLinux ) {
        ./RedSeaGen generated/ tos/wordle.ISO.C
    } else {
        .\RedSeaGen.exe generated\ tos\wordle.ISO.C
    }

    if (Test-Path -Path ([IO.Path]::Combine($PSScriptRoot, 'tos', 'wordle.ISO.C')) -PathType Leaf) {
        Write-Output 'INFO: ISO.C generated succesfully inside the `tos` directory.'
    
        # TODO: Port tos.sh to pwsh
        if ($IsLinux) {
            $decision = $Host.UI.PromptForChoice('Run VM', 'Do you wish to run a VM?', ('&Yes', '&No'), 0)
            if ( $decision -eq 0 ) {
                Set-Location ([IO.Path]::Combine($PSScriptRoot, 'tos'))
                ./tos.sh run
                Set-Location $PSScriptRoot
            }
        }
    } else {
        Write-Warning 'ISO.C NOT GENERATED!'
    }
}


Write-Output "INFO: Done!"
