(paradox-require 'ibuffer)
(paradox-require 'ibuffer-vc)
(paradox-require 'ibuffer-git)

(add-hook 'ibuffer-hook
          (lambda ()
            (hl-line-mode t)
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

