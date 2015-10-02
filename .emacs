;; --------------------------------------------------------------
;; **************************************************************
;; ********** Emacs initial File ********************************
;; **************************************************************
;; --------------------------------------------------------------


;;{{{================= Gerete by Custom ============================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	 [default default default italic underline success warning error])
 '(ansi-color-names-vector
	 ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminus" :foundry "xos4" :slant normal :weight bold :height 105 :width normal))))
 '(buffer-menu-buffer ((t (:weight bold)))))
;;}}}


;;{{{================= things I insert ==============================

;;{{{ **************** marmalde ***************
(require 'package)
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
        package-archives )
  (push '("melpa" . "http://melpa.milkbox.net/packages/")
        package-archives)
  (push '("org" . "http://orgmode.org/elpa/")
        package-archives)
  (push '("gnu" . "http://elpa.gnu.org/packages/")
        package-archives)
  (package-initialize)
;;}}}

;;{{{ **************** install all packages I use ***************

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(defun install-all () (interactive)
			 (or
				(require-package 'ace-jump-mode)
				(require-package 'auto-complete)
				(require-package 'evil)
				(require-package 'evil-leader)
				(require-package 'evil-nerd-commenter)
				(require-package 'evil-numbers)
				(require-package 'evil-surround)
				(require-package 'evil-tabs)
				(require-package 'fill-column-indicator)
				(require-package 'flymake)
				(require-package 'flymake-cursor)
				(require-package 'folding)
				(require-package 'helm)
				(require-package 'indent-guide)
				(require-package 'linum-relative)
				(require-package 'multiple-cursors)
				(require-package 'php-mode)
				(require-package 'yasnippet)
				))
;;}}}


;;{{{ **************** Evil mode ***************

(require 'evil)
(evil-mode 1)

;;{{{ -------------------- for work properly --------------------
;; require for evil folding
(add-hook 'prog-mode-hook 'hs-minor-mode)
;;}}}

;;{{{ ----------------- keys for diferent states ---------------
(setq evil-emacs-state-cursor '("orange" box))
(setq evil-normal-state-cursor '("red" box))
(setq evil-visual-state-cursor '("yellow" box))
(setq evil-insert-state-cursor '("green" bar))
(setq evil-replace-state-cursor '("grey" box))
(setq evil-operator-state-cursor '("red" hollow))
;;}}}

;;{{{ ----------------- evil leader ---------------
(global-evil-leader-mode)
(evil-leader/set-leader "ç")
;;}}}

;;{{{ ----------------- evil-tabs (manager tabs) ---------------
(global-evil-tabs-mode t)
;;}}}

;;{{{ ----------------- evil-numbers ---------------
(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
;;}}}

;;{{{ ----------------- evil-surround ---------------
(require 'evil-surround)
(global-evil-surround-mode 1)
;;}}}

;;}}}


;;{{{ ******************** complition ********************

;;{{{ -------------------- auto-complit --------------------
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(add-hook 'text-mode-hook (lambda() (auto-complete-mode)))
(add-hook 'prog-mode-hook (lambda() (auto-complete-mode)))
;;}}}

;;{{{ ------------------- semantic to auto-complit ---------------------
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
;;}}}

;;{{{ -------------------- yasnippet --------------------
(require 'yasnippet)
(yas-global-mode 1)
;;}}}

;;{{{ -------------------- auto-complit-c-headers --------------------
;(defun my:ac-c-header-init()
;  (require 'auto-complete-c-headers)
;  (add-to-list 'ac-sources 'ac-sources-c-headers)
;  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../../include/c++/5.2.0")
;  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../../include/c++/5.2.0/x86_64-unknown-linux-gnu")
;  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../../include/c++/5.2.0/backward")
;  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/include")
;  (add-to-list 'achead:include-directories '"/usr/local/include")
;  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/include-fixed")
;  (add-to-list 'achead:include-directories '"/usr/include")
;)
;(add-hook 'c++-mode-hook 'my:ac-c-header-init)
;(add-hook 'c-mode-hook 'my:ac-c-header-init)
;;}}}

;;}}}


;;{{{ ******************** Other packages ********************

;;{{{ ----------------- Power line ----------------

(add-to-list 'load-path "~/.emacs.d/el_files/powerline")
(require 'powerline)
(powerline-evil-theme)
(display-time-mode t)
;;}}}

;;{{{ ----------------- Relative line numbers ---------------
(require 'linum-relative)
(linum-relative-on)
(global-linum-mode)
;;}}}

;;{{{ ----------------- flymake ---------------
(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(eval-after-load 'flymake '(require 'flymake-cursor))
;;}}}

;;{{{ ----------------- multiple cursors ---------------
(require 'multiple-cursors)
;;}}}

;;{{{ ----------------- nerd-commenter ---------------
(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)
;;}}}

;;{{{ ----------------- helm ---------------
(require 'helm-config)
(helm-mode 1)
;; helm M-x
(global-set-key (kbd "M-x") 'helm-M-x)
;;}}}

;;{{{ ----------------- ace-jump (easy move) ---------------
(require 'ace-jump-mode)
;; key bindings
;;}}}

;;{{{ ----------------- fill column ---------------
(require 'fill-column-indicator)
(add-hook 'text-mode-hook (lambda ()
                            (fci-mode)
                            (set-fill-column 82)))
(add-hook 'prog-mode-hook (lambda ()
                            (fci-mode)
                            (set-fill-column 82)))
;;}}}

;;{{{ -------------------- folding-mode --------------------
(load "folding" 'nomessage 'noerror)
(folding-mode-add-find-file-hook)
(folding-add-to-marks-list 'emacs-lisp-mode ";;{{{" ";;}}}" nil t)
(add-hook 'prog-mode-hook (lambda() (folding-mode)))
;;}}}

;;{{{ -------------------- indent-guide --------------------
(require 'indent-guide)
(indent-guide-global-mode)
;;}}}

;;{{{ -------------------- whitespace-mode --------------------
(global-whitespace-mode)
;; make whitespace-mode use just basic coloring
(setq whitespace-style
	(quote (spaces tabs space-mark tab-mark)))
;;}}}
;;}}}


;;{{{ ****************** functions **************************


;;{{{ -------------------- move line --------------------
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))
;;}}}


;;{{{ -------------------- esc quits --------------------

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
;; key bindings
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
;;}}}

;;}}}


;;{{{ ******************* key bindings ********************


;;{{{ ----------------- evil-numbers ---------------
(evil-leader/set-key "+" 'evil-numbers/inc-at-pt)
(evil-leader/set-key "-" 'evil-numbers/dec-at-pt)
;;}}}

;;{{{ ----------------- Relative line numbers ---------------
;; relative/absolute lines
(evil-leader/set-key "l" 'linum-relative-toggle)
;;}}}

;;{{{ ----------------- multiple cursors ---------------
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;}}}

;;{{{ ----------------- ace-jump (easy move) ---------------
(evil-leader/set-key "gw" 'ace-jump-word-mode) ; çw for Ace Jump (word)
(evil-leader/set-key "gl" 'ace-jump-line-mode) ; çl for Ace Jump (line)
(evil-leader/set-key "gc" 'ace-jump-char-mode) ; çc for Ace Jump (char)define-key global-map (kbd "C-ç w") 'ace-jump-word-mode)
;;}}}

;;{{{ -------------------- folding-mode --------------------
(evil-leader/set-key "f" 'folding-toggle-show-hide) ; key bindin
;;}}}

;;{{{ -------------------- move line --------------------
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
;;}}}

;;{{{ -------------------- hide/show --------------------
(evil-leader/set-key "s" 'hs-show-block) 
(evil-leader/set-key "S" 'hs-show-all) 
(evil-leader/set-key "h" 'hs-hide-block) 
(evil-leader/set-key "H" 'hs-hide-all) 
;;}}}
;;}}}


;;{{{ ******************* other settings ********************


(setq-default evil-shift-width 2) ; evil shift(tab) 2 spaces
(setq-default tab-width 2) ; tab with 2 spaces
(setq backup-directory-alist `(("." . "~/Documents/swap_files"))) ; directory to save beckup files
(menu-bar-mode 0) ; remave menu bar
(show-paren-mode 1) ; match parents, breckets, etc
(if (window-system) nil (load-theme 'tango-dark) )
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;;}}}
;;}}}
