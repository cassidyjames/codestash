project('com.github.cassidyjames.codestash', 'vala', 'c')

gnome = import('gnome')

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
    ],
    install: true
)

subdir('data')

meson.add_install_script('meson/post_install.py')

