#!/bin/bash

feh --bg-scale $(ls -d $HOME/wallpapers/* | sort --random-sort | head -n1)
