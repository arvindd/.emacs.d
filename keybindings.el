;; All non-org keybindings that we would like to have
;; All org-keybindings are in orgsettings.el

;; Enable magit
(define-key global-map (kbd "C-x g") 'magit-status)
(define-key global-map (kbd "C-c v") 'calendar)
(define-key global-map (kbd "C-c d") 'diary)
