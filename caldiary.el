;;;; Calendar and diary settings
;;
;; All settings for calendar and diary go here.
;;

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
