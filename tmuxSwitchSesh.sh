switch-seshh(){
tmux has-session -t $1 2>/dev/null
local sesh=$?
if [ $sesh -ne 0 ]; then

#    tmux new -dt $1
    tmux new-session -d -s $1 -c $2
    (figlet -f Poison $1) | lolcat
fi
# exec </dev/tty
# exec <&1
tmux switch-client -t $1
}
# switch-seshh $1 $2
# switch-seshh(){
# tmux has-session -t $1 2>/dev/null
# local sesh=$?
# if [ $sesh -ne 0 ]; then
# #    tmux new -dt $1
#     tmux new-session -d -s $1 "nvim $2"
#     # (figlet -f Poison $1) | lolcat
# fi
# tmux switch-client -t $1
# }
switch-seshh $1 $2
