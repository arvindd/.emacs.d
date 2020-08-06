# Introduction

This repository contains all my settings for emacs. It is structured so that it is easy for me to setup emacs in any system that I work on, simply by cloning this repo on that system, and then copying the .emacs files to the home directory.

# Emacs setup on any system

- Download and install emacs
- Clone this repository in your home directory:

  `git clone https://github.com/arvindd/.emacs.d.git`
  
  Home directory depends on the type of your system: on Windows, this is the `%USERPROFILE%` location, and on Unix/Linux, it is where `%HOME%` points to.
- **Move the file `.emacs` seen in the cloned directory to your home directory too**

That is it. You should be able to use emacs already with this setup, with many settings already in place for you.

# Further settings
The settings can be further customised by anybody who uses this repo, either by directly changing the settings in the *.el files, or by simply adding another file (`.emacsuser`) in the home directory. By adding such a user-settings file, it is possible for whoever uses this repo to keep the settings updated from the repo, without the fear of overwriting their own settings. The file `.emacsuser` will not be overwritten by repo update, because this file is outside the repo, and need to be created by the user.

The file `.emacs` that is in the repo (and which needs to be moved to the home directory before using these settings) contain basic paths for various features (eg: `plansdir` where the org-mode files will be in, etc.). `emacshome` is like the top-most directory, relative to which other files are searched for. 

Any customisations done via the emacs customisation interface go into the `custom.el` file.

# Org-mode
Well, most of the settings are directly to use the org-mode very effectively. All the org-mode settings are in the file `orgsettings.el`. On default, all the org-mode files are to be stored in the directory `~/.plans` - and this can be changed by changing the value of the variable `plansdir` in `.emacs`.

To change the behaviour of orgmode, either change the settings in this file, or, override them by putting the settings in your own `.emacsuser` file in the home directory. The advantage of putting it in the `.emacsuser` is that you can update the repo for new settings, without the fear of overwriting your own settings.

# Other files and directories
extensions - Where you can drop other extensions you want. The file `loadext.el` is for adding all the auto-load statements for loading the dropped extensions.
mycode - Any custom code you have developed yourself can get in here.
elpa - All packages installed ia the `M-x package-install` goes into this directory.

# Dynamically created directories
The autosaves of emacs get into `&lt;emacshome&gt;/.emacsautosaves` and all the emacs backups get into `&lt;emacshome&gt;/.emacssaves`. These directories are automatically created when you use emacs for the first time. By moving the autosaves and backups to this location, we will avoid having such files strewn in all our filesystem locations. What will still be created in the same directory as your opened file is the lock file created by emacs (starting with .#) to avoid multiple instances of emacs accessing the same file. You can switch off creation of such lock files by uncommenting the line that mentions so in `init.el`.
