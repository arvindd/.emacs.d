;; Add paths for various lisp extensions
(defun add-path (p) "Adds a path to the load-path" (add-to-list 'load-path  (concat init-file-dir p)))

;; Add other paths with add-path
(add-path "/extensions")
(add-path "/mycode")
(add-path "/color-theme")

;; Frame size
(add-to-list 'default-frame-alist '(height . 30))
(add-to-list 'default-frame-alist '(width . 85))

;; Customise where you want all the initialisation files go
(setq user-init-file (concat (file-name-directory load-file-name) ".emacs"))
(setq custom-file (concat init-file-dir "/custom.el"))
(if (file-readable-p custom-file) (load custom-file))

;; Just so tht we don't crowd this init file with many loads,
;; we keep all the loadable modules in this file separately
(setq load-file (concat init-file-dir "/loadext.el"))
(if (file-readable-p load-file) (load load-file))

;; Many packages come from MELPA, so we add the infra here
(setq load-melpa-file (concat init-file-dir "/load-melpa.el"))
(if (file-readable-p load-melpa-file) (load load-melpa-file))

;; We want all emacs back-up files to get into one directory
;; We basically want all of them to get into the backupsdir.
(setq backup-directory-alist `(("." . ,backupsdir)))

;; And, since we now have all of the back-ups in one directory, we'll
;; also make that we will keep some old versions too.
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Finally, automatically show org file
;; Show this only if we do not have any other
;; arguments on the command line
(setq plan-file (concat plansdir "/plan.org"))
(if (file-readable-p plan-file)
 (if (eq (length command-line-args) 1)
   (setq initial-buffer-choice plan-file)))
