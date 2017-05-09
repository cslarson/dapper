# Dapper OS (alpha)
#### A (more) secure* desktop environment for running Ethereum dapps
Dapper uses [Archiso](https://wiki.archlinux.org/index.php/archiso) to build a basic Arch Linux desktop, streamlined for running Ethereum dapps, and designed to be run from a non-persisted live usb (see [Instructions](#instructions)). The choice of packages and settings for Dapper are intended to achieve a system that is:

1. minimal - only install what is needed to use dapps.
1. locked down - restrict allowed actions to minimum needed to use dapps.
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
- the current iso uses the `gb` keyboard layout

## Instructions
1. build or download the dapper iso
    - for building on an Arch based system:
      1. install archiso (`sudo pacman -S archiso`)
      1. clone this repo (`git clone git@github.com:cslarson/dapper.git`)
      1. work in that new directory (`cd dapper`)
      1. remove the previous work directory if there is one (`sudo rm -rf work`)
      1. run the build script (`sudo ./build.sh -v -N dapper`)
    - download the most recent dapper iso:
      - using ipfs directly: `ipfs get Qmef5Rp64yhWLJ9qs1tnRk5NMAxr7YCsDfg1VA4eSMS16B -o dapper-2017.05.09-x86_64.iso`
      - using ipfs gateway (rename after download): [dapper-2017.05.09-x86_64.iso](http://ipfs.io/ipfs/Qmef5Rp64yhWLJ9qs1tnRk5NMAxr7YCsDfg1VA4eSMS16B)
1. create a bootable usb from resulting `out/dapper-<DATE>-x86_64.iso` (or the downloaded file)
1. partition another usb and label `dapper-data`.
    - this partition will store chain data and keys for the client of choice (geth or parity).
    - labelling as `dapper-data` will ensure the partition can be identified by Dapper.
    - for linux filesystems the partition needs to be accessible by the user `dapper` or group `users`. you may need to do something like `sudo chown -R youruser:users /media/dapper-data`.
1. boot your pc from the dapper usb
    - you may need to enter your bios settings to accomplish this. usually there is screen right after turning on the pc where you are prompted to hit the "Delete" key to access the bios settings. the boot device can be selected there.
1. click on the pink monocle icon to open the menu
1. select a choice from the menu
    - remember to backup any keys you create!

<img src="https://raw.githubusercontent.com/cslarson/dapper/master/screenshot-menu.png" alt="Dapper OS" width="400"/>

## Dev
After building, it's easy to quickly test out most modifications using a chroot-like tool called `systemd-nspawn`:
1. `sudo systemd-nspawn --boot -D work/x86_64/airootfs`
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
- Work out way to build/dev on non-Arch systems
- Get the weston desktop to autorun the menu

## \*Disclaimer
Dapper is a tool I created for personal use. I am not a security expert. At this point Dapper has not been reviewed, audited, or received feedback from security experts and should not be relied upon until that occurs. Additionally, what was considered a principle security feature, Grsecurity/Pax, has recently become unavailable. Pending a change in that project, or implementation of a replacement, Linux kernel "hardening" is not implemented.

## Logo?

<img src="https://raw.githubusercontent.com/cslarson/dapper/master/dapper.png" alt="Dapper OS" width="60"/>
