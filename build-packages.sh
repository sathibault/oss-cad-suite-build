#!/bin/bash
python builder.py build --arch=linux-x64 --target=python3 --single --tar
python builder.py build --arch=linux-x64 --target=ghdl --single --tar
#python builder.py build --arch=linux-x64 --target=yosys --single --tar
#python builder.py build --arch=linux-x64 --target=nextpnr-baa --single --tar
#python builder.py build --arch=linux-x64 --target=icestorm --single --tar
#python builder.py build --arch=linux-x64 --target=icestorm-bba --single --tar
#python builder.py build --arch=linux-x64 --target=nextpnr-ice40 --single --tar
#python builder.py build --arch=linux-x64 --target=nextpnr-gowin --single --tar
tar --strip-components=3 -xzf ./windows-x64-python3.tgz
tar --strip-components=3 -xzf ./windows-x64-ghdl.tgz
#tar --strip-components=3 -xzf ./windows-x64-yosys.tgz
#tar --strip-components=3 -xzf ./windows-x64-icestorm.tgz
#tar --strip-components=3 -xzf ./windows-x64-nextpnr-ice40.tgz
#tar --strip-components=3 -xzf ./windows-x64-nextpnr-gowin.tgz
mv yosyshq/* /usr/local
rm -rf _sources _builds _outputs *.tgz yosyshq
