#Start Docker if it's not running
$Prog = "C:\Program Files\Docker\Docker\Docker for Windows.exe"
$Running = Get-Process 'Docker for Windows' -ErrorAction SilentlyContinue
$Start = { ([wmiclass]"win32_process").Create($Prog) }
if ($Running -eq $null)
{
    Write-Output "Starting Docker..."
    & $Start
    Start-Sleep -s 60
    Write-Output "Docker started"
}

#Get mapped folders (-v option)
$down_path="$(pwd)\src\main\resources\static\docker\mapped\Downloads:/home/user/Downloads"
$desk_path="$(pwd)\src\main\resources\static\docker\mapped\Desktop:/home/user/Desktop"

#Run container if it's not running
#It will pull itself it's not locally available
If (-Not(docker ps | findstr "bernattt/ubuntubernat"))
{
    docker run --rm --privileged -p 6080:80 --name ubuntubernat -v $down_path -v $desk_path bernattt/ubuntubernat
}