from src.base import SourceLocation, Target

SourceLocation(
	name = 'ghdl',
	vcs = 'git',
	location = 'https://github.com/ghdl/ghdl',
	revision = 'fbd853c88b4b1c3008b1b39882ac2b99b6e59460',
)

Target(
	name = 'ghdl',
	sources = [ 'ghdl' ],
	license_file = 'ghdl/COPYING.md',
	arch = [ 'linux-x64' ],
)
