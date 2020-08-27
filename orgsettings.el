;;;; Org settings
;;
;; All the Org settings go in this file.
;;

(add-hook 'org-mode-hook
  (lambda ()
    ;; Make all files (except the encrupted gpg files) in the plansdir also as agenda files
    (setq org-agenda-files (directory-files-recursively plansdir "\\.org$"))
    ;; To also include encrypted gpg files as agenda files, comment the above line,
    ;; and uncomment the following line.
    ;; (setq org-agenda-files (directory-files-recursively plansdir "\\.\\(org\\|gpg\\)$"))

    ;; Enable visual line mode. Very helpful for capture buffers.
    (setq visual-line-mode t)
    (setq truncate-lines nil)

    ;; Keep all clock times across emacs sessions
    (setq org-clock-persist 'history)
    (org-clock-persistence-insinuate)

    ;; Emacs diary integration: put all diary entries also in the agenda
    (setq diary-file (concat org-directory "diary"))
    (setq org-agenda-include-diary t)

    ;; In which files do we want to refile entries?
    ;; We allow all agenda files to be refile targets too so that entries can be freely
    ;; moved around the files we create. We include the file in which refile was invoked
    ;; and all agenda files - upto a max-level of 2 in the headings.
    (setq gpg-files (directory-files-recursively plansdir "\\.gpg$"))
    (setq org-refile-targets '((nil :maxlevel . 2)
			       (gpg-files :maxlevel . 2)
			       (org-agenda-files :maxlevel . 2)))
    (setq org-refile-use-outline-path 'file)
    (setq org-refile-allow-creating-parent-nodes 'confirm)

    ;; We want the mini-buffer to accept spaces. This is useful in
    ;; inserting links and completions in refiles.
    (define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)

    ;; Let RET follow links (like  C-c-o)
    (setq org-return-follows-link t)

    ;; Nice to have shift also selecting. This means, we can use S-RIGHT
    ;; S-LEFT, S-UP, S-DOWN for selecting text, and use C-* keys for
    ;; regular org-mode functionalities
    (setq org-support-shift-select t)

    ;; Which is our capture file? This is where quick notes and todos
    ;; will be captured into.
    (setq org-default-notes-file (concat org-directory "roster.org"))

    ;; Where do capture attachments get in?
    (setq org-attach-id-dir (concat org-directory "attachments"))

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
    ;; Additionally, we have the following note/timestamp-entry for state-transitions:
    ;; -> <TODO>: Log timestamp of when this was started
    ;; <ANY> -> WAIT: Log notes and timestamp of when this went into WAIT state
    ;; <ANY> -> DONE: Log timestamp when entering the state
    ;; <ANY> -> CANCELLED: Log notes and timestamp
    (setq org-todo-keywords
	  '((sequence "TODO(t!)" "TODAY(n!)" "WAIT(w@)"
		      "|" "DONE(d!)" "CANCELLED(c@)")))

    ;; How do we want to TODOs to be looking?
    (setq org-todo-keyword-faces
	  '(("TODO" . org-warning) ("TODAY" . "yellow") ("WAITING" . "red")
	    ("DONE" . (:foreground "green" :weight bold))
	    ("CANCELLED" . (:foreground "blue" :weight bold))))

    ;; Org capture templates
    (setq roster-file org-default-notes-file)
    (setq journal-file (concat org-directory "journal.org"))
    (setq ideas-file (concat org-directory "ideas.org"))    
    (setq org-capture-templates
	  '(("t" "Todo" entry (file+headline roster-file "Todos")
	     "* TODO %?\n- State \"TODO\"                         %U\n %i\n")
	    ("i" "Idea" entry (file+headline ideas-file "Ideas")
	     "* %u %^{Enter title}\n%?\n  %i\n")
	    ("j" "Journal" entry (file+olp+datetree journal-file)
	     "* [%<%H:%M>] %?\n  %i\n")))
    
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
