Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"


# If there's a newer build queued for the same PR, cancel this one

if ($env:APPVEYOR_PULL_REQUEST_NUMBER -and $env:APPVEYOR_BUILD_NUMBER -ne ((Invoke-RestMethod `
        https://ci.appveyor.com/api/projects/$env:APPVEYOR_ACCOUNT_NAME/$env:APPVEYOR_PROJECT_SLUG/history?recordsNumber=50).builds | `
        Where-Object pullRequestId -eq $env:APPVEYOR_PULL_REQUEST_NUMBER)[0].buildNumber) { `
    throw "There are newer queued builds for this pull request, failing early."
}


# Julia

$julia_installers = @{}
$julia_installers.Add('0.7-32bit',     'https://julialang-s3.julialang.org/bin/winnt/x86/0.7/julia-0.7.0-beta2-win32.exe')
$julia_installers.Add('0.7-64bit',     'https://julialang-s3.julialang.org/bin/winnt/x64/0.7/julia-0.7.0-beta2-win64.exe')
$julia_installers.Add('nightly-32bit', 'https://julialangnightlies-s3.julialang.org/bin/winnt/x86/julia-latest-win32.exe')
$julia_installers.Add('nightly-64bit', 'https://julialangnightlies-s3.julialang.org/bin/winnt/x64/julia-latest-win64.exe')

$julia_installer = $julia_installers.Get_Item($env:JULIA)
Start-FileDownload $julia_installer -FileName julia.exe

.\julia.exe /S /D=C:\julia
