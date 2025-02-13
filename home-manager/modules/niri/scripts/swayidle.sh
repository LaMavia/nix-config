#!/usr/bin/env bash

lock=swaylock -f
power_on=niri msg action power-on-monitors
power_off=niri msg action power-off-monitors

swayidle -w \
  timeout 900 $lock \
  timeout 1800 "$power_off" resume "$power_on"\
  before-sleep $lock lock $lock unlock $lock
