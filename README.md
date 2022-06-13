TempleOS Wordle
===============

What's this?
------------

This is a TempleOS and ZealOS exclusive guessing game.

Ok how do I run this thing?
---------------------------

Right now the build system is kinda scuffed, you need to have:
 * powershell core

For VM:
 * bash, qemu-system-x86\_64 (if on Linux)
 * archiso (if on Arch)

K i now have this shit, what do I do now?
-----------------------------------------

You simply run `./Build.ps1`. This will start the build process. If you wish to build for ZealOS instead,
you can run `./Build.ps1 -zeal $true` or `$ ZEAL=ON ./Build.ps1`.

After that is done, on Linux, you will be asked if you want to start a VM if you chose not to build for ZealOS.

For TempleOS, the ISO.C file is located under the `tos` directory under the name of `wordle.ISO.C`.
For ZealOS, the ISO.C file is located in the root of the repository under the name of `wordle_zeal.ISO.C`.

VM?
---

Yes, if you are on linux, you can start a VM using `cd tos && ./tos.sh run`. This will automatically configure a VM for you (except the base installation of TempleOS). 

Archiso, optionally, is then used to install the GRUB2 bootloader which allows you to boot without manually pressing `1`.

When the VM boots up fully, you can then use the macro in the terminal to launch the game.

LICENSE
-------

This software is licensed under the DBAD license. Click [here](LICENSE.md) for more details.
