;;;; Org settings
;;
;; All the Org settings go in this file.
;;

(add-hook 'org-mode-hook
  (lambda ()
    ;; Make all files (except the encrupted gpg files) in the plansdir also as agenda files
    ;; The regex used here is pretty complex: so an explanation is necessary. Just so that
    ;; we remove the noise due to backslashes, here is the "non-backslashed" version:
    ;;
    ;; ^(.$|[^.].+|\.[^#].+)(\.org)$
    ;;
    ;; The first group has three options:
    ;; 1. A file with just 1 character in its name
    ;; 2. A file not starting with a "."
    ;; 3. A file starting with ".", and not followed by a "#" in its name
    ;; 
    ;; (2) and (3) above are to avoid matching an emacs lock file (lock files start
    ;; with a ".#", and so we do not want these files to be added as agenda files).
    ;;
    ;; The second group is to make sure that all files matched have the extension ".org".
    (setq org-agenda-files (directory-files-recursively plansdir "^\\(.$\\|[^.].+\\|\\.[^#].+\\)\\(\\.org\\)$"))
    
    ;; To also include encrypted gpg files as agenda files, comment the above line,
    ;; and uncomment the following line. The regex is similar to the above, except that
    ;; we pull out the "." preceding the extension out of the second group, so that we
    ;; can easily match both "org" and "gpg" extensions for files.
    ;;
    ;; (setq org-agenda-files (directory-files-recursively plansdir "^\\(.$\\|[^.].+\\|\\.[^#].+\\)\\.\\(org\\|gpg\\)$"))

    ;; Enable visual line mode. Very helpful for capture buffers.
    (setq visual-line-mode t)
    (setq truncate-lines nil)

    ;; Keep all clock times across emacs sessions
    (setq org-clock-persist 'history)
    (org-clock-persistence-insinuate)

    ;; Emacs diary integration: uncomment the following to put all diary entries also
    ;; in the agenda
    ;; (setq org-agenda-include-diary t)

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
    (setq org-enforce-todo-checkbox-dependencies t)    
    
    ;; GPG key to use for encryption
    ;; Either the Key ID or set to nil to use symmetric encryption.
    (setq org-crypt-key nil)

    ;; Todo keyword sequences
    ;; TODO: t - Initial state: when a todo is captured and not yet processed.
    ;; INPROGRESS: p - Started working on. We use this only for "top-level" todos
    ;;                 that have some next actions defined - these will be shown in the
    ;;                 agenda quick-view (see below) - but cannot be changed to "DONE"
    ;;                 unless all the TODOs in the levels below this are DONE.
    ;; NEXT: n - Next action defined for a specific TODO. Typically is defined at a
    ;;           level below a main TODO (which gets to the INPROGRESS state). Sometimes,
    ;;           small TODOS (which are top-level) are directly made as NEXT actions. 
    ;; TODAY: y - Marked to be worked-on today. Could be also the state of task that
    ;;            was marked to be worked-on some day prior to today, but to be continued
    ;;            to be worked on today. Todos that were NEXT get into this state when you
    ;;            decide to work on them.
    ;; WAITING: w - Task that is delegated to somebody / blocking on something.
    ;;              Need to wait until it is done.
    ;; DONE: d - Done and closed
    ;; CANCELLED: c - Cancelled; no need to work on this.
    ;; DEFFERED: f - Todos that are not closed, but are deferred to someday in the future.
    ;; Additionally, we have the following note/timestamp-entry for state-transitions:
    ;; -> <TODO>: Log timestamp of when this was started
    ;; <ANY> -> WAIT: Log notes and timestamp of when this went into WAIT state
    ;; <ANY> -> DONE: Log timestamp when entering the state
    ;; <ANY> -> CANCELLED: Log notes and timestamp
    (setq org-todo-keywords
	  '((sequence "TODO(t!)" "INPROGRESS(p!)" "NEXT(n!)" "TODAY(y!)" "WAIT(w@)"
		      "|" "DONE(d!)" "CANCELLED(c@)" "DEFERRED(f@)")))

    ;; How do we want to TODOs to be looking?
    (setq org-todo-keyword-faces
	  '(("TODO" . org-warning)
	    ("INPROGRESS" . "gray")	    
	    ("NEXT" . "cyan")
	    ("TODAY" . "yellow")
	    ("WAITING" . "red")
	    ("DONE" . (:foreground "green" :weight bold))
	    ("CANCELLED" . (:foreground "blue" :weight bold))
	    ("DEFERRED" . (:foreground "magenta" :weight bold))))

    ;; Our custom agenda view: we only want those in TODO or WAIT state
    ;; when we ask for today's agenda.
    (setq org-agenda-custom-commands
       '(("q" "Quick view of agenda and incomplete todos"
	  ((agenda "" ((org-agenda-span 'day)))
	   (todo "TODAY" nil)
	   (todo "NEXT" nil)     
	   (todo "WAIT" nil)
	   (todo "DEFERRED" nil)
	   (todo "INPROGRESS" nil)	   
	   (todo "TODO" nil))	 	 
	 nil)))
    
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

    ;; Finally, on a new org-mode file, create the header
    ;; with some initial buffer variables.
    (setq make-header-hook '(make-org-header))
    (auto-make-header)
    
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

(defsubst make-org-header ()
  "Insert header in the orgmode"
  (insert "#+TITLE: \n" "#+STARTUP: indent\n" "#+STARTUP: showall\n" "#+CATEGORY: "
	  (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))) "\n\n")
  (setq return-to 10))
