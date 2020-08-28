;;;; Calendar and diary settings
;;
;; All settings for calendar and diary go here.
;;

;; Where do all the diary entries go?
(setq diary-file (concat plansdir "diary"))

;; We would like to mark calendar days where there are diary entries.
(setq calendar-mark-diary-entries-flag t)

;; Add week numbers in the calendar mode
(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
		    :height 1.0 :foreground "salmon")
(setq calendar-week-start-day 1
      calendar-intermonth-text
      '(propertize
	(format "%2d"
	    (car
	     (calendar-iso-from-absolute
	      (calendar-absolute-from-gregorian (list month day year)))))
	       'font-lock-face 'calendar-iso-week-face))
