if [[ $PATH != *Docker* ]]; then
  PATH="/c/Program Files/Docker/Docker/resources/bin:$PATH"
fi

# Need custom ghdl build, don't use builder
if [ ! -d _outputs/windows-x64/ghdl ]; then
  ./build-ghdl.sh
fi

python builder.py build --nproc 4 --arch=windows-x64 --target=yosys --single --tar

#python builder.py build --arch=windows-x64 --target=python3 --single --tar
#if [ ! -f linux-x64-icestorm-bba.tgz ]; then
#  wget "https://github.com/yosyshq/oss-cad-suite-build/releases/download/bucket-linux-x64/linux-x64-icestorm-bba.tgz"
#  tar xvfz linux-x64-icestorm-bba.tgz
#fi
#if [ ! -f linux-x64-nextpnr-bba.tgz ]; then
#  wget "https://github.com/yosyshq/oss-cad-suite-build/releases/download/bucket-linux-x64/linux-x64-nextpnr-bba.tgz"
#  tar xvfz linux-x64-nextpnr-bba.tgz
#fi
#python builder.py build --arch=windows-x64 --target=nextpnr-ice40 --single --tar
#python builder.py build --arch=windows-x64 --target=icestorm --single --tar
