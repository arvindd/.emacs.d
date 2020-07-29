(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
          (color-theme-resolve)))

