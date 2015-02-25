#!/bin/sh

pgrep $1 > /dev/null || ($@ >/dev/null &)
