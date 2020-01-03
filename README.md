RATFLOW
=======

If you are looking for an easy, intuitive, eye-candy and friendly 
desktop environment - get out and look elsewhere. 

The ratflow project is a set of applications, configs, scripts and 
key bindings that have been developed over the years by a bunch of 
co-workers to do things faster. We would like to share the base of
our setup (or as some may call it - desktop environment) in hope 
that it will make your work easier.

The idea is to learn before use. Spend some time setting up your
battle station, find what suits you best and perform common actions
by reflex. Learn your paths and go with the flow.

Please note that this is core components repository. See the 
ratflow-desktop repository to get full application set with display
manager.

Workspaces
----------

We use i3 as window manager. Please see http://i3wm.org to learn
more about the goals and features. The idea is to cover all your
screen with tiles (windows). Tiles are organized in categorized
workspaces. So no, there is no "application bar". You can setup
it as you wish, but our initial workspaces are:

1. terminal emulators,
2. developer tools,
3. web browsers,
4. file managers,
5. e-mail clients,
6. instant messengers,
7. video players,
8. free workspace,
9. free workspace,
10. music players,

Newly created windows will be automatically assigned to these
workspaces based on the rules from configuration set.

All these workspaces are accessible by single key binding. From
#1 to #9 it's mod key + 1-9, for #10 it's mod key + 0.


Configuration set and profiles
------------------

The configuration file is located in ~/.config/ratflow/config. 
This is i3 configuration file. Read more about i3 configuration 
at http://i3wm.org/docs/userguide.html

You SHOULD NOT edit this file as of Ratflow v1.1.0. Since i3
configuration file does not support any include directives nor
dynamic operations, we've decided to introduce `rfreload` tool.

Configuration sets are stored in config.d directory: 
```
~/.config/ratflow/profiles/<profile>/config.d/
```

where the <profile> is current profile name. Current profile is
symlinked as `~/.config/ratflow/profiles/current`. You can change
current profile at any time calling:

```sh
rfreload --profile my_profile
```

The `default` profile is the default profile activated (symlinked)
at first session start. Source configuration files must be named
as `xx-name` where `xx` is double digit index determining joining
order.

One more change is `${{<command>}}` syntax. Any command result
can be injected to configuration file, e.g. to get second monitor
name:

```
set $rightOutput ${{xrandr | grep connected | awk 'NR==2{print $1}'}}
```

or to include another file:

```
${{cat ~/.my_samsung_media_keys}}
```

Configuration profile also stores custom settings for i3blocks
and Ratflow scripts. The default profile tree may look like this:

```
default/
├── autoapp
├── config.d
│   ├── 01-variables
│   ├── 10-workspaces
│   ├── 11-outputs
│   ├── 13-wallpaper
│   ├── 20-keys-apps-core
│   ├── 20-keys-wm
│   ├── 21-keys-media
│   ├── 21-keys-session
│   ├── 30-theme
│   ├── 31-bar
│   ├── 40-assignments
│   ├── 50-floating
│   ├── 90-exec
│   └── 91-exec_always
└── i3blocks.conf

```

Apps & tools
----

Here's the initial set of applications that comes with ratflow
installation package. Most of them are used in the default 
configuration set, so even though they are not mandatory, we 
recommend to install them in order to use all key bindings and 
services.

* terminator - default terminal emulator that also comes with our
"ratflow-terminator" configuration profile.

* compton - composite manager.

* dmenu-extended - application launcher.

* feh - image viewer used to setup wallpaper images.

* gsimplecal - simple calendar with UI.

* dunst - notification service.

* ulauncher - application launcher

All original configuration files will be backuped as single copy
with timestamp suffix. Note that this is core application set,
please see [ratflow-desktop](https://github.com/ratflow/ratflow-desktop) repo to get extended package.


Installation
------------

If you are new to i3wm, please start by reading i3 configuration 
reference and the contents of 
`system/usr/share/ratflow/default/config.d/` files.

Debian/Ubuntu users can try our APT repository as described below. 
  

Ubuntu 18.04 (Bionic Beaver):

```sh
wget -O - http://apt.nixlab.in/public.gpg.key | sudo apt-key add - 
echo "deb http://apt.nixlab.in/ bionic main" | sudo tee /etc/apt/sources.list.d/apt.nixlab.in.list

sudo apt-get update
sudo apt-get install ratflow-core
```

Enjoy!

