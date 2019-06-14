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

#Get mapped folders
$downloads = "${pwd}/src/main/resources/static/docker/mapped/Downloads"
$desktop = "${pwd}/src/main/resources/static/docker/mapped/Desktop"
$downloads
$desktop

#Run container if it's not running
If (-Not(docker ps | findstr "bernattt/ubuntubernat"))
{
    docker run --rm --privileged -p 6080:80 --name ubuntubernat -v ${downloads}:/home/user/Downloads -v ${desktop}:/home/user/Desktop bernattt/ubuntubernat
}