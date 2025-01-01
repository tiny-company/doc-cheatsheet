# windows image build

Find here all the steps in order to create a windows image based on packer.

## Description

Find below all the steps of the windows automatic configuration :
- step 1 : Windows machine creation (packer source)
- step 2 : Windows configuration through [unattented file](https://developer.hashicorp.com/packer/guides/automatic-operating-system-installs/autounattend_windows)
- step 3 : Run script to enable and configure [WinRM](https://developer.hashicorp.com/packer/docs/communicators/winrm)
- step 4 : complete configuration using provisioner


### 1. packer source

First create packer source for the windows instance :

See below an example for "openstack" provider :
```
source "openstack" "windows-server" {
  image_name    = var.final_packer_image_name
  winrm_username = var.opk_username
  username      = var.opk_username
  password      = var.opk_password
  identity_endpoint   = var.opk_identity_endpoint
  source_image  = var.windows_source_image
  region        = var.opk_image_region
  flavor        = var.opk_image_flavor
  ssh_username  = var.windows_user
  ssh_password  = var.windows_password
  networks      = var.opk_networks
  communicator  = "winrm"
}
```

### 2. unattented install config

> **Important note** : Depending of the provider, the method to load might change, please refer to the provider documentation.

The unattented file is the windows equivalent of the preseed file for debian, it will contain all the responses to the configuration question of the windows wizard.

to create an unattend.xml to perform unattended installation see :
- [unattend.xml file generator](https://schneegans.de/windows/unattend-generator/)
- [good unattended file example from git repo](https://github.com/StefanScherer/packer-windows/blob/main/answer_files/2022_core/Autounattend.xml)

Once the unattended file is created, we must make it available to the packer machine (source), one common method to do that is to send it in floppy disk mount :
```
"floppy_files": [
    "Autounattend_Windows2016/autounattend.xml",
    "scripts/winrm.ps1",
]
```

Packer creates such virtual floppy disk once specifying file paths and attach it automatically during image creation.

### 3. set WinRM

In order to communicate with the new machine, packer need WinRM (instead of ssh or linux machines). WinRM configuration must happen before any other provisioner as they generaly relate to it. To configure WinRM, the classic method is to do it through a powershell script that is called when executing the unattended file, See [This gist link that explain how to launch winRM configuration script from packer](https://gist.github.com/zachtuttle/6a9d05e40c9a6b6c51bd6dc93e05c8a4).

See below the mandatory steps in order to set winRM :
- Set up a username and password that Packer to connect with.
- Make any necesary registry edits to enable remote execution (and remote execution with elevated privileges, if needed)
- Start WinRM, setting any config needed for allowing basic auth
- Open ports 5985 and/or 5986 depending on how you're connecting
- launch WinRM and set it to automatically launch when the computer restarts
- If necessary, generate a self-signed certificate or provide a real certificate to the WinRM listener.

See [this very good article in order to set winRM](https://til.juliusgamanyi.com/posts/setup-winrm/)

And more straight forward look at this [powershell script that set winRM](https://github.com/juliusgb/utils/blob/main/powershell/SetupWinRM.ps1)

### 4. Complete configuration using provisioner

Complete the configuratin using any other provisioner :
- powershell provisioner : [powershell packer provisioner documentation](https://developer.hashicorp.com/packer/docs/provisioners/powershell)
- ansible provisioner :
    - [see how to set ansible over winRM instead of SSH](https://docs.ansible.com/ansible/2.7/user_guide/windows_winrm.html)

## Sources :

- [best practices with packer and windows](https://hodgkins.io/best-practices-with-packer-and-windows)
- [github repo of windows template with packer](https://github.com/StefanScherer/packer-windows)
- [unattended windows documentation from packer official](https://developer.hashicorp.com/packer/guides/automatic-operating-system-installs/autounattend_windows)
- [packer and winRM blog article](https://configmgr.nl/solutions/packer-and-winrm-the-easy-way/)
- [packer winrM main error](https://github.com/mwrock/packer-templates/issues/101)
- [complete article with best practices for windows image creation with packer and winRM](https://danielhanaj.github.io/post/2021/08/16/build_basic_windows_image_with_packer/)
- [openstack packer building windows image](https://www.mail-archive.com/packer-tool@googlegroups.com/msg00250.html)