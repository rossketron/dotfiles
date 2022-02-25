############################
# Open current file in Windows
############################
alias view="wslview"

############################
# Configure X11 forwarding for WSL
############################
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
export LIBGL_ALWAYS_INDIRECT=1 #GWSL
export GDK_SCALE=1 #GWSL
export QT_SCALE_FACTOR=1 #GWSL

############################
# Comment out the line to launch zsh when bash launches
# This should only be used on first terminal load in WSL
# Will be uncommented in .bash_logout when session ends
############################
LINE="zsh"
LINE_NUM=$(awk 'NF{c=FNR}END{print c}' $HOME/.bashrc) 
sed -i "${LINE_NUM}s/.*/#${LINE}/" $HOME/.bashrc
