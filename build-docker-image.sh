if [[ $PATH != *Docker* ]]; then
  PATH="/c/Program Files/Docker/Docker/resources/bin:$PATH"
fi
docker build -t yosyshq/cross-windows-x64-static docker/cross-windows-x64-static
