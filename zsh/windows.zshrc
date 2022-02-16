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
