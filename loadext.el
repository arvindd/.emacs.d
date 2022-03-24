;;;; This file is for auto-enabling all extensions we use
;;

;; Enable encryption for org-mode
(require 'org-crypt)

;; Enable automatic file headers
(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)

(autoload 'auto-make-header "header2")
;; (add-hook 'emacs-lisp-mode-hook 'auto-make-header)
;; (add-hook 'c-mode-common-hook   'auto-make-header)

;; Enable docker mode when a docker-file is opened.
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))


