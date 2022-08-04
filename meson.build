project(
    'wingpanel-caffeine',
    'vala',
    'c'
)

i18n = import('i18n')
gettext_name = meson.project_name() + '-indicator'

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(gettext_name), language:'c')

wingpanel_dep = dependency('wingpanel')
notify_dep = dependency('libnotify')
granite_dep = dependency('granite')
posix_dep = meson.get_compiler('vala').find_library('posix')


shared_module(
    meson.project_name(),
    'src/Indicator.vala',
    'src/Utils.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gio-2.0'),
        dependency('gtk+-3.0'),
        wingpanel_dep,
        notify_dep,
        granite_dep,
        posix_dep
    ],
    install: true,
    install_dir : wingpanel_dep.get_pkgconfig_variable('indicatorsdir')
)