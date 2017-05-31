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
shred -n 2 -z -u "${ephemeral_storage}/file"
fi

storage_size=$(stat -f --format="%f" ${ephemeral_storage})
file="${ephemeral_storage}/file"
dd if=/dev/zero of=${file} bs=$(stat -f --format="%S" ${ephemeral_storage}) count=${storage_size}
mkfs.ext3 ${file}
mount -o loop ${file} /mnt/

if [ $? -eq 0 ];
then echo "secured storage mounted at /mnt" && exit 0
else echo "unable to mount secured storage" && exit 1
fi
