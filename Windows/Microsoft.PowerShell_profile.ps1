# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
function subl { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }



# setup ssh
Import-Module Posh-SSH.psd1

# Aliases
if (!(test-path alias:grep)) { new-alias grep findstr }
if (!(test-path alias:ssh)) { new-alias ssh new-sshsession }

# Import-Module oh-my-posh
# Set-Theme -name 'paradox'
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression

# test for ssh service
$sshService = Get-Service -Name ssh-agent -ErrorAction SilentlyContinue
if ($sshService -eq $null) {
	Write-Host "OpenSSH agent is not installed"
}
else {
	# make sure it will start automatically
	if ($sshService.StartType -ne "Automatic") {
		Write-Host "SSH agent is not set to automatically start"
		Write-Host "Run the following from an elevated prompt: Get-Service ssh-agent | Set-Service -StartupType Automatic"		
	}
	if ($sshService.Status -ne "Running") {
		Write-Host "SSH agent is not running"
		Write-Host "Run the following from an elevated prompt: Start-Service ssh-agent"
	} else {
		Write-Host "SSH Agent is running"
	}	
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


