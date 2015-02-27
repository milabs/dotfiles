(require 'cl)
(require 'package)

;;
;; add package archives
;;

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;
;; add required packages list
;;

(defvar required-packages
  '( smex magit window-number ) "A list of packages to ensure are installed at launch")

(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(require 'smex)
(global-set-key "\M-x" 'smex)

(require 'magit)
(global-set-key "\C-x\C-z" 'magit-status)

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(require 'ido)
(ido-mode t)

;;
;; GUI customization
;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(global-set-key "\C-x\C-b" 'electric-buffer-list)

(when (member "Liberation Sans Mono" (font-family-list))
  (add-to-list 'initial-frame-alist '(font . "Liberation Sans Mono"))
  (add-to-list 'default-frame-alist '(font . "Liberation Sans Mono")))

(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

;; C style

(defun my-c-common-hook ()
  (progn
    (linum-mode)
    (show-paren-mode)
    (c-set-style "linux")))

(add-hook 'c-mode-common-hook 'my-c-common-hook)

;; disable backups

(setq make-backup-files nil)
(setq auto-save-default nil)