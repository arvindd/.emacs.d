;;;; This file is for auto-enabling all extensions we use
;;

;; Get our color-theme right
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
        (color-theme-resolve)))

;; Enable encryption for org-mode
(require 'org-crypt)

;; Load magit for working with git
(require 'magit)

;; Enable docker mode when a docker-file is opened.
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))


