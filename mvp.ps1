param([string]$file)
#Program requires directory name Occulto on desktop, set-execution poliy to unrestricted, install .ova 

#copy input file to shared folder
copy-item $file -Destination C:\Users\$env:Username\Desktop\Occulto\

#RUN VBoxManage for typical installations 
$RN = PWD
cd 'C:\Program Files\Oracle\VirtualBox'

#start machine
.\VBoxManage.exe startvm Omachine
.\VBoxManage sharedfolder add Omachine --name Oshare --hostpath C:\Users\$env:Username\Desktop\Occulto --transient -automount


#Omachine on startup opens LXqt, mounts the shared folder occulto, then opens shared file. 
#Once the user is done viewing the file, Omachine shutsdown. 

$MACH = '"Omachine" {5c88bb43-e23f-439a-80ff-e352c309d56e}'
start-sleep -s 30 #allow time for vm startup
$STATUS = .\VBoxManage.exe list runningvms

While ($STATUS -contains $MACH)
{
$STATUS = .\VBoxManage.exe list runningvms
} 

#empties shared folder
remove-item C:\Users\$env:Username\Desktop\Occulto\* -Recurse

cd $RN 