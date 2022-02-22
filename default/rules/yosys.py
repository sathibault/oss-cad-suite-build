from src.base import SourceLocation, Target

SourceLocation(
	name = 'yosys',
	vcs = 'git',
	location = 'https://github.com/sathibault/yosys.git',
# ice40-dsp-unextend-bug
	revision = '7108feca6f5ab1ad5dc5368b16fd54237811e288'
)

SourceLocation(
	name = 'ghdl-yosys-plugin',
	vcs = 'git',
	location = 'https://github.com/ghdl/ghdl-yosys-plugin',
	revision = 'c9b05e481423c55ffcbb856fd5296701f670808c'
)

SourceLocation(
	name = 'graphviz',
	vcs = 'git',
	location = 'https://gitlab.com/graphviz/graphviz',
	revision = 'tags/2.42.2'
)

Target(
	name = 'yosys',
	sources = [ 'yosys', 'ghdl-yosys-plugin' ],
	dependencies = [ 'ghdl' ],
	resources = [ 'xdot', 'graphviz' ],
	license_file = 'yosys/COPYING',
)

Target(
	name = 'xdot',
	dependencies = [ 'python3' ],
	resources = [ 'python3' ],
	patches = [ 'python3_package.sh' ],
	sources = [ ],
	arch = [ 'linux-x64', 'linux-arm', 'linux-arm64', 'linux-riscv64', 'darwin-x64', 'darwin-arm64' ],
)

Target(
	name = 'graphviz',
	patches = [ 'graphviz_fix.diff' ],
	sources = [ 'graphviz' ],
	arch = [ 'linux-x64', 'linux-arm', 'linux-arm64', 'linux-riscv64', 'darwin-x64', 'darwin-arm64' ],
)
