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
  '( magit ) "A list of packages to ensure are installed at launch")

(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(if (package-installed-p 'magit)
    (global-set-key "\C-x\C-z" 'magit-status))

;;
;; GUI customization
;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(global-set-key "\C-x\C-b" 'electric-buffer-list)

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