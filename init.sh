killall gxkb
killall pulseaudio
sleep 1
gxkb & disown
pulseaudio & disown
sleep 1
setxkbmap -layout us,ru
setxkbmap -option 'grp:win_space_toggle'
xset r rate 200 50
sudo nmcli c u VPN
bash ~/.screenlayout/2_dell.sh
