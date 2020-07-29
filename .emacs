
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(if (eq system-type 'windows-nt)
  (setq init-file-dir "D:/vbox/shared/.emacs.d")
  (setq init-file-dir "~/.emacs.d"))
(load-file (concat init-file-dir "/init.el"))
