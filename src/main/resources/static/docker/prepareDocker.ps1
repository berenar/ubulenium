$downloads="${pwd}/src/main/resources/static/docker/mapped/Downloads"
$desktop="${pwd}/src/main/resources/static/docker/mapped/Desktop"

$downloads
$desktop

If(-Not(docker ps | findstr "bernattt/ubuntubernat")){
docker run --rm --privileged -p 6080:80 --name ubuntubernat -v \${downloads}:/home/user/Downloads -v ${desktop}:/home/user/Desktop bernattt/ubuntubernat
}