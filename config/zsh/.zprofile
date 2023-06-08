# ssh agent
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent`
fi

local private_keys=("$HOME/.ssh/id_ed25519" "$HOME/.ssh/codecommit_rsa")

for key in $private_keys; do
   if [ -e "$key" ] && type ssh-add &> /dev/null; then
      ssh-add "$key"
   fi
done

eth="`find /sys/devices/ -name net | grep -v virtual | head -n 1 | xargs ls`"
is_exist_ip="`ip addr show dev ${eth} | grep ${PRIVATE_ETH_IP_MASK}`"

if [ -z "${is_exist_ip}" ]; then
   sudo ip addr add "${PRIVATE_ETH_IP_MASK}" dev "${eth}"
fi

# clipboard function
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
   if [[ $(command -v socat > /dev/null; echo $?) == 0 ]]; then
      # Start up the socat forwarder to clip.exe
      ALREADY_RUNNING=$(ps -auxww | grep -q "[l]isten:8121"; echo $?)
      if [[ $ALREADY_RUNNING != "0" ]]; then
         (setsid socat tcp-listen:8121,fork,bind=0.0.0.0 EXEC:'clip.exe' &) > /dev/null 2>&1
      fi
   fi
else
   sudo ln -sf ~/dotfiles/config/scripts/clip.sh /usr/local/bin/clip.exe
fi
