validate_user_permission() {
  if [ $(id -u) -ne 0 ] ; then
    echo  "Please run as root"
    exit 1
  fi
}

remove_images() {
  docker rmi -f resultadosdigitais/rd-atom
  docker rmi -f resultadosdigitais/rd-atom:v2
  docker rmi -f rd-atom
}

delete_executable() {
  rm -f /usr/local/bin/rd-atom
}

validate_user_permission
remove_images
delete_executable
