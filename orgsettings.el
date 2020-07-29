;;;; Org settings
;;
;; All the Org settings go in this file.
;;

(add-hook 'org-mode-hook
  (lambda ()
	    
      ;; Let RET follow links (like  C-c-o)
      (setq org-return-follows-link t)
))
