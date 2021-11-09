#!/bin/bash

export PATH=$PATH:~/.local/bin
cp -r $HOME/NCOS/dotfiles/* $HOME/.config/
pip install konsave
konsave -i $HOME/NCOS/ncosv1.knsv
sleep 1
konsave -a ncosv1
