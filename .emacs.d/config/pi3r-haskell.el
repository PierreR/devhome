(require 'hi2)
(require 'haskell-mode)
(require 'haskell-interactive-mode)

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
             ac-source-dictionary
             ac-source-ghc-mod)))

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (my-ac-haskell-mode)))

(defun my-save-buffer ()
  (if (buffer-file-name)
         (progn (ghc-save-buffer))
       (message "no file is associated to this buffer: do nothing")))

(add-hook 'evil-insert-state-exit-hook (lambda ()
                                         (my-save-buffer)
                                         (hi2-disable-show-indentations)))
(add-hook 'evil-insert-state-entry-hook 'hi2-enable-show-indentations)

(autoload 'ghc-init "ghc" nil t)
;;(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'find-file-hook 'my-haskell-ac-init)
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)
;(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
(add-hook 'haskell-mode-hook (lambda () (setq-local evil-ex-search-case 'sensitive)
                                        (toggle-case-fold-search nil)
                                        (turn-on-hi2)
                                        (turn-on-haskell-decl-scan)))

(evil-set-initial-state 'haskell-interactive-mode 'insert)
(setq ghc-ghc-options '("-fno-warn-missing-signatures"))
(setq ghc-check-warning-fringe 0)
(setq haskell-program-name "cabal repl")
(custom-set-variables
     '(haskell-notify-p t)
     '(haskell-interactive-mode-eval-pretty nil) ; deprecated
     '(haskell-interactive-mode-eval-pretty-result t)
     '(haskell-process-args-ghci (quote nil))
     '(haskell-process-auto-import-loaded-modules t)
     '(haskell-process-do-cabal-format-string ":!cd %s && unset GHC_PACKAGE_PATH && %s")
     '(haskell-process-log t)
     '(haskell-process-reload-with-fbytecode nil)
     '(haskell-process-show-debug-tips nil)
     '(haskell-process-suggest-haskell-docs-imports t)
     '(haskell-process-suggest-hoogle-imports nil)
     '(haskell-process-suggest-remove-import-lines t)
     '(haskell-process-type 'cabal-repl)
     '(haskell-process-use-presentation-mode t)
     '(haskell-stylish-on-save t)
     '(hindent-style "gibiansky")
     '(haskell-tags-on-save t)
     '(tab-stop-list '(4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60)))


(define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;; (eval-after-load "haskell-cabal"
;;   '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

;(defalias 'ghc-save-buffer 'save-buffer)

;; Use haskell-interactive-mode instead of the default inferior-haskell-mode
(eval-after-load "haskell-mode"
  '(progn
     (evil-leader/set-key-for-mode 'haskell-mode "t" 'ghc-show-type)
     (evil-leader/set-key-for-mode 'haskell-mode "i" 'ghc-show-info)
     (evil-leader/set-key-for-mode 'haskell-mode "e" 'ghc-display-errors)
     (evil-leader/set-key-for-mode 'haskell-mode "vc" 'haskell-cabal-visit-file)

     (define-key haskell-mode-map [f2] 'haskell-process-load-or-reload)
     (define-key haskell-mode-map [f8] 'haskell-navigate-imports)
     (define-key haskell-mode-map (kbd "C-;") 'haskell-mode-jump-to-def-or-tag)
     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-<left>") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-<right>") 'haskell-move-nested-right)
     (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-x C-d") nil)
     (define-key haskell-mode-map (kbd "C-c M-.") nil)
     (define-key haskell-mode-map (kbd "C-c TAB") nil)
     (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(require 'align)
(add-to-list 'align-rules-list
             '(haskell-types
               (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
               (modes quote (haskell-mode literate-haskell-mode))))
(add-to-list 'align-rules-list
             '(haskell-assignment
               (regexp . "\\(\\s-+\\)=\\s-+")
               (modes quote (haskell-mode literate-haskell-mode))))
(add-to-list 'align-rules-list
             '(haskell-arrows
               (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
               (modes quote (haskell-mode literate-haskell-mode))))
(add-to-list 'align-rules-list
             '(haskell-left-arrows
               (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
               (modes quote (haskell-mode literate-haskell-mode))))

(provide 'pi3r-haskell)
