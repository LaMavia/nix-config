#!/usr/bin/env fish

# set d 0
set current_workspace (swaymsg -t get_outputs | jq -r '.[] | select(.focused)' | jq -r '.current_workspace') 

switch "$argv[1]"
  case "next" 
    set d 1
  case "prev"
    set d -1
end

set next_workspace $(math $current_workspace + $d)
swaymsg workspace number "$next_workspace"

