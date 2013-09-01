#!/usr/bin/env bash

conky -c "$HOME/.monsterwm.d/.conkyrc" | dzen2 -h 18 -x 500 -ta r -e -p -fn "-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*" &

# create a fifo to send output
ff="/tmp/monsterwm.fifo"
[[ -p $ff ]] || mkfifo -m 600 "$ff"
 
while read -r; do
# filter output to only what we want to match and parse
[[ $REPLY =~ ^(([[:digit:]]+:)+[[:digit:]]+ ?)+$ ]] && read -ra desktops <<< "$REPLY" || continue
for desktop in "${desktops[@]}"; do
# set values for
# d - the desktop id
# w - number of windows in that desktop
# m - tiling layout/mode for that desktop
# c - whether that desktop is the current (1) or not (0)
# u - whether a window in that desktop has an urgent hint set (1) or not (0)
IFS=':' read -r d w m c u <<< "$desktop"
 
# name each desktop
case $d in
0) d="web" s="" ;;
1) d="ecs" s="" ;;
2) d="dev" s="" ;;
3) d="doc" s="" ;;
4) d="otr" s="" ;;
esac
 
# the current desktop color should be #d11783
# we will also display the current desktop's tiling layout/mode
((c)) && f="#0088BB" && case $m in
# name each layout/mode with a symbol
0) i="T" ;;
1) i="M" ;;
2) i="B" ;;
3) i="G" ;;
4) i="F" ;;
esac || f="#999999"
 
# if the desktop has an urgent hint its color should be #ff0000
((u)) && f="#ff0000"
 
# if the desktop has windows print that number next to the desktop name
# else just print the desktop name
((w)) && r+="($s^fg($f)$d $w^fg()) " || r+="($s^fg($f)$d^fg()) "
done
 
# read from fifo and output to dzen2
printf "(%s%s\n" "$r" "$i)" && unset r
done < "$ff" | dzen2 -h 18 -w 500 -ta l -e -p -fn "-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*" &
 
# pass output to fifo
monsterwm > "$ff"
