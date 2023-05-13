function b2od_func {
  param (
    [string]$Dir
  )
  if ($Dir) {
    $WindowsDir = '\' + $Dir
    $UnixDir = '/' + $Dir
  }
  $confirm = Read-Host "This will backup everything in this folder to ${env:UserProfile}\OneDrive${WindowsDir}`n`nAre you sure you want to continue? y/N"
  if ($confirm.ToLower() -eq "y" -or $confirm.ToLower() -eq "yes") {
    wsl rsync -auv --delete ./ /mnt/c/Users/${env:UserName}/OneDrive${UnixDir}
  }
  else {
    Write-Host "Aborting."
  }
}

New-Alias -Name b2od -Value b2od_func
