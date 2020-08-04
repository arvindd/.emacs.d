;;;; Org settings
;;
;; All the Org settings go in this file.
;;

(add-hook 'org-mode-hook
  (lambda ()
    ;; Let RET follow links (like  C-c-o)
    (setq org-return-follows-link t)

    ;; Enable automatic crypting of org files
    ;; All entries with tag ":crypt:" will be encrypted
    ;; If you want to change this tag name, uncomment the following
    ;; line, and replace "crypt" with your own tag name
    ;; (setq org-crypt-tag-matcher "crypt")
    (org-crypt-use-before-save-magic)
    (setq org-tags-exclude-from-inheritance (quote ("crypt")))

    ;; Enforce depedencies in todos. Parent tasks cannot be made to DONE unless
    ;; all their children are made to DONE.
    (setq org-enforce-todo-dependencies t)
    
    ;; GPG key to use for encryption
    ;; Either the Key ID or set to nil to use symmetric encryption.
    (setq org-crypt-key nil)

    ;; Todo keyword sequences
    ;; TODO: t - Marked to be done some day
    ;; TODAY: y - Marked to be worked-on today. Could be also the state of task that
    ;;            was marked to be worked-on some day prior to today, but to be continued
    ;;            to be worked on today.
    ;; WAITING: w - Task that is delegated to somebody / blocking on something.
    ;;              Need to wait until it is done.
    ;; DONE: d - Done and closed
    ;; CANCELLED: c - Cancelled; no need to work on this.
    (setq org-todo-keywords
	  '((sequence "TODO(t)" "TODAY(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

    ;; How do we want to TODOs to be looking?
    (setq org-todo-keyword-faces
	  '(("TODO" . org-warning) ("TODAY" . "yellow") ("WAITING" . "red")
	    ("DONE" . (:foreground "green" :weight bold))
	    ("CANCELLED" . (:foreground "blue" :weight bold))))

    ;;;;;;;;;;;;;;;;;;;;; Keybindings ;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Decrypt encrypted headlines
    (define-key org-mode-map (kbd "C-c b") 'org-decrypt-entry)

    ;; Insert a hyperlink
    (define-key org-mode-map (kbd "C-c l") 'org-store-link)

    ;; Show the agenda view
    (define-key org-mode-map (kbd "C-c a") 'org-agenda)

    ;; Capture
    (define-key org-mode-map(kbd "C-c c") 'org-capture)    
))
