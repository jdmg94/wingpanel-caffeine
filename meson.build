project(
    'wingpanel-caffeine',
    'vala',
    'c',
    version : '0.2.0'
)

i18n = import('i18n')
app_id = 'dev.josemunoz.wingpanel-caffeine'
gettext_name = meson.project_name() + '-indicator'

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(gettext_name), language:'c')

wingpanel_dep = dependency('wingpanel')
granite_dep = dependency('granite')
notify_dep = dependency('libnotify')
posix_dep = meson.get_compiler('vala').find_library('posix')

install_data(
   [
    join_paths('assets', 'caffeine-cup-empty-symbolic.svg'),
    join_paths('assets', 'caffeine-cup-full-symbolic.svg')
  ],
  install_dir: join_paths(
   get_option('prefix'), get_option('datadir'), 'icons', 'hicolor', 'scalable', 'status'
  )
)

shared_module(
    meson.project_name(),
    'src/Indicator.vala',
    'src/Caffeinate.vala',
    'src/TimeOptions.vala',
    'src/PopOverWidget.vala',
    'src/RevealerSwitch.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gio-2.0'),
        dependency('gtk+-3.0'),
        wingpanel_dep,
        granite_dep,
        notify_dep,
        posix_dep
    ],
    install: true,
    install_dir : wingpanel_dep.get_pkgconfig_variable('indicatorsdir')
)