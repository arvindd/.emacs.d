;;;; Emacs initialisation file
;;
;; AUTHOR: Arvind Devarajan
;; CREATED: Not very precise, but in the year 2010
;;

;; Where all the emacs file will be kept. Typically this
;; is the home directory. The only emacs initialisation file
;; there is the .emacs file.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq emacshome "~")

;; Depending on the type of the system, keep your emacs.d directory.
;; It is here that rest of the files will get in. This is a useful
;; way to share the same emacs.d directory with two different systems.
(if (eq system-type 'windows-nt)
  (setq init-file-dir (concat emacshome "/.emacs.d"))
  (setq init-file-dir (concat emacshome "/.emacs.d")))

;;; Rest of the variables that will be used in the init.el

;; We do not want all the backup files created by emacs (begining
;; with "~" to be spread across various places. We will keep a place
;; where emacs can store all those vital backups.
;; MOST IMPORTANT: End the directory name with a "/"
(setq backupsdir (concat emacshome "/.emacssaves/"))

;; Similarly, we want all our autosave files to be stored in a different
;; directory. On default, emacs stores remote files in temp directory; we
;; will be changing that location - but for all files.
;; MOST IMPORTANT: End the directory name with a "/"
(setq autosavesdir (concat emacshome "/.emacsautosaves/"))

;; This is where all the elpa packages will be installed.
;; We keep this outside the .emacs.d directory so that individuals
;; can decide where they would want their packages should go in.
(setq elpa-package-dir (concat emacshome "/.emacselpa/"))

;; Where you want to keep all the org-mode files
(setq plansdir (concat emacshome "/.plans/"))

;; Entry point for all the rest of the initialisations
(load-file (concat init-file-dir "/init.el"))

;; Optional custom settings, which can override settings in init.el
;; If this file is present, it is loaded so that users can have settings
;; in this file can either override those in init.el, or can add additional
;; settings not present in init.el. This can be used for setting, for example,
;; other color-themes, more org-settings, etc.
;;
;; One very interesting way to use this is to have a function to start the
;; emacs server in this file:
;;
;; (server-start)
;;
;; By doing so, and by also opening files using emacsclient (instead of emacs), it is possible
;; to have just a single instance of emacs opening all the files. To enable the first
;; instance uses emacs even when emacsclient is used for opening, make sure to set the
;; environment variable ALTERNATE_EDITOR pointing to emacs (or runemacs on Windows). This
;; is especially useful in a GUI environment (on Windows, or on GNOME/KDE interface on Linux):
;; simply associating text files to be opened by emacsclient, it is possible to "double-click"
;; the file, and it opens automatically in a running instance of emacs (or starts the first
;; instance of emacs).
(setq user-emacs-file (concat emacshome "/.emacsuser"))
(if (file-readable-p user-emacs-file) (load user-emacs-file))
