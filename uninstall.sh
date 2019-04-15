validate_user_permission() {
  if [ $(id -u) -ne 0 ] ; then
    echo  "Please run as root"
    exit 1
  fi
}

remove_images() {
  docker rmi -f resultadosdigitais/datom
  docker rmi -f resultadosdigitais/datom:v2
  docker rmi -f datom
}

remove_volume() {
  docker volume rm datom
}

delete_executable() {
  rm -f /usr/local/bin/datom
}

validate_user_permission
remove_images
remove_volume
delete_executable
