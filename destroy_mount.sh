#!/bin/bash -x

#Location of ephemeral_storage
unset ephemeral_storage
ephemeral_storage=`mount|cut -d" " -f3|grep ephemeral`

if [[ -z "${ephemeral_storage// }" ]]
then
   unmounted_dev=`blkid -o list|grep "not mounted"|cut -d" " -f1`
   if [[ -z "${unmounted_dev// }" ]]
   then
       echo "Unable to find ephemeral storage"&& exit 1
   else
       mount_point=`ls /media/`
       ephemeral_storage="/media/${mount_point}"
       mount ${unmounted_dev} ${ephemeral_storage}
   fi
elif [ -a "${ephemeral_storage}/file" ]
then
echo "ephemeral file found....shredding it"
umount "${ephemeral_storage}/file"
shred -n 2 -z -u "${ephemeral_storage}/file"
fi
umount ${ephemeral_storage}
if [ $? -eq 0 ];
then echo "secured storage umounted" && exit 0
else echo "unable to umount secured storage" && exit 1
fi
