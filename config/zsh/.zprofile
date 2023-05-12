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
