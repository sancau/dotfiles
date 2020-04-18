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
sudo mount /dev/nvme0n1p2 /home/sancau/win_hdd/
bash ~/.screenlayout/2_dell.sh
alias cs='import png:- | xclip -selection clipboard -t image/png'
