(require 'haskell-mode)
;; (require 'shm)
;; (require 'hindent)
;; (require 'hi2)
;; (require 'haskell-simple-indent)
(require 'haskell-indentation)
(require 'haskell-interactive-mode)
;; (require 'haskell)
;; (require 'haskell-font-lock)
;; (require 'shm-reformat)

(defun my-save-buffer ()
  (if (buffer-file-name)
         (progn (ghc-save-buffer))
       (message "no file is associated to this buffer: do nothing")))

;; (let ((map shm-map))
;;   (when (require 'shm-case-split nil 'noerror)
;;     (define-key map (kbd "C-c S") 'shm/case-split))
;;   (define-key map (kbd "C-j") nil)
;;   (define-key map (kbd "C-k") nil)
;;   (evil-define-key 'normal map (kbd "M-f") 'shm-reformat-decl)
;;   (evil-define-key 'normal map (kbd "M-p") 'shm/yank)
;;   (evil-define-key 'normal map (kbd "M-v") 'shm/mark-node)
;;   (evil-define-key 'normal map (kbd "R") 'shm/raise)
;;   (evil-define-key 'insert map (kbd "RET") 'shm/newline-indent)
;;   (evil-define-key 'normal map (kbd "RET") 'shm/newline-indent)
;;   (evil-define-key 'insert map (kbd "M-RET") 'evil-ret)
;;   (evil-define-key 'insert map
;;     (kbd "C-=") 'shm/add-operand))

(interactive-haskell-mode)

(defun my-haskell-hook ()
     (setq-local evil-ex-search-case 'sensitive)
     ;; (turn-on-haskell-decl-scan)
     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
     (define-key haskell-mode-map [f8] 'haskell-navigate-imports)
     (define-key haskell-mode-map (kbd "C-;") 'haskell-mode-jump-to-def-or-tag)
     (define-key haskell-mode-map (kbd "C-<left>") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-<right>") 'haskell-move-nested-right)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload))

(defvar haskell-process-use-ghci nil)
(autoload 'ghc-init "ghc" nil t)
;;(autoload 'ghc-debug "ghc" nil t)

(setq haskell-font-lock-symbols t)
(custom-set-variables
     ;; '(tab-stop-list '(4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60))
     '(company-ghc-show-info t)
     ;; '(shm-use-presentation-mode t)
     ;; '(shm-lambda-indent-style 'leftmost-parent)
     '(haskell-notify-p t)
     '(haskell-interactive-mode-eval-pretty nil) ; deprecated
     '(haskell-interactive-mode-eval-pretty-result t)
     '(haskell-process-args-ghci '())
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
     '(haskell-tags-on-save nil)
     '(haskell-stylish-on-save nil)
     '(hindent-style "ekmett")
     '(haskell-tags-on-save t))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'my-haskell-hook)
(add-hook 'haskell-mode-hook #'hindent-mode)
(add-hook 'haskell-mode-hook (lambda ()
                               (ghc-init)
                               (when (buffer-file-name)
                                 (add-hook 'evil-insert-state-exit-hook (lambda ()
                                                                          ;; (hi2-disable-show-indentations)
                                                                          (my-save-buffer)
                                                                          ) nil 'local)
                                 ;; (add-hook 'evil-insert-state-entry-hook 'hi2-enable-show-indentations nil 'local)
                                 ;;(turn-on-hi2)
                                 ;; (turn-on-haskell-simple-indent)
                                 ;; (structured-haskell-mode t)
                                 ;; (evil-define-key 'normal shm-map (kbd "RET") nil)
                                 (add-to-list 'company-backends '(company-ghc :with company-dabbrev-code))
                                 (toggle-case-fold-search nil))))

(evil-set-initial-state 'haskell-interactive-mode 'insert)
(setq ido-ignore-files '("\\.dyn_hi$""\\.dyn_o$""\\.hi$" "\\.o$" "\\.tags$" "^\\.ghci$"))
(delete-selection-mode 1)
(setq ghc-ghc-options '("-fno-warn-missing-signatures"))
;; (setq company-idle-delay .8) ; default is 0.5
;; (set-face-background 'shm-current-face "#eee8d5")
;; set-face-background 'shm-quarantine-face "lemonchiffon")
(setq ghc-check-warning-fringe 0)
(setq haskell-program-name "cabal repl")
;; (setq hi2-show-indentations nil)
;; (eval-after-load "haskell-cabal"
;;   '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

;(defalias 'ghc-save-buffer 'save-buffer)

;; Use haskell-interactive-mode instead of the default inferior-haskell-mode
(eval-after-load "haskell-mode"
  '(progn
     (evil-leader/set-key-for-mode 'haskell-mode "&" 'hindent/reformat-decl)
     (evil-leader/set-key-for-mode 'haskell-mode "e" 'ghc-display-errors)
     (evil-leader/set-key-for-mode 'haskell-mode "i" 'ghc-show-info)
     (evil-leader/set-key-for-mode 'haskell-mode "o" 'company-ghc-complete-by-hoogle)
     (evil-leader/set-key-for-mode 'haskell-mode "t" 'ghc-show-type)
     (evil-leader/set-key-for-mode 'haskell-mode "vc" 'haskell-cabal-visit-file)

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
