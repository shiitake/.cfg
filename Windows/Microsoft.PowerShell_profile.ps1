# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
function subl { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }



# setup ssh
Import-Module Posh-SSH.psd1

# Aliases
$grep = get-alias -name grep
if ($grep.count -lt 1) { new-alias grep findstr }
$ssh = get-alias -name ssh
if ($ssh.count -lt 1) { new-alias ssh new-sshsession }

Import-Module oh-my-posh
Set-Theme -name 'paradox'


# Start-SshAgent
$SSHAgentPid = Get-SSHAgent
Write-Host "Agent PID: $SSHAgentPid"
if ($SSHAgentPid -eq 0) {
  Start-SshAgent
}
else {
  Write-Host "Agent already started"
}



function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host

    # Reset color, which can be messed up by Enable-GitColors
    $defaultForegroundColor = $GitPromptSettings.DefaultForegroundColor
    if ($defaultForegroundColor -ne $null)
    {
        $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
    }
    

    if (Test-Administrator) {  # Use different username if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    Write-Host "$ENV:USERNAME@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta

    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host $($(Get-Location) -replace "C:\\Users\\shannon", "~") -NoNewline -ForegroundColor Blue
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus

    Write-Host ""

    return "> "
}


