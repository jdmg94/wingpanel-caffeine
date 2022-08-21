# Wingpanel Caffeine Indicator

<img src="https://raw.githubusercontent.com/jdmg94/wingpanel-caffeine/main/assets/screenshot.jpeg" alt="wingpanel caffeine popover with toggle switch off" />

## Installation 

You can install the PPA Repository by running the lines below:

```
curl -s --compressed "https://jdmg94.github.io/ppa/ubuntu/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/josemunozdev.list "https://jdmg94.github.io/ppa/ubuntu/josemunozdev.list"
```

After that you should be able to update and install `wingpanel-caffeine` as regular package:

```
sudo apt update
sudo apt install wingpanel-caffeine
```

### Installing as .DEB package

Please download [the latest .deb package](https://github.com/jdmg94/wingpanel-caffeine/releases/) you can install by running:

```
  sudo dpkg -i wingpanel-caffeine_<version>_amd64.deb
```


## Building From Source

You'll need the following dependencies:

```
libnotify
libwingpanel-2.0-dev
meson
valac
```

Run `meson` to configure the build environment and then `ninja` to build

```bash
meson build --prefix=/usr
cd build
ninja
```

To install, use `ninja install`

```bash
sudo ninja install
```

Then run `killall io.elementary.wingpanel` to restart wingpanel.


## Generating a .deb Package

remember to edit the files generated through `dh_make`

```
 dh_make --createorig -p wingpanel-caffeine_<version> 

 dh_auto_configure --buildsystem=meson

 dpkg-buildpackage -rfakeroot -us -uc -b      
```