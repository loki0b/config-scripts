#!/bin/bash

sudo pacman -S smbclient gvfs-smb --needed

gio mount "smb://webserver.cin.ufpe.br/$1"

gio mount "smb://virtualdisk.cin.ufpe.br/$1"

