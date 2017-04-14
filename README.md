# Install external repositories and theirs public keys

Compiled packages can be found at
<https://launchpad.net/~laurent-boulard/+archive/ubuntu/ppa>.

Binary packages:

  - _local+apt-sources_: external respotiories and ppa:laurent-boulard
  - _local+headless_: Packages list for headless platform like server
  - _local+desktop_: Packages list for desktop usage
  - _local+devel_: Packages list fot basic development

## Create debian packages on host

    sudo apt-get install devscripts fakeroot gdebi-core
    fakeroot debian/rules binary

A file matching pattern `local+apt-extras_*.deb` is created in upper directory.
Use _gbedi_ command to install and fetch packages. For example:

    sudo gdebi ../local+apt-extras_*_all.deb

## Required operation after install

Run `apt-get update` after installing _local+apt-sources_ package to see
changes applied.

# Dummy packages for personalized environment

Once _local+apt-sources_ is installed other packages can be installed and _apt_
will fetch updated version or non-Ubuntu packages.

## Package _local+headless_

This package installs non _X11_ dependent packages. It aims at server usage
only accessed using _ssh_.

It can safely be installed safely along _local+desktop_ package. Beware that
_local+desktop_ shall be installed first in this case.

Use _gbedi_ command to install and fetch packages. For example:

    sudo gdebi ../local+headless_*_all.deb

Say `Y` (yes) when asked to install downloaded packages.

### Change user shell to _zsh_

Package _zsh_ is installed but shell not enforced on existing or future user.
Use command _chsh_ to change default shell of current user:

    chsh -s /bin/zsh

## Package _local+desktop_

This package installs desktop usage related packages. It targets mainly _i3_
window manager but is also useful in standard Ubuntu desktop.

Use _gbedi_ command to install and fetch packages. For example:

    sudo gdebi ../local+desktop_*_all.deb

Say `Y` (yes) when asked to install downloaded packages.

## Package _local+devel_

This package install development environment. Only basic packages are
installed, other packages for dedicated development like ARM cross compiling
and provided in other packages.

This package will never fetch _X11_ dependent packages.

Use _gbedi_ command to install and fetch packages. For example:

    sudo gdebi ../local+devel_*_all.deb

Say `Y` (yes) when asked to install downloaded packages.
