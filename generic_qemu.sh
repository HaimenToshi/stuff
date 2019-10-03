#!/bin/sh
set -e
UUN="$(basename $0 .sh)"
CUUN="$(echo "$UUN" | sed 's/.*/\u&/')"

if [[ ! -e /home/yzarc/VM_Disks/$(echo "$UUN" | sed 's/.*/\u&/').img ]]; then
    mkdir -p /home/yzarc/VM_Disks
    truncate -s+20G /home/yzarc/VM_Disks/$(echo "$UUN" | sed 's/.*/\u&/').img
fi
SPICEPORT=$(shuf -i5900-5910 -n1)
rm -rf /tmp/vm_$UUN.socket > /dev/null 2>&1
qemu-system-x86_64 -name $UUN -machine type=pc,accel=kvm -nographic \
-m 4G -cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_time,hv_reset,hv_synic,hv_stimer,hv_runtime,hv_crash,hv_vpindex,hv_vendor_id=NetworkBreak \
-smp sockets=1,cores=6,threads=1 \
-vga qxl -global qxl-vga.ram_size=134217728 -global qxl-vga.vram_size=134217728 -global qxl-vga.vgamem_mb=128 \
-spice port=$SPICEPORT,addr=127.0.0.1,disable-ticketing \
-device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent \
-device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
-object iothread,id=io0 \
-drive if=pflash,format=raw,readonly,file=/usr/share/ovmf/ovmf_code_x64.bin \
-drive file=/home/yzarc/VM_Disks/$CUUN.img,cache=none,format=raw,if=none,id=drive0,aio=native,discard=unmap \
-device virtio-scsi-pci,id=scsi0,ioeventfd=on,num_queues=16,vectors=17,iothread=io0 \
-device scsi-hd,drive=drive0,bootindex=2 \
-drive file=/usr/share/virtio/virtio-win.iso,id=cd1,if=none,format=raw,readonly \
-device ich9-ahci,id=ahci \
-device ide-cd,drive=cd0,bus=ahci.0,bootindex=1 \
-drive file=/home/yzarc/ISOs/$CUUN.iso,id=cd0,if=none,format=raw,readonly \
-device ide-cd,drive=cd1,bus=ahci.1 \
-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 \
-rtc clock=host,base=localtime \
-device nec-usb-xhci,id=usb \
-chardev spicevmc,name=usbredir,id=usbredirchardev1 \
-device usb-redir,chardev=usbredirchardev1,id=usbredirdev1 \
-chardev spicevmc,name=usbredir,id=usbredirchardev2 \
-device usb-redir,chardev=usbredirchardev2,id=usbredirdev2 \
-chardev spicevmc,name=usbredir,id=usbredirchardev3 \
-device usb-redir,chardev=usbredirchardev3,id=usbredirdev3 \
-net none \
-netdev bridge,id=br0 \
-device virtio-net-pci,netdev=br0,ioeventfd=on,mq=on,vectors=22,id=nic0,mac=$(machasher "$UUN") \
-monitor unix:/tmp/vm_$UUN.socket,server,nowait &
echo "This VM's SPICE port is $SPICEPORT"
spicy -h 127.0.0.1 -p $SPICEPORT --title="$CUUN (QEMU)"
