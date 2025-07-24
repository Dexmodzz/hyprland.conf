#!/bin/bash

#!/bin/bash

# Avvia dbus-session se non c'è
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Aspetta qualche secondo per sicurezza
sleep 5

# Lancia gli applet in background
nm-applet &
blueman-applet &

if ! pgrep -x dbus-daemon > /dev/null; then
    eval $(dbus-launch --sh-syntax)
    echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"
fi


nm-applet &


sleep 1

blueman-applet &


wait
