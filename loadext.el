;;;; This file is for auto-enabling all extensions we use
;;

;; Get our color-theme right
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
        (color-theme-resolve)))

;; Enable automatic encryption and decryption
(require 'epa-file)
(epa-file-enable)

;; Specifically for org-mode, enable crypting individual entries
(require 'org-crypt)

;; Enable docker mode when a docker-file is opened.
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))


