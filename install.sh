BIN_PATH="/usr/local/bin/rd-atom"
DOWNLOAD_URL="https://raw.githubusercontent.com/ResultadosDigitais/rd-docker-atom/master/rd-atom"

download_executable() {
  curl -o "$BIN_PATH" "$DOWNLOAD_URL"
  chmod +x "$BIN_PATH"
}

validate_user_permission() {
  if [ $(id -u) -ne 0 ] ; then
    echo  "Please run as root"
    exit 1
  fi
}

validate_user_permission
download_executable
