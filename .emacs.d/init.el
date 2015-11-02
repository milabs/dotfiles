;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq milabs/musthave-package-list
      '(paradox))

(setq milabs/optional-package-list
      '(smex magit helm guide-key company smartparens better-defaults smart-mode-line undo-tree zenburn-theme solarized-theme irony ibuffer-vc ibuffer-git))

;; load packages from the list
(defun milabs/package-list-install-p (packages)
  "Assure every package is installed, ask for installation if not"
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
	(package-install package)))
   packages))

(milabs/package-list-install-p milabs/musthave-package-list)
(milabs/package-list-install-p milabs/optional-package-list)

(load-theme 'monokai t)

(setq guide-key/guide-key-sequence t)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom) 
(setq guide-key/idle-delay 0.1)
(guide-key-mode 1) 

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)

(require 'undo-tree)
(global-undo-tree-mode)

(defun milabs/load-file-if-exists (file)
  (if (file-exists-p file)
      (load-file file)
    (warn (format "File '%s' not exists" file))))

(milabs/load-file-if-exists "~/.emacs.d/init-c-mode.el")
(milabs/load-file-if-exists "~/.emacs.d/init-ibuffer-mode.el")
