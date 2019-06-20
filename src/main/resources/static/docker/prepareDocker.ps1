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

###################### FUNCTIONS ######################
#Open the servers localhosts
function openwebsites
{
    start http://localhost:6080/ #NVC
    start http://localhost:6081/grid/console #Selenium
}
#Runs a command inside the container that starts the Selenium server (http://localhost:6081/)
function startselenium
{
    Start-Job -Name selenium_job -ScriptBlock {
        docker exec ubulenium java -jar /home/user/Selenium/selenium-server-standalone-3.141.59.jar -role hub;
    }
}

#Starts a node in the selenium hub (http://localhost:6081/grid/console)
function startnode
{
    Start-Job -Name selenium_job -ScriptBlock {
        docker exec ubulenium java "-Dwebdriver.chrome.driver=/home/user/Selenium/chromedriver_linux64.zip" "-Dwebdriver.gecko.driver=/home/user/Selenium/geckodriver-v0.24.0-linux64.tar.gz" -jar /home/user/Selenium/selenium-server-standalone-3.141.59.jar -role node -hub "http://localhost:4444/grid/register"
    }
}

#Stops and removes the container named ubulenium, removes the image named ubuntu-selenium
function stopremovedelete
{
    docker stop (docker ps -aqf "name=ubulenium");
    docker rm (docker ps -aqf "name=ubulenium");
    docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}"|findstr "ubuntu-selenium")
}
#######################################################

if (docker ps | findstr "ubulenium")
{
    #Container is already running
    echo "Container already running"
}
elseif (docker ps -all | findstr "ubulenium")
{
    #Container already exists but it's not running
    docker start ubulenium
    echo "Container started"
    #Start Selenium Server
    startselenium
    #Create a node
    startnode
}
else
{
    #Theres no such container, run one based on the image
    #It will pull itself if it's not locally available

    #Get mapped folders paths (-v option)
    $down_path = "$( pwd )\src\main\resources\static\docker\mapped\Downloads:/home/user/Downloads"
    $desk_path = "$( pwd )\src\main\resources\static\docker\mapped\Desktop:/home/user/Desktop"
    $sele_path = "$( pwd )\src\main\resources\static\docker\mapped\Selenium:/home/user/Selenium"

    #Run ubuntu container
    Start-Job -Name run_job -ScriptBlock {
        docker run --privileged -p 6080:80 -p 6081:4444 -v $args[0] -v $args[1] -v $args[2] -e TZ=Europe/Madrid --name ubulenium bernattt/ubuntu-selenium:v2 date
    } -ArgumentList @($down_path, $desk_path, $sele_path);
    #'docker run' output
    $run_output = Receive-Job -Name run_job 6>&1;
    #Wait until output of 'docker run' command says success (container started)
    while (-Not($run_output -like '*success*'))
    {
        Start-Sleep -s 2;
        $run_output = Receive-Job -Name run_job 6>&1;
    }

    echo "Container started from the image"
    #Start Selenium Server
    startselenium
    #Create a node
    startnode
}
