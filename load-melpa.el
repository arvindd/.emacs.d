(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))

  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)

  ;; Melpa stable packages
  ;; Uncomment this if you want to have packages from the stable branch. Note that
  ;; melpa maintainers themselves do not use melpa stable.
  ;; (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )

(setq package-user-dir elpa-package-dir)

(package-initialize)

;; Install all packages that were originally installed
;; and need to be installed again.
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)