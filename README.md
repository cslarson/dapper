# Dapper OS (alpha)
#### A (more) secure* desktop environment for running Ethereum dapps
Dapper uses [Archiso](https://wiki.archlinux.org/index.php/archiso) to build a very basic Arch Linux desktop. Only the minimal packages necessary to support running Ethereum dapps are included. Dapper is intended to be run from a non-persisted live usb (see [Instructions](#instructions)). The choice of packages and settings for Dapper have been guided by wanting to achieve a system that is:

1. minimal - only install what is needed to use dapps.
1. locked down - restrict allowed actions to minimal needed to use dapps.
1. defended - employ software tools that improve system security

## Security Features
- ~~Hardened linux kernel (grsecurity/pax)~~
- App sandbox (firejail)
- Firewall (ufw)
- No browser ads (privoxy)
- No admin (no sudo, no root login)
- Minimal support packages (wayland, connman, termite, epiphany)
- Runs from non-persisted live usb
- Wayland instead of X.org
  - https://www.reddit.com/r/linux/comments/3yav6t/wayland_security_or_a_tale_of_jack_and_jill/
  - https://lwn.net/Articles/589147/
  - https://blog.martin-graesslin.com/blog/2015/11/looking-at-the-security-of-plasmawayland/

## Limitations
- currently i've been unsuccessful running dapper in a Virtual Machine (though `systemd-nspawn` works great, see [Dev](#dev))
- the currently available iso will only run on intel/amd 64bit systems

## Instructions
1. build or download the dapper iso
  - for building on an Arch based system:
    1. install archiso (`sudo pacman -S archiso`)
    1. clone this repo (`git clone git@github.com:cslarson/dapper.git`)
    1. run `sudo ./build.sh -v -N dapper`
  - download the most recent dapper iso:
    - using ipfs directly: `ipfs get QmXTx4di9X6qn5YS7QANvV9k4fJj33PLBhmxteJ5UZvbdu -o dapper-2017.05.05-x86_64.iso`
    - using ipfs gateway (rename after download): [dapper-2017.05.05-x86_64.iso](http://ipfs.io/ipfs/QmXTx4di9X6qn5YS7QANvV9k4fJj33PLBhmxteJ5UZvbdu)
1. create a bootable usb from resulting `out/dapper-<DATE>-x86_64.iso` (or the downloaded file)
1. partition another usb and label `dapper-data`.
    - this partition will store chain data and keys for the client of choice (geth or parity).
    - labelling as `dapper-data` will ensure the partition can be identified by Dapper.
    - for linux filesystems the partition needs to be accessible by the user `dapper` or group `users`. you may need to do something like `sudo chown -R youruser:users /media/dapper-data`.
1. boot from the dapper usb and select a choice from the menu (TODO: screenshot)
    - remember to backup any keys you create!

## Dev
After building, it's easy to quickly test out most modifications using a chroot-like tool called `systemd-nspawn`:
1. `cd work/x86_64/airootfs`
1. `sudo systemd-nspawn --boot`
1. `export DISPLAY=:0`
1. `weston`

## Contribute
  - Provide feedback regarding security
  - Provide feedback regarding usability
  - Help seed the iso on ipfs
  - Make a cool logo
  - Improve the instructions
  - Get dapper to boot in a vm
  - Get dapper to work on raspberry pi/arm
  - Work out way to build/dev on non-Arch system

## \* Disclaimer
Dapper is a tool I created for personal use. I am not a security expert. At this point Dapper has not been reviewed, audited, or received feedback from security experts and should not be relied upon until that occurs. Additionally, what was considered a principle security feature, Grsecurity/Pax, has recently become unavailable. Pending a change in that project, or implementation of a replacement, Linux kernel "hardening" is not implemented.

## Logo?

<img src="https://raw.githubusercontent.com/cslarson/dapper/master/dapper.png" alt="Dapper OS" width="60"/>
