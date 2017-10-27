validate_user_permission() {
  if [ $(id -u) -ne 0 ] ; then
    echo  "Please run as root"
    exit 1
  fi
}

build_image() {
  docker build -t rd-atom .
}

install_executable() {
  chmod +x rd-atom
  cp rd-atom /usr/local/bin/
}

validate_user_permission
build_image
install_executable
