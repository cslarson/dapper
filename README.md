# Dapper OS (experimental)
#### A (more) secure* desktop environment for running Ethereum dapps
Dapper uses [Archiso](https://wiki.archlinux.org/index.php/archiso) to build a basic Arch Linux desktop, streamlined for running Ethereum dapps, and designed to be run from a non-persisted live usb (see [Instructions](#instructions)).

## Security Features
- [Hardened linux kernel](https://www.archlinux.org/packages/community/x86_64/linux-hardened/) (~~grsecurity~~)
- ~~[Mandatory Access Control (MAC)]~~ TODO [apparmor](https://wiki.archlinux.org/index.php/AppArmor), [tomoyo](https://wiki.archlinux.org/index.php/TOMOYO_Linux), [selinux](https://wiki.archlinux.org/index.php/SELinux)?
- App sandbox ([firejail](https://wiki.archlinux.org/index.php/Firejail))
- Firewall ([ufw](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall))
- No browser ads ([privoxy](https://wiki.archlinux.org/index.php/Privoxy))
- Encrypted dns traffic ([dnscrypt](https://wiki.archlinux.org/index.php/DNSCrypt))
- No admin (no sudo, no root login)
- Minimal support packages (wayland, connman, termite, epiphany, [all](packages.both))
- Runs from non-persisted live usb
- Pure Wayland desktop ([More on Wayland vs X11 security](#seealso))

## Limitations
- currently i've been unsuccessful running dapper in a Virtual Machine (though `systemd-nspawn` works great, see [Dev](#dev))
- the currently available iso will only run on intel/amd 64bit systems
- the current iso uses the `gb` keyboard layout
- Chromium on Linux is not currently pure Wayland but should be once v59 is released ([very soon](https://www.chromium.org/developers/calendar)). As Mist depends on Chromium through it's use of electron, I'm waiting on that before adding Mist support to Dapper. See [here](https://github.com/electron/electron/issues/2927) for more details. At that point the browser may also switch from Epiphany to Chromium.

## Instructions
1. build or download the dapper iso
    - [NEW] build on any system using Docker:
      1. clone this repo (`git clone git@github.com:cslarson/dapper.git`) or fork and customise (TODO - instructions on customising)
      1. work in that new directory (`cd dapper`)
      1. build the docker image `sudo docker build --rm -t cslarson/dapper-builder .`
      1. build the iso `sudo docker run --rm -v /tmp:/tmp -t -i --privileged cslarson/dapper-builder:latest`
      1. the built iso can be found at `/tmp/dapper-<DATE>-x86_64.iso` of your host (main os).
    - build on an Arch based system:
      1. install archiso (`sudo pacman -S archiso`)
      1. clone this repo (`git clone git@github.com:cslarson/dapper.git`)
      1. work in that new directory (`cd dapper`)
      1. remove the previous work directory if there is one (`sudo rm -rf work`)
      1. run the build script (`sudo ./build.sh -v -N dapper`)
    - download the most recent dapper iso:
      - **fyi** if this date is in the past then the packages may be out of date. if you're unable to build Dapper yourself or would otherwise like me to generate a new iso just create and issue and i'll be happy to do so.
      - using ipfs directly: `ipfs get QmWNcsFBsfhcf69955HhSbAjbtC6ArtxUWGx2bdFMGRKuS -o dapper-2017.05.18-x86_64.iso`
      - using ipfs gateway (rename after download): [dapper-2017.05.18-x86_64.iso](http://ipfs.io/ipfs/QmWNcsFBsfhcf69955HhSbAjbtC6ArtxUWGx2bdFMGRKuS)
1. create a bootable usb from resulting `out/dapper-<DATE>-x86_64.iso` (or the downloaded file)
1. partition another usb and label `dapper-data`.
    - this partition will store chain data and keys for the client of choice (geth or parity).
    - labelling as `dapper-data` will ensure the partition can be identified by Dapper.
    - for linux filesystems the partition needs to be accessible by the user dapper or group users. you may need to do something like `sudo chown -R 1000 /media/dapper-data` (1000 is the uid for the dapper user)
1. boot your pc from the dapper usb
    - you may need to enter your bios settings to accomplish this. usually there is screen right after turning on the pc where you are prompted to hit the "Delete" key to access the bios settings. the boot device can be selected there.
1. click on the pink monocle icon to open the menu
1. select a choice from the menu

### Remember to backup any keys you create!!!!
The `udisks2` package is included to allow mounting of additional usb drives primarily for the purpose of backing up any keys that were created. Drives will be mounted at `/run/media/dapper`.

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

## See also
- [Arch wiki page on security](https://wiki.archlinux.org/index.php/Security)
- [Linux distributions and WebKit security](https://blogs.gnome.org/mcatanzaro/2016/02/01/on-webkit-security-updates/)
- [Reddit discussion on Wayland security](https://www.reddit.com/r/linux/comments/3yav6t/wayland_security_or_a_tale_of_jack_and_jill/)
- [LWN article on Wayland security](https://lwn.net/Articles/589147/)
- [Blog post on X11 & Wayland security](https://blog.martin-graesslin.com/blog/2015/11/looking-at-the-security-of-plasmawayland/)
