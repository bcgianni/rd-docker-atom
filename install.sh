validate_user_permission() {
  if [ $(id -u) -ne 0 ] ; then
    echo  "Please run as root"
    exit 1
  fi
}

build_image() {
  docker build -t datom .
}

install_executable() {
  chmod +x datom
  cp datom /usr/local/bin/
}

validate_user_permission
build_image
install_executable
