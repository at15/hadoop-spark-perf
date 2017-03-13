# Errors

````
Call to virDomainCreateWithFlags failed: internal error: process exited while connecting to monitor: ioctl(KVM_CREATE_VM) failed: 16 Device or resource busy
failed to initialize KVM: Device or resource busy
````

on fedora, it got stuck with waiting for domain to get ip address

````
⇒  vagrant up --provider=libvirt
Bringing machine 'default' up with 'libvirt' provider...
==> default: Uploading base box image as volume into libvirt storage...
==> default: Creating image (snapshot of base box volume).
==> default: Creating domain with the following settings...
==> default:  -- Name:              libvirt_default
==> default:  -- Domain type:       kvm
==> default:  -- Cpus:              1
==> default:  -- Memory:            512M
==> default:  -- Management MAC:    
==> default:  -- Loader:            
==> default:  -- Base box:          at15/base-virt
==> default:  -- Storage pool:      default
==> default:  -- Image:             /var/lib/libvirt/images/libvirt_default.img (40G)
==> default:  -- Volume Cache:      default
==> default:  -- Kernel:            
==> default:  -- Initrd:            
==> default:  -- Graphics Type:     vnc
==> default:  -- Graphics Port:     5900
==> default:  -- Graphics IP:       127.0.0.1
==> default:  -- Graphics Password: Not defined
==> default:  -- Video Type:        cirrus
==> default:  -- Video VRAM:        9216
==> default:  -- Keymap:            en-us
==> default:  -- TPM Path:          
==> default:  -- INPUT:             type=mouse, bus=ps2
==> default:  -- Command line :
==> default: Creating shared folders metadata...
==> default: Starting domain.
==> default: Waiting for domain to get an IP address...
````

- https://bugs.launchpad.net/kolla/+bug/1523200 this say is because of default network

use the example box works, but my ubuntu one just won't work, also by default pmu is not supported
