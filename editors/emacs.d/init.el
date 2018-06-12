(package-initialize)
(require 'org)

;; To tangle and compile init file
(unless (file-exists-p (concat user-emacs-directory "init-org.elc"))
    (find-file (concat user-emacs-directory "init-org.org"))
    (org-babel-tangle)
    (load-file (concat user-emacs-directory "init-org.el"))
    (byte-compile-file (concat user-emacs-directory "init-org.el"))
)

(load-file (concat user-emacs-directory "init-org.elc"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
