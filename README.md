# Wingpanel Caffeine Indicator

<img src="https://raw.githubusercontent.com/jdmg94/wingpanel-caffeine/main/assets/screenshot.jpeg" alt="wingpanel caffeine popover with toggle switch off" />

## Installation 

I'm working on setting up an apt repository, in the mean time please download [the latest .deb package](https://github.com/jdmg94/wingpanel-caffeine/releases/)

You can install by running:

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