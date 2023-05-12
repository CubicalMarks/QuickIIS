function QuickIIS {
    param (
        # Path
        [Parameter(
            Mandatory = $false
        )]
        [ValidateScript({
            if (-Not (Test-Path $_ -PathType Container)) {
                throw "Invalid path"
            }
            return $true
        })]
        [System.IO.FileInfo] $Path = $(Get-Location).ToString(),
        # Port number
        [Parameter(
            Mandatory = $false
        )]
        [int] $Port = 8080
    )
    $Path = (Resolve-Path $Path).ToString().TrimEnd('\')
    $OriginalTitle = $host.UI.RawUI.WindowTitle

    Write-Host "IIS Express Dev Server"
    Write-Host "----------------------"
    Write-Host "Path: $Path"
    Write-Host "Port: $Port"

    $IisArgs = "/path:`"$Path`" /port:$Port"
    try {
        Start-Process -FilePath "iisexpress.exe" -ArgumentList $IisArgs -WorkingDirectory $Path -NoNewWindow -PassThru | Wait-Process
    }
    finally {
        $host.UI.RawUI.WindowTitle = $OriginalTitle
    }
}

Export-ModuleMember QuickIIS
