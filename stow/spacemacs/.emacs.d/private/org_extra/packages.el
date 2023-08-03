;;; packages.el --- org_extra layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <gabriel@GAMa>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst org_extra-packages
  '(
    org
    org-agenda
    org-super-agenda
    ))

(defun org_extra/post-init-org ()
  ; log chanches in state in LOGBOOK drawer
  (setq org-log-into-drawer t)
  ; fold all blocks in the start
  (setq org-hide-block-startup t)
  ; lists treated as low level headlines
  (setq org-cycle-include-plain-lists 'integrate)
  ; status of checkbox include the whole hierarchy
  (setq org-checkbox-hierarchical-statistics nil)
  ; change size and color of latex formula's font
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5))
  (setq org-format-latex-options
        (plist-put org-format-latex-options :foreground 'auto))
  ;; fix color handling in org-preview-latex-fragment
  (let ((dvipng--plist (alist-get 'dvipng org-preview-latex-process-alist)))
    (plist-put dvipng--plist :use-xcolor t)
    (plist-put dvipng--plist :image-converter '("dvipng -D %D -T tight -o %O %f")))
  ; allow letter in lists
  (setq org-list-allow-alphabetical t)
  ; do not indent when demoting header
  (setq org-adapt-indentation nil)
  ; allow the use of #+Bind for set variables during export
  (setq org-export-allow-bind-keywords t)
  ; capture destination file
  (setq org-default-notes-file "~/Dropbox/Org/notes.org")
  ; distace of tags
  (setq org-tags-column 0)
  ; faces for todo keywords
  (setq org-todo-keyword-faces
        '(("CANCEL" . (:foreground "red" :weight bold))
          ("REC*" . (:foreground "yellow" :weight bold))
          ("BLOCK" . (:foreground "white" :weight bold))))
  ; faces for priorities
  (setq org-priority-faces '((?A . (:foreground "yellow" :weight bold))))
  ; capture templates
  (setq org-capture-templates
        '(
          ("t" "Todo" entry (file+headline "" "Inbox")
           "* TODO %? [/]\n")
          ("T" "Todo on File" entry (file+headline "" "Inbox")
          "* TODO %? [/]\n  %i\n  %a")
          ("n" "Note" entry (file+headline "" "Inbox")
           "* %?\n")
          ("j" "Journal" entry (file+datetree "~/Dropbox/Org/journal.org")
           "\n* Entered on %U\n\n- relevant events: %^{EVE} \n- food: %^{FOOD} \n- good thing: %^{GOOD|nada} \n- bad thing: %^{BAD|nada} \n- health problems: %^{HEA|nenhum} \n- Am I doing my bast to be happy? %^{HAP|y|n} \n- gear: %^{GEA|4|3|5|2|1|6|0} \n- stars: %^{STA|0 -|1 *|2 **|3 ***|4 ****|5 *****|6 ******|}\n%?")
          ))
  )

(defun org_extra/post-init-org-agenda ()
  (setq org-agenda-files (list "~/Dropbox/Org"))
  (setq org-agenda-start-on-weekday 0) ; week starts on sunday
  (setq org-agenda-compact-blocks t)
  (setq org-agenda-use-time-grid nil) ; don not use time-grid by default
  (setq org-deadline-warning-days 3) ; warnig days before deadline
  (setq org-agenda-custom-commands '(
    ("x" "planing" (
      (tags "urgent|pin")
      (agenda "" ((org-agenda-start-day "+1d") (org-agenda-span 1)))))
    ("O" "main view" (
                      (tags "urgent|pin")
                      (agenda "" ((org-agenda-span 1)))))
    ("A" "main view (A)" (
                      (tags "urgent|pin")
                      (agenda "" ((org-agenda-span 1) (org-agenda-skip-function '(and (not (equal "A" (org-entry-get nil "PRIORITY"))) (point-at-eol)))))))
    ("o" "main view (-C)" (
                          (tags "urgent|pin")
                          (agenda "" ((org-agenda-span 1) (org-agenda-skip-function '(and (equal "C" (org-entry-get nil "PRIORITY")) (point-at-eol)))))))
  ))
)

(defun org_extra/init-org-super-agenda ()
  (use-package org-super-agenda
	  :defer t
	  :init (org-super-agenda-mode)
	  :config
		(setq org-super-agenda-groups '(
      (:name "Urgent" :tag "urgent" :deadline today :order 1
              :face (:foreground "yellow" :background "red"))
      (:name "Pin" :tag "pin" :order 2)
      (:name "Grid" :time-grid t
              :transformer (--> it
                    (replace-regexp-in-string "^.*:cal:.*$"
                    (lambda (s) (propertize s 'face '(:foreground "orange red")))
                    (replace-regexp-in-string "^.*:rem:.*$"
                                              (lambda (s) (propertize s 'face '(:foreground "gold")))
                                              it)
                    ))
              :order 4)
      ))
    ))

;;; packages.el ends here
