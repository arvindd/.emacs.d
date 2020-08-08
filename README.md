# Introduction

This repository contains all my settings for emacs. It is structured so that it is easy for me to setup emacs in any system that I work on, simply by cloning this repo on that system, and then copying the .emacs files to the home directory.

# Emacs setup on any system

- Download and install emacs
- Clone this repository in your home directory:

  `git clone https://github.com/arvindd/.emacs.d.git`
  
  Home directory depends on the type of your system: on Windows, this is the `%USERPROFILE%` location, and on Unix/Linux, it is where `$HOME` points to.
- **Move the file `.emacs` seen in the cloned directory to your home directory too**

That is it. You should be able to use emacs already with this setup, with many settings already in place for you.

# Further settings
The settings can be further customised by anybody who uses this repo, either by directly changing the settings in the *.el files, or by simply adding another file (`.emacsuser`) in the home directory. By adding such a user-settings file, it is possible for whoever uses this repo to keep the settings updated from the repo, without the fear of overwriting their own settings. The file `.emacsuser` will not be overwritten by repo update, because this file is outside the repo, and need to be created by the user.

The file `.emacs` that is in the repo (and which needs to be moved to the home directory before using these settings) contain basic paths for various features (eg: `plansdir` where the org-mode files will be in, etc.). `emacshome` is like the top-most directory, relative to which other files are searched for. 

Any customisations done via the emacs customisation interface go into the `custom.el` file.

# Additional package installation, and elpa configuration
## One-time configuration
The settings have been done so that all the emacs packages get into the directory `<emacshome>/.emacselpa`. For the packages to be installed, it is important that you have the proper GPG key for verifying the signatures of the package. Follow these steps to make it all work:

- Start up emacs
- Temperorily disable signature check:
    
        M-: (setq package-check-signature nil) RET
	
- Refresh package contents, and install the latest GNU GPG keys

        M-x package-refresh-contents RET
        M-x package-install RET gnu-elpa-keyring-update RET
	
- Revert back the checking of the package signatures

        M-: (setq package-check-signature 'allow-unsigned) RET

## Package installations
Having done the above steps once after you clone this repo, there is no longer any need to do them again. Every other time you want to install a package, just use the normal elpa ways to install a package:

    M-x package-install RET <package-to-install> RET
   
All installed packages get into the directory `<emacshome>/.emacselpa`. These are not affected anytime you update this repo because this directory is outside the repository. You are free to install whatever packages you need.

All settings for package installation from ELPA sources are in the `load-melpa.el` file.

## Re-installation of packages that were already installed before
Every package that is installed gets into the `<emacshome>/.emacselpa` directory, and an entry to that effect gets into the custom.el file. If, for whatever reason you lose your `<emacshome>/.emacselpa` directory, and need to re-install the packages again, follow the one-time steps of installing the GNU GPG keys above, and then:

    M-x package-install-selected-packages RET
   
This will re-install all packages back into the `<emacshome>/.emacselpa` directory.

# Org-mode
Well, most of the settings are directly to use the org-mode very effectively. All the org-mode settings are in the file `orgsettings.el`. On default, all the org-mode files are to be stored in the directory `<emacshome>/.plans` - and this can be changed by changing the value of the variable `plansdir` in `.emacs`.

To change the behaviour of orgmode, either change the settings in this file, or, override them by putting the settings in your own `.emacsuser` file in the home directory. The advantage of putting it in the `.emacsuser` is that you can update the repo for new settings, without the fear of overwriting your own settings.

# Other files and directories
`extensions` - Where you can drop other extensions you want. The file `loadext.el` is for adding all the auto-load statements for loading the dropped extensions.

`mycode` - Any custom code you have developed yourself can get in here.

`elpa` - All packages installed ia the `M-x package-install` goes into this directory.

# Dynamically created directories
The autosaves of emacs get into `<emacshome>/.emacsautosaves` and all the emacs backups get into `<emacshome>/.emacssaves`. These directories are automatically created when you use emacs for the first time. By moving the autosaves and backups to this location, we will avoid having such files strewn in all our filesystem locations. What will still be created in the same directory as your opened file is the lock file created by emacs (starting with .#) to avoid multiple instances of emacs accessing the same file. You can switch off creation of such lock files by uncommenting the line that mentions so in `init.el`.

# Comments in the setting files
All the *.el files in the repo have lots of comments - so it is easy to change the settings as hinted by the comments. Feel free to make this your own!
