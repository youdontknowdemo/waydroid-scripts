5-30-23 Linux services are powerfull they said. Making them is easy, they said not. The ExecStart directives are are fine tuned for certain shell uses, and have a narrower scope of functional commands that it works well with, so I opted to ExecStart a sepparate shell script, and there subshell further. Currently one of those subshells requires the install of https://github.com/lucaswerkmeister/activate-window-by-title to access the dbus, from a gnome-wayland specific environment. If you cant deal with gnome, launch your prefered bar in x11 backend with: GDK_BACKEND=x11. If it has to be a different window manager, you will have to find and swap out the dbus methods for old x11, I dont know it, I'm new here. You will ...maybe... also need to run waydroid prop set persist.waydroid.multi_windows true
