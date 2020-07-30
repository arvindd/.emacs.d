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

    ;; GPG key to use for encryption
    ;; Either the Key ID or set to nil to use symmetric encryption.
    (setq org-crypt-key nil)
))
