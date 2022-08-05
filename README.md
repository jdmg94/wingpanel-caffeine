# Wingpanel Template Indicator

<!-- Screenshot here -->

## Building and Installation

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

Then run `killall wingpanel` to restart wingpanel.
