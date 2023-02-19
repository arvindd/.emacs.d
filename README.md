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
The settings can be further customised by anybody who uses this repo, either by directly changing the settings in the *.el files, or by simply adding one of these files - `.emacsuserpre` OR/AND `.emacsuserpost` - in the home directory. The pre-settings file sets configurations that 
can help in being effective before the rest of the settings are effective (therefore, things like setting proxy in a corporate environment
can get into this) and the post-settings file are for settings that can override default settings (for example, you may override the default
color scheme here).

By adding such a user-settings file, it is possible for whoever uses this repo to keep the settings updated from the repo, without the fear of overwriting their own settings. The file `.emacsuserpre` or `.emacsuserpost` will not be overwritten by repo update, because this file is outside the repo, and need to be created by the user. Samples of both these files are also in this repo.

The file `.emacs` that is in the repo (and which needs to be moved to the home directory before using these settings) contain basic paths for various features (eg: `notesdir` where the org-mode files will be in, etc.). `emacshome` is like the top-most directory, relative to which other files are searched for. 

Any customisations done via the emacs customisation interface go into the `custom.el` file.

Note that all the keybindings (except those for org-mode) are put in one place: `keybindings.el`. All the org-mode keybindings are put along with other org-mode settings (see below).

# Windows specific installation / settings
## Pinning to taskbar
Hey, this is another small trick. To pin emacs on the taskbar, just follow these steps:

1. In your emacs distribution, get into the `bin` folder, and double-click on `runemacs` to start emacs. Emacs starts, with an icon shown on the taskbar 
2. Now, right-click on the icon on the taskbar, and click on "pin to taskbar"
3. Right-click this icon again, and move up to `emacs` menu-option, and right-click that again. Select "Properties"
4. In the "Properties", change the target to run `runemacs` instead of `emacs` that you'll see there. **Very important is to keep the rest of the path as it is!**

Yes, it requires all these steps in this order to have the best "pin to taskbar" experience. A simple "pin to taskbar" with following the other (one-time) steps will show two icons on the taskbar everytime emacs is started.

## Adding emacs to context-menu
**NOTE: For this to work, you should have already followed the steps mentione in "Starting Emacs as a server" above.**

If you would just like to use emacs to edit files, and would like to access emacs via a context menu, all you have to do is to edit the `addtomenu` file that you see in this repo to change all the paths to emacs to the one that you have in your PC, and then double-click this file to add some registry information. After do this, you will see two menu items in your context-menu: one that starts a new emacs for editing files, and one that simply allows you to use an existing emacs instance to edit a file.

If your emacs is in `c:\tools\emacs` directory, then, the file `addtomenu` already contains this path: simply double-click that to add these menu-items in your context-menu.

# Color themes
The popular package color-theme is included with the configuration. The default color theme is as set in `loadext.el` file.

To choose another color theme:

- Type `M-x color-theme-select`
- In the buffer that gives a list of color themes, test your theme by simply moving your cursor on a color-theme, and pressing `<ENTER>`
- Once satisfied with a specific color theme, keeping the cursor on the selected theme, press `?` - you will now see information on the chosen color theme.
- The name of the color theme that you can use will be mentioned in the information. Simply add this in the `<emacshome>/.emacsuser` file. Example:

   `(color-theme-pok-wog)`
   
- Of course, you could also replace the default color theme in `loadext.el` file with your chosen theme - in that case, if you pull in new updates to your `.emacs.d` folder, you will overide the setting.

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
   
There are so many interesting emacs packages that can be installed to make your emacs experience very good. One of the many such interesting package is: [magit](https://magit.vc/) - a magical git interface. To install this in your emacs installation, just do this:

    M-x package-install RET magit RET

Keybinding for `magit` is already configured in the settings; to invoke magit, just use: `c-x g`. To know how to use magit for working with git, check out the official [magit website](https://magit.vc/).

All installed packages get into the directory `<emacshome>/.emacselpa`. These are not affected anytime you update this repo because this directory is outside the repository. You are free to install whatever packages you need.

All settings for package installation from ELPA sources are in the `load-melpa.el` file.

## Re-installation of packages that were already installed before
Every package that is installed gets into the `<emacshome>/.emacselpa` directory, and an entry to that effect gets into the custom.el file. If, for whatever reason you lose your `<emacshome>/.emacselpa` directory, and need to re-install the packages again, follow the one-time steps of installing the GNU GPG keys above, and then:

    M-x package-install-selected-packages RET
   
This will re-install all packages back into the `<emacshome>/.emacselpa` directory.

# Org-mode Todo workflows
Of course, a lot of this section is very subjective: the workflow I mention here is what I use for maintaining my Todos.

As a developer, we have many demands to fulfill - each from various projects that we are involved in. Some of these todos are those that we make a note-of ourselves, and some of them come to us from other sources - our bosses, colleagues, friends (eg: in an opensource collaboration), or even from our family :-)

What other best tool do we have when compared to our dear-old Emacs? With org-mode, we organise our lives in plain-text!

The default workflow for all our todos as configured by the org-mode settings (see below) goes like this:

- All captured todos get into a todo file in the default state `TODO`. Capture is configured to be done with `C-c c`.
- When we begin working on them, we move them to `INPROGRESS`. Moving a todo to a state forward (in this case, from `TODO` to `INPROGRESS`) is done using `S-right`.
- If this todo has many steps, they are added as sub-entries. Default state of these added sub-entries are also `TODO`.
- Some of these sub-entries may actually become the `NEXT` thing to do with respect to the original `INPROGRESS` todo. If the `INPROGRESS` todo is already self-contained, it becomes the `NEXT` action itself.
- When time comes to work on a `NEXT` action, it gets to be a task to be done `TODAY`. Of course, it remains at `TODAY` until it is done OR...
  - If it needs a dependent action to be done (eg, your code is to be reviewed by another collegue before checking in), it gets `WAIT`ing.
  - If it is no longer relevant (eg: deadline is passed, and your boss is angry at you) - your task gets `CANCELLED`.
  - May be it is not very important now, but still needs to be in your radar until you are satisfied to restart it, or cancel it - so it is `DEFERRED`.
- From any of the above states, to go back to the previous state, use `S-Left`.

You can either follow the same workflow, or of course, change it to your liking - see org-mode settings below.

## Org-mode - settings
Well, most of the settings are directly to use the org-mode very effectively. All the org-mode settings are in the file `orgsettings.el`. On default, all the org-mode files are to be stored in the directory `<emacshome>/.notes` - and this can be changed by changing the value of the variable `notesdir` in `.emacs`.

To change the behaviour of orgmode, either change the settings in this file, or, override them by putting the settings in your own `.emacsuser` file in the home directory. The advantage of putting it in the `.emacsuser` is that you can update the repo for new settings, without the fear of overwriting your own settings.

# Calendar and diary
All the calendar and diary settings get into `caldiary.el`.

We have some customisations for the calendar and diary too. Most importantly, for the calendar (which in our configuration is bound to `c-c v`, as expected, in `keybindings.el`), week numbers are displayed. The week also starts from Monday, with the weekends put at the end.

Diary is bound to `c-c d` - again, done in `keybindings.el`. Diary file is searched in the same directory as your notes: on default, the file ~/.notes/diary is used. This location can be changed in `init.el`. The first time diary is used, this file needs to be created. 

# Other files and directories
`extensions` - Where you can drop other extensions you want. The file `loadext.el` is for adding all the auto-load statements for loading the dropped extensions. It also loads the color-theme.

`mycode` - Any custom code you have developed yourself can get in here.

`elpa` - All packages installed ia the `M-x package-install` goes into this directory.

# Dynamically created directories
The autosaves of emacs get into `<emacshome>/.emacsautosaves` and all the emacs backups get into `<emacshome>/.emacssaves`. These directories are automatically created when you use emacs for the first time. By moving the autosaves and backups to this location, we will avoid having such files strewn in all our filesystem locations. What will still be created in the same directory as your opened file is the lock file created by emacs (starting with .#) to avoid multiple instances of emacs accessing the same file. You can switch off creation of such lock files by uncommenting the line that mentions so in `init.el`.

# Comments in the setting files
All the *.el files in the repo have lots of comments - so it is easy to change the settings as hinted by the comments. Feel free to make this your own!
