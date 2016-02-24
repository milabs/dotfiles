(require 'cl)
(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(unless (package-installed-p 'use-package)
  (message "%s" "Emacs is now installing \"use-package\"...")
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun emacs-d ()
  (user-emacs-directory))
(defun emacs-d-file (file)
  (concat user-emacs-directory file))
(defun emacs-d-dotfile (file)
  (concat user-emacs-directory "." file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/.emacs.secrets" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package paradox
  :ensure t)

(use-package projectile
  :init (progn
	  (projectile-global-mode))
  :config (progn
	    (setq projectile-keymap-prefix (kbd "C-c p")
		  projectile-completion-system 'default
		  projectile-enable-caching t
		  projectile-require-project-root nil))
  :ensure t)

(use-package ibuffer-projectile
  :init (add-hook 'ibuffer-hook
                  (lambda ()
                    (ibuffer-projectile-set-filter-groups)
                    (unless (eq ibuffer-sorting-mode 'alphabetic)
                      (ibuffer-do-sort-by-alphabetic))))
  :ensure t)

(use-package helm
  :config (progn
	    (require 'helm-config)
	    (setq helm-candidate-number-limit 100
		  helm-input-idle-delay 0.01
		  helm-yas-display-key-on-candidate t
		  helm-quick-update t
		  helm-M-x-fuzzy-match t
		  helm-M-x-requires-pattern nil
		  helm-ff-skip-boring-files t)
	    (helm-mode))
  :bind (("M-x" . helm-M-x)
	 ("C-c h" . helm-mini)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-b" . helm-buffers-list)
	 ("C-h a" . helm-apropos))
  :ensure t)

(use-package helm-projectile
  :ensure t)

(use-package magit
  :ensure t)

(use-package hl-line
  :init (progn
	  (global-hl-line-mode))
  :ensure t)

(use-package smartparens
  :config (progn
	    (require 'smartparens-config)
	    (smartparens-global-mode))
  :ensure t)

(use-package rainbow-delimiters
  :init (progn
	  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
  :ensure t)

(use-package monokai-theme
  :config (progn
	    (load-theme 'monokai t))
  :disabled t
  :ensure t)

(use-package yaml-mode
  :mode (("\\.yml$" . yaml-mode)
         ("\\.raml$" . yaml-mode))
  :ensure t)

(use-package markdown-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ido-mode)

;; GUI settings

(mapc (lambda (mode) (when (fboundp mode) (funcall mode -1))) '(menu-bar-mode tool-bar-mode scroll-bar-mode))

(if (eq system-type 'gnu/linux)
    (set-default-font "DejaVu Sans Mono 14"))

(setq visible-bell 1)

;; BACKUP settings

(setq backup-directory-alist
      `(("." . ,(emacs-d-dotfile "saves"))))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; C/C++ settings

(defvar my-cxx-qt-keywords
  '(("\\<\\(connect\\|disconnect\\)\\>" . font-lock-keyword-face)))

(defun my-c-common-hook ()
  (progn
    (linum-mode t)
    (hl-line-mode t)
    (show-paren-mode t)
    (setq indent-tabs-mode t)
    (setq show-trailing-whitespace t)
    (setq comment-start "// " comment-end "")
    (c-set-style "linux")))
(add-hook 'c-mode-common-hook 'my-c-common-hook)

(defun my-c++-mode-hook ()
  (progn
    (font-lock-add-keywords 'c++-mode my-cxx-qt-keywords)))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
