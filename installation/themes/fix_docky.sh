#!/bin/sh
echo "#!/bin/sh" >> /etc/pm/sleep.d/20_docky
echo "case \$1 in" >> /etc/pm/sleep.d/20_docky
echo "  resume)" >> /etc/pm/sleep.d/20_docky
echo "    USER=\`who | grep \":0\" | head -1 | cut -d\" \" -f1\`" >> /etc/pm/sleep.d/20_docky
echo "    USERHOME=/home/\$USER" >> /etc/pm/sleep.d/20_docky
echo "    export XAUTHORITY=\"\$USERHOME/.Xauthority\"" >> /etc/pm/sleep.d/20_docky
echo "    export DISPLAY=\":0\"" >> /etc/pm/sleep.d/20_docky
echo "    su \$USER - -c \"dbus-launch /usr/bin/docky >/dev/null\" &" >> /etc/pm/sleep.d/20_docky
echo "    exit 0;" >> /etc/pm/sleep.d/20_docky
echo "    ;;" >> /etc/pm/sleep.d/20_docky
echo "esac" >> /etc/pm/sleep.d/20_docky
chmod +x /etc/pm/sleep.d/20_docky

echo "#!/bin/sh" >> /etc/pm/power.d/20_docky
echo "USER=\`who | grep \":0\" | head -1 | cut -d\" \" -f1\`" >> /etc/pm/power.d/20_docky
echo "USERHOME=/home/\$USER" >> /etc/pm/power.d/20_docky
echo "export XAUTHORITY=\"\$USERHOME/.Xauthority\"" >> /etc/pm/power.d/20_docky
echo "export DISPLAY=\":0\"" >> /etc/pm/power.d/20_docky
echo "su \$USER - -c \"dbus-launch /usr/bin/docky >/dev/null\" &" >> /etc/pm/power.d/20_docky
echo "exit 0;" >> /etc/pm/power.d/20_docky
chmod +x /etc/pm/power.d/20_docky
