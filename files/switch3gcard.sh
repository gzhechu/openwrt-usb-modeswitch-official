#!/bin/bash

CARD[1]="12d1/1505/0"
CMD[1]="/usr/sbin/usb_modeswitch -v 12d1 -p 1505 -V 12d1 -P 140c -M 55534243123456780000000000000011062000000101000100000000000000"

CARD[2]="12d1/1446/0"
CMD[2]="/usr/sbin/usb_modeswitch -v 12d1 -p 1446 -V 12d1 -P 140c -M 55534243123456780000000000000011062000000101000100000000000000"

#echo "PRODUCT:   ${PRODUCT}" >> /dev/ttyS0
#echo "ACTION:    ${ACTION}" >> /dev/ttyS0
#echo "INTERFACE: ${INTERFACE}" >> /dev/ttyS0
#echo "DEVICE:    ${DEVICE}" >> /dev/ttyS0

(( cnt = 1 ))
while [ $cnt -le ${#CARD[@]} ] ; do
    #echo "${CARD[$cnt]}"
    if [ "${PRODUCT}" = "${CARD[$cnt]}" ]; then
            if [ "${ACTION}" = "add" ]; then
                echo "A 3g card was found." >> /dev/ttyS0
                echo ${CMD[$cnt]}
                ${CMD[$cnt]}
            elif [ "${ACTION}" = "remove" ]; then
                echo "A 3g card is switching mode or removed." >> /dev/ttyS0
            fi
    fi
    (( cnt = cnt + 1 ))
done
