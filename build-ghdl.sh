if [ ! -d ghdl ]; then
  git clone https://github.com/ghdl/ghdl
  # Jan 18, 2022
  cd ghdl; git checkout 0e46300c437e39747ebe65e6eae5a131477d28c9; cd ..
fi
mkdir -p _outputs/windows-x64/ghdl/yosyshq
cd ghdl; ./configure --prefix=../_outputs/windows-x64/ghdl/yosyshq; cd ..
make -C ghdl GNAT_BARGS="-bargs -E -static" LDFLAGS="-static"
make -C ghdl install
# copy libgnat.a to lib directory
cp `cat _outputs/windows-x64/ghdl/yosyshq/lib/libghdl.link | tr -s '\n' ' '` _outputs/windows-x64/ghdl/yosyshq/lib
# yosys Makefile reads link to find it
echo "/work/_outputs/windows-x64/ghdl/yosyshq/lib/libgnat.a" > _outputs/windows-x64/ghdl/yosyshq/lib/libghdl.link
tar -czf windows-x64-ghdl.tgz _outputs/windows-x64/ghdl
