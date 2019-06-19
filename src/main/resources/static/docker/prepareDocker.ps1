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
#Log file path
$log_path = "C:\Users\" + $uname + "\AppData\Local\Docker\log.txt"
#Last log tells us if it has finished booting up everything
$started = Get-Content $log_path | Select-String -Pattern 'Docker Desktop is running' -CaseSensitive -SimpleMatch
while ($started -eq $null)
{
    echo "..."
    #Wait 5 more seconds
    Start-Sleep -s 5
    $started = Get-Content $log_path | Select-String -Pattern 'Docker Desktop is running' -CaseSensitive -SimpleMatch
}
echo "Docker is ready"

###################################################################################################################
############################################ Run Container and wait ###############################################
###################################################################################################################
#Open the servers localhosts
function openwebsites
{
    start http://localhost:6080 #NVC
    start http://localhost:6081 #Selenium
}
#Runs a command inside the container that starts the Selenium server
function startselenium
{
    docker exec ubuntubernat java -jar /home/user/Selenium/selenium-server-standalone-3.141.59.jar -role hub;
}

if (docker ps | findstr "ubuntubernat")
{
    #Container is already running
    echo "Container already running"
    openwebsites
}
elseif (docker ps -all | findstr "ubuntubernat")
{
    #Container already exists but it's not running
    docker start ubuntubernat
    echo "Container started"
    openwebsites
    #Start Selenium Server
    startselenium
}
else
{
    #Theres no such container, run one based on the image
    #It will pull itself if it's not locally available

    #Get mapped folders paths (-v option)
    $down_path = "$( pwd )\src\main\resources\static\docker\mapped\Downloads:/home/user/Downloads"
    $desk_path = "$( pwd )\src\main\resources\static\docker\mapped\Desktop:/home/user/Desktop"

    #Run ubuntu container
    Start-Job -Name run_job -ScriptBlock {
        docker run --privileged -p 6080:80 -p 6081:4444 --name ubuntubernat -v $args[0] -v $args[1] bernattt/ubuntubernat:v1
    } -ArgumentList @($down_path, $desk_path);
    #'docker run' output
    $run_output = Receive-Job -Name run_job 6>&1;
    #Wait until output of 'docker run' command says success (container started)
    while (-Not($run_output -like '*success*'))
    {
        Start-Sleep -s 2;
        $run_output = Receive-Job -Name run_job 6>&1;
    }
    echo "Container started from the image"
    openwebsites
    #Start Selenium Server
    startselenium
}
