;; Add paths for various lisp extensions
(defun add-path (p) "Adds a path to the load-path" (add-to-list 'load-path  (concat init-file-dir p)))

;; Add other paths with add-path
(add-path "/extensions")
(add-path "/mycode")
(add-path "/color-theme")

;; We'll inhibit the startup screen: this is especially useful when we double-click a
;; file from the file explorer.
(setq inhibit-startup-screen t)

;; We normally want the lock files to be created, because that is the only way
;; emacs can know if you are double-editing a file (i.e., opening up another emacs
;; for editing a file while you are already editing it in another emacs instance.
;; However, such lock files are created with the name .#<filename> in the same
;; directory as the file. This can become a problem when you use git, etc. - git
;; will show these files as "added" in a directory. The best solution to the git-problem
;; is to globally ignore files that have the pattern .#<filenname>.
;; To disable creation of lock files completely, uncomment the following line:
;; (setq create-lockfiles nil)

;; Frame size
(add-to-list 'default-frame-alist '(height . 30))
(add-to-list 'default-frame-alist '(width . 85))

;; Enable word-wrap. This will respect newlines - so helpful when killing long lines.
(setq-default word-wrap t)

;; Let's set our default theme 
;; Since terminals are not very good in handling colours, we have a minimalistic 
;; dark theme for terminals. For graphic displays (such as X or Windows systems), 
;; light-blue is pleasing eyes. Of course, this is opiniated, and hence can be
;; overridden in the .emacsuserpost file!
(if (display-graphic-p)
  (load-theme 'light-blue)
  (load-theme 'misterioso))

;; Customise where you want all the initialisation files go
(setq user-init-file (concat (file-name-directory load-file-name) ".emacs"))
(setq custom-file (concat init-file-dir "/custom.el"))
(if (file-readable-p custom-file) (load custom-file))

;; Just so that we don't crowd this init file with many loads,
;; we keep all the loadable modules in this file separately
(setq ext-file (concat init-file-dir "/loadext.el"))
(if (file-readable-p ext-file) (load ext-file))

;; If there are any packages to be automatically installed
;; add them to the package-selected-packages so that melpa
;; load below considers these packages
(if (equal (boundp 'package-selected-packages) nil)
    (when (boundp 'auto-install-package-list)
      (setq package-selected-packages auto-install-package-list)
      (append package-selected-packages auto-install-package-list)))

;; Many packages come from MELPA, so we add the infra here
(setq load-melpa-file (concat init-file-dir "/load-melpa.el"))
(if (file-readable-p load-melpa-file) (load load-melpa-file))

;; All keybindings go into a separate file so that we do not
;; crowd this file.
(setq keybindings-file (concat init-file-dir "/keybindings.el"))
(if (file-readable-p keybindings-file) (load keybindings-file))

;; We want all emacs back-up files to get into one directory
;; We basically want all of them to get into the backupsdir.
(unless (file-exists-p backupsdir) (make-directory backupsdir))
(setq backup-directory-alist `(("." . ,backupsdir)))

;; Get our autosave files in a specific directory.
(unless (file-exists-p autosavesdir) (make-directory autosavesdir))
(setq auto-save-file-name-transforms `((".*" , autosavesdir t)))

;; And, since we now have all of the back-ups in one directory, we'll
;; also make that we will keep some old versions too.
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; All our org-mode settings are separated in another file as this can really
;; get crowded with timestamp formats, tags, etc.
(setq org-settings-file (concat init-file-dir "/orgsettings.el"))
(if (file-readable-p org-settings-file) (load org-settings-file))

;; All Calendar and Dairy settings go into this file
(setq caldiary-settings-file (concat init-file-dir "/caldiary.el"))
(if (file-readable-p caldiary-settings-file) (load caldiary-settings-file))

;; Finally, automatically show org file. Show this only if we do not have any other
;; arguments on the command line.
(setq plan-file (concat plansdir "plan.org"))
(setq org-directory plansdir)
(if (file-readable-p plan-file)
 (if (eq (length command-line-args) 1)
   (setq initial-buffer-choice plan-file)))
