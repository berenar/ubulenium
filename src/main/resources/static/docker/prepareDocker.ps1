###################################################################################################################
############################################## Run Docker and wait ################################################
###################################################################################################################
#Path of docker executable
$Prog = "C:\Program Files\Docker\Docker\Docker for Windows.exe"
#Command that starts it
$Start = { ([wmiclass]"win32_process").Create($Prog) }
#To know if it's running
$Running = Get-Process 'Docker for Windows' -ErrorAction SilentlyContinue
#Start it if it's not running
if ($Running -eq $null)
{
    echo "Docker starting ..."
    echo "_______________________________"
    & $Start
    echo "_______________________________"
    #Wait 5 seconds to let Docker configure log files
    Start-Sleep -s 5
}
#Get user username
$uname = [Environment]::UserName;
#Docker log file path
$log_path = "C:\Users\" + $uname + "\AppData\Local\Docker\log.txt"
if ($uname -eq '')
{
    echo "Couldn't get username from Enviroment variable"
    echo "Please verify that writing [Environment]::UserName in powershell returns your username"
    Break Script
}
elseif (-Not(Test-Path $log_path -PathType Leaf))
{
    echo "Could't get Docker log file: "+ $log_path
    echo "Please verify that C:\Users\<YOUR_USERNAME>\AppData\Local\Docker\log.txt exists"
    Break Script
}
#Last log tells us if it has finished booting up everything
$started = Get-Content $log_path | Select-String -Pattern 'Docker Desktop is running' -CaseSensitive -SimpleMatch
#Wait until Docker starts
while ($started -eq $null)
{
    echo "..."
    #Wait 5 more seconds
    Start-Sleep -s 5
    $started = Get-Content $log_path | Select-String -Pattern 'Docker Desktop is running' -SimpleMatch
}
echo "Docker is ready"

###################################################################################################################
############################################ Run Container and wait ###############################################
###################################################################################################################

###################### FUNCTIONS ######################
#Open the servers localhosts
function openwebsites
{
    start http://localhost:6081/grid/console #Selenium
    start http://localhost:6080/#/ #NVC
}


#######################################################

if (docker ps | findstr "ubulenium")
{
    #Container is already running
    echo "Container already running"
}
elseif (docker ps -a | findstr "ubulenium")
{
    #Container already exists but it's not running
    docker start ubulenium
    openwebsites
    echo "Container started"
}
else
{
    #Theres no such container, run one based on the image
    #It will pull itself if it's not locally available

    #Get mapped folder path (-v option doesn't relative paths)
    $sele_path = "$( pwd )\src\main\resources\static\docker\mapped\Selenium:/home/user/Selenium"

    #Run ubuntu container
    #NOTE: 'vx' is the last version (tag) avaliable
    Start-Job -Name run_job -ScriptBlock {
        docker run --privileged `
        -p 6080:80 -p 6081:4444 `
        -v $args[0] `
        -e TZ=Europe/Madrid `
        --name ubulenium bernattt/ubuntu-selenium:v3 `
    } -ArgumentList @($sele_path);
    #'docker run' output
    $run_output = Receive-Job -Name run_job 6>&1;
    #Wait until output of 'docker run' command says success (container started)
    while (-Not($run_output -like '*success*'))
    {
        Start-Sleep -s 2;
        $run_output = Receive-Job -Name run_job 6>&1;
    }
    openwebsites
    echo "Container started from the image"
}
