(require 'cl)
(require 'package)

(add-to-list 'load-path "~/.emacs.d/local")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
                        ("melpa" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)

;; required because of a package.el bug
(setq url-http-attempt-keepalives nil)

(defvar my-packages
  '(ac-nrepl
    ack-and-a-half
    auto-complete
    clojure-mode
    evil
    ghc
    haskell-mode
    ido-ubiquitous
    nrepl
    magit
    markdown-mode
    multi-term
    paredit
	projectile
    puppet-mode
    smex
    surround
    undo-tree
    volatile-highlights
    yaml-mode
    zenburn-theme))

(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(defun my-install-packages ()
  (unless (my-packages-installed-p)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (dolist (p my-packages)
      (unless (package-installed-p p)
        (package-install p)))))

(my-install-packages)
(fset 'yes-or-no-p 'y-or-n-p)

;; Evil
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(require 'evil-surround)
(global-evil-surround-mode 1)
(setq evil-move-cursor-back nil
      evil-normal-state-cursor '("grey" box)
      evil-insert-state-cursor '("green" bar)
      evil-visual-state-cursor '("grey50"))
      ;; evil-motion-state-cursor '("grey50")
      ;;evil-emacs-state-modes nil)
;; (setq evil-motion-state-modes (append evil-emVacs-state-modes evil-motion-state-modes))

;;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(define-key evil-normal-state-map (kbd ",f") 'projectile-find-file)
(define-key evil-normal-state-map (kbd ",,") 'evil-buffer)

(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-insert-state-map (kbd "C-d") nil)
(define-key evil-insert-state-map (kbd "C-e") nil) ;; copy from below
(define-key evil-motion-state-map (kbd "C-e") nil)
(define-key evil-insert-state-map (kbd "C-k") nil) ;; digraph

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "bf7ed640479049f1d74319ed004a9821072c1d9331bc1147e01d22748c18ebdf" "be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(evil-overriding-maps (quote ((Buffer-menu-mode-map) (color-theme-mode-map) (comint-mode-map) (compilation-mode-map) (dictionary-mode-map) (ert-results-mode-map . motion) (Info-mode-map . motion) (speedbar-key-map) (speedbar-file-key-map) (speedbar-buffers-key-map) (nil) (magit-status-mode-map) (magit-key-mode-maps) (term-mode-map) (shell-mode-map))))
 '(haskell-interactive-mode-eval-pretty nil)
 '(haskell-interactive-mode-include-file-name nil)
 '(haskell-notify-p nil)
 '(haskell-process-args-ghci (quote nil))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-do-cabal-format-string ":!cd %s && unset GHC_PACKAGE_PATH && %s")
 '(haskell-process-log t)
 '(haskell-process-reload-with-fbytecode nil)
 '(haskell-process-show-debug-tips nil)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(haskell-process-suggest-hoogle-imports nil)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-process-use-presentation-mode t)
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(puppet-lint-command "puppet-lint --no-80chars-check --no-documentation-check --no-inherits_across_namespaces-check --no-selector_inside_resource-check --no-quoted_booleans-check --no-class_parameter_defaults-check --with-context --log-format \"%{path}:%{linenumber}: %{kind}: %{message} (%{check})\"")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 97 :width normal)))))

(global-linum-mode 1)
(set-default 'imenu-auto-rescan t)
(icomplete-mode +1) ;; auto-completion in minibuffer

;; Recentf
(setq recentf-max-saved-items 150
      recentf-max-menu-items 15)

(defun recentf-ido-find-file ()
  "Use ido to select a recently opened file"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recentf: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))

(global-set-key (kbd "C-c C-f") 'recentf-ido-find-file)
(global-set-key (kbd "C-c f") 'recentf-ido-find-file)
(recentf-mode t)


(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(show-paren-mode +1)
(setq show-paren-style 'parenthesis)

 ;; highlight the current line
(global-hl-line-mode +1)
;; light theme
(set-face-background hl-line-face "grey96")
;; dark theme
;(set-face-background hl-line-face "grey30")

;; Ido
(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-enable-last-directory-history nil
      ido-use-virtual-buffers nil
      ido-use-filename-at-point nil
      ;; ido-ignore-buffers '("\\` " "^\\*")
      ido-max-prospects 8)

(require 'flx-ido)
(ido-mode 1)
(ido-ubiquitous 1)
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;(setq make-backup-files nil)


;; tramp, for sudo access
(require 'tramp)
;; keep in mind known issues with zsh - see emacs wiki
(setq tramp-default-method "ssh")


(require 'volatile-highlights)

(require 'surround)
(global-surround-mode 1)

;; Ack
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; Smex: better M-x minibuffer prompt
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-,") 'smex)
(global-set-key (kbd "<f5>") 'projectile-ibuffer)
(global-set-key (kbd "<C-mouse-1>") 'find-tag)
(global-set-key (kbd "<C-down-mouse-1>") nil)
(global-set-key (kbd "C-s") 'save-buffer)
;(global-set-key (kbd "C-x C-b") 'helm-mini)

(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
; Automatically delete trailing whitespace in puppet-mode
;(add-hook 'puppet-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(require 'flymake-puppet-lint)
(add-hook 'puppet-mode-hook
          (lambda ()
			(flymake-puppet-lint-load)
            (make-local-hook 'before-save-hook)))
; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq term-program "/bin/zsh")
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)

(setq exec-path (append exec-path '("/home/vagrant/bin")))
(setq exec-path (append exec-path '("/home/vagrant/.cabal/bin")))

; Haskell
(setq haskell-program-name "cabal repl")

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
             ac-source-dictionary
             ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)

(setq ghc-ghc-options '("-fno-warn-missing-signatures"))
(setq ghc-check-warning-fringe 0)

(eval-after-load "haskell-cabal"
  '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-x C-d") nil)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c M-.") nil)
     (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (my-ac-haskell-mode)))
(add-hook 'find-file-hook 'my-haskell-ac-init)
; Haskell
;(autoload 'ghc-init "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda ()
;                               (ghc-init)
;                               (setq ac-sources (append '(ac-source-ghc-mod) ac-sources))))
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
