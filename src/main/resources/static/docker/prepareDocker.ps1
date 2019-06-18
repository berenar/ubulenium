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

#Get mapped folders paths (-v option)
$down_path = "$( pwd )\src\main\resources\static\docker\mapped\Downloads:/home/user/Downloads"
$desk_path = "$( pwd )\src\main\resources\static\docker\mapped\Desktop:/home/user/Desktop"

#Run container if it's not running
#It will pull itself if it's not locally available
If (-Not(docker ps | findstr "bernattt/ubuntubernat"))
{
    #Run ubuntu container
    Start-Job -Name run_job -ScriptBlock {docker run --privileged -p 6080:80 -p 6081:4444 --name ubuntubernat -v $args[0] -v $args[1] bernattt/ubuntubernat:v1 } -ArgumentList @($down_path,$desk_path);
    #'docker run' output
    $run_output = Receive-Job -Name run_job 6>&1;
    #Wait until output of 'docker run' command says success (container started)
    while (-Not($run_output -like '*success*'))
    {
        Start-Sleep -s 2;
        $run_output = Receive-Job -Name run_job 6>&1;
    }
    #Start Selenium Server
    docker exec ubuntubernat java -jar /home/user/Selenium/selenium-server-standalone-3.141.59.jar -role hub;
}