;;;; Emacs initialisation file
;;
;; AUTHOR: Arvind Devarajan
;; CREATED: 2010 CE
;;

;; Where all the emacs file will be kept. Typically this
;; is the home directory. The only emacs initialisation file
;; there is the .emacs file.

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
(setq notesdir (concat emacshome "/.notes/"))

;; Optional custom settings, which become effective before
;; any other settings are loaded in. Having any settings
;; here will make sure that they are not overwritten when
;; a new version of .emacs.d is pulled in.
;;
;; All settings (such as proxy settings, automatic package
;; installs, etc. can be put in this file. Sample .emacsuserpre
;; file is also found in this repository)
(setq user-pre-emacs-file (concat emacshome "/.emacsuserpre"))
(if (file-readable-p user-pre-emacs-file) (load user-pre-emacs-file))

;; Entry point for all the rest of the initialisations
(load-file (concat init-file-dir "/init.el"))

;; Optional custom settings (similar to .emacsuserpre), which can override 
;; settings in init.el. If this file is present, it is loaded so that users 
;; can have settings in this file can either override those in init.el, or 
;; can add additional settings not present in init.el. This can be used for
;; setting, for example, other color-themes, more org-settings, etc.
;;
;; Sample .emacsuserpost file is also found in this repository.
(setq user-post-emacs-file (concat emacshome "/.emacsuserpost"))
(if (file-readable-p user-post-emacs-file) (load user-post-emacs-file))
