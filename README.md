<img src="https://raw.githubusercontent.com/cslarson/dapper/master/dapper.png" alt="Dapper OS" width="100"/>

# Dapper OS (alpha)
#### A (more) secure* desktop environment for running Ethereum dapps
Dapper uses [Archiso](https://wiki.archlinux.org/index.php/archiso) to build a very basic Arch Linux desktop. Only the minimal packages necessary to support running Ethereum dapps are included. Dapper is intended to be run from a non-persisted live usb (see [Instructions](#instructions)).

## Security Features
- ~~Hardened linux kernel (grsecurity/pax)~~
- App sandbox (firejail)
- Firewall (ufw)
- No browser ads (privoxy)
- No admin (no sudo, no root login)
- Minimal support packages (wayland, connman, termite, chromium)
- Runs from non-persisted live usb
- Wayland instead of X.org
  - https://www.reddit.com/r/linux/comments/3yav6t/wayland_security_or_a_tale_of_jack_and_jill/
  - https://lwn.net/Articles/589147/
  - https://blog.martin-graesslin.com/blog/2015/11/looking-at-the-security-of-plasmawayland/

## Instructions
1. run `./build.sh -v -N dapper` (may need `sudo`) (TODO: or use dapper-<VERSION>.iso)
    - or download the most recent
        - using ipfs directly: `ipfs get QmXTx4di9X6qn5YS7QANvV9k4fJj33PLBhmxteJ5UZvbdu -o dapper-2017.05.05-x86_64.iso`
        - using ipfs gateway: [dapper-2017.05.05-x86_64.iso](http://ipfs.io/ipfs/QmXTx4di9X6qn5YS7QANvV9k4fJj33PLBhmxteJ5UZvbdu)        
1. create a bootable usb from resulting `out/dapper-<DATE>-x86_64.iso`
1. partition another usb and label `dapper-data`.
    - this partition will store chain data and keys for the client of choice (geth or parity).
    - labelling as `dapper-data` will ensure the partition can be identified by Dapper.
    - for linux filesystems the partition needs to be accessible by the user `dapper` or group `users`. you may need to do something like `sudo chown -R youruser:users /media/dapper-data`.
1. boot from the dapper usb and select a choice from the menu (TODO: screenshot)
    - remember to backup any keys you create!

## Contribute
  - Provide feedback regarding security
  - Provide feedback regarding usability
  - Help seed the iso on ipfs
  - Make a cool logo
  - Improve the instructions

## \* Disclaimer
Dapper is a tool I created for personal use. I am not a security expert. At this point Dapper has not been reviewed, audited, or received feedback from security experts and should not be relied upon until that occurs. Additionally, what was considered a principle security feature, Grsecurity/Pax, has recently become unavailable. Pending a change in that project, or implementation of a replacement, Linux kernel "hardening" is not implemented.
