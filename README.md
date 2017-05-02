# Dapper OS (alpha)
#### A (more) secure* desktop environment for running Ethereum dapps
Dapper uses [Archiso](https://wiki.archlinux.org/index.php/archiso) to build a very basic Arch Linux desktop. Only the minimal packages necessary to support running Ethereum dapps are included. Dapper is intended to be run as a non-persisted live usb (see [Instructions](#instructions)).

## Security Features
- ~~Hardened linux kernel (grsecurity/pax)~~
- App sandbox (firejail)
- Firewall (ufw)
- No browser ads (privoxy)
- No admin (no sudo, no root login)
- Minimal support packages (wayland, connman, termite, waycooler, chromium)
- Runs from non-persisted live usb - replace dapper.iso to update
- Wayland instead of X.org
  - https://www.reddit.com/r/linux/comments/3yav6t/wayland_security_or_a_tale_of_jack_and_jill/
  - https://lwn.net/Articles/589147/
  - https://blog.martin-graesslin.com/blog/2015/11/looking-at-the-security-of-plasmawayland/

## Instructions
1. run `./build.sh -v -N dapper` (may need `sudo`) (TODO: or use dapper-<VERSION>.iso)
1. create a bootable usb from resulting `out/dapper-<DATE>-x86_64.iso`
1. partition another usb and label `dapper-data`. 
    - this partition will store chain data and keys for the client of choice (geth or parity). 
    - labelling as `dapper-data` will ensure the partition can be identified by Dapper.
1. boot from the dapper usb and select a choice from the menu (TODO: screenshot)
    - remember to backup any keys you create!

## \* Disclaimer
Dapper is a tool I created for personal use. I am not a security expert. At this point Dapper has not been reviewed, audited, or received feedback from security experts and should not be relied upon until that occurs. Additionally, what was considered a principle security feature, Grsecurity/Pax, has recently become unavailable. Pending a change in that project, or implementation of a replacement, Linux kernel "hardening" is not implemented.
