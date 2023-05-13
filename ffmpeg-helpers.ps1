function resize_func {
  param (
    [Parameter(Mandatory=$true)]
    [int]$Size,
    [Parameter(Mandatory=$true)]
    [string]$File
  )
  $datetime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
  $output = $File -replace "\.(?=[^.]*$)", "_${Size}x_${datetime}."
  ffmpeg -i $File -vf "scale=${Size}:-1:flags=neighbor,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" $output
}

New-Alias -Name resize -Value resize_func

function darken_func {
  param (
    [Parameter(Mandatory=$true)]
    [string]$File,
    [int]$Sat = 3,
    [float]$Bright = 0.1
  )
  $datetime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
  $output = $File -replace "\.(?=[^.]*$)", "_sat${Sat}_bright${Bright}_${datetime}."
  ffmpeg -i $File -vf "eq=saturation=${Sat}:brightness=-${Bright},split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" $output
}

New-Alias -Name darken -Value darken_func
