(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
             ac-source-dictionary
             ac-source-ghc-mod)))

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (my-ac-haskell-mode)))


(autoload 'ghc-init "ghc" nil t)
;;(autoload 'ghc-debug "ghc" nil t)

(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'find-file-hook 'my-haskell-ac-init)
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook (lambda () (setq-local evil-ex-search-case 'sensitive)
                                        (toggle-case-fold-search nil)))
(evil-set-initial-state 'haskell-interactive-mode 'emacs)
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
     '(haskell-stylish-on-save nil)
     '(hindent-style "johan-tibell")
     '(haskell-tags-on-save t)
     '(tab-stop-list '(4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60)))

(eval-after-load "haskell-cabal"
  '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

;; Use haskell-interactive-mode instead of the default inferior-haskell-mode
(eval-after-load "haskell-mode"
  '(progn
     (evil-leader/set-key-for-mode 'haskell-mode "t" 'ghc-show-type)
     (evil-leader/set-key-for-mode 'haskell-mode "i" 'ghc-show-info)
     (evil-leader/set-key-for-mode 'haskell-mode "vc" 'haskell-cabal-visit-file)
     (evil-leader/set-key-for-mode 'haskell-mode "vs" 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     (define-key haskell-mode-map [f8] 'haskell-navigate-imports)
     (define-key haskell-mode-map (kbd "C-;") 'haskell-mode-jump-to-def-or-tag)

     (define-key haskell-mode-map (kbd "C-x C-d") nil)
     (define-key haskell-mode-map (kbd "C-c M-.") nil)
     (define-key haskell-mode-map (kbd "C-c TAB") nil)
     (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(provide 'pi3r-haskell)