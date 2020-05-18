#/bin/sh
JCOMMAND="java -jar /minecraft/server.jar"
if [ -f "/out/eula.txt"]; then
   $JCOMMAND
else
   $JCOMMAND && sed -i 's/false/TRUE/ig' /out/eula.txt && $JCOMMAND
fi

