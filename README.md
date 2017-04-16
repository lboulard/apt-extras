# Install external repositories and theirs public keys

Compiled packages can be found at
<https://launchpad.net/~laurent-boulard/+archive/ubuntu/ppa>.

Binary packages:

  - _local+apt-extras_: external repositories and ppa:laurent-boulard
  - _local+common_: Common packages between desktop and headless packages
  - _local+headless_: Packages for headless platform like a server
  - _local+desktop_: Packages for desktop usage
  - _local+devel_: Packages for native development
  - _local+devel-dpkg_: Packages for working with Debian packages

## Create Debian packages on host

    sudo apt-get install devscripts fakeroot gdebi-core
    fakeroot debian/rules binary

A file matching pattern `local+apt-extras_*.deb` is created in upper directory.
Use _gbedi_ command to install and fetch packages. For example:

    sudo gdebi ../local+apt-extras_*_all.deb

## Required operation after install

Run `apt-get update` after installing _local+apt-sources_ package to see
changes applied.

# Dummy packages for personalized environment

Once _local+apt-extras_ is installed other packages can be installed and _apt_
will fetch updated version or non-Ubuntu packages.

## Package _local+headless_

This package installs non _X11_ dependent packages. It aims at server usage
only accessed using _ssh_.

It can safely be installed safely along _local+desktop_ package. Beware that
_local+desktop_ shall be installed first in this case.

### Change user shell to _zsh_

Package _zsh_ is installed but shell not enforced on existing or future user.
Use command _chsh_ to change default shell of current user:

    chsh -s /bin/zsh

## Package _local+desktop_

This package installs desktop usage related packages. It targets mainly _i3_
window manager but is also useful in standard Ubuntu desktop.

## Package _local+devel_

This package install development environment for basic native programming. Only
basic packages are installed, other packages for dedicated development like
Debian packages maintenance and creation, ARM cross compiling and provided in
other packages.

This package will never fetch _X11_ dependent packages.

## Package _local+devel-dpkg_

Install packages for working with Debian packages. Permit to create package
locally with _chroot_-ed environment.
