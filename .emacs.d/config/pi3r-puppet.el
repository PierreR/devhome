(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
; Automatically delete trailing whitespace in puppet-mode
;(add-hook 'puppet-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(require 'flymake-puppet-lint)
(add-hook 'puppet-mode-hook
          (lambda ()
			(flymake-puppet-lint-load)
            (auto-complete-mode t)
            (make-local-hook 'before-save-hook)))

(provide 'pi3r-puppet)
