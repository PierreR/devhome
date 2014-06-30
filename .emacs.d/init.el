(require 'cl)
(require 'package)
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
    evil
    flymake-puppet
    ghc
    haskell-mode
    ido-ubiquitous
    magit
    multi-term
    puppet-mode
    paredit
    projectile
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

;(my-install-packages)

(fset 'yes-or-no-p 'y-or-n-p)
;; Evil
(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/local")
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(evil-overriding-maps (quote ((Buffer-menu-mode-map) (color-theme-mode-map) (comint-mode-map) (compilation-mode-map) (dictionary-mode-map) (ert-results-mode-map . motion) (Info-mode-map . motion) (speedbar-key-map) (speedbar-file-key-map) (speedbar-buffers-key-map) (nil) (magit-status-mode-map) (magit-key-mode-maps) (term-mode-map) (shell-mode-map))))
 '(flymake-no-changes-timeout 60)
 '(flymake-start-syntax-check-on-newline nil)
 '(haskell-hoogle-command "hogl")
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(transient-mark-mode (quote (only . t))))

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

(global-set-key (kbd "C-x C-r") 'recentf-ido-find-file)
(recentf-mode t)

(global-set-key (kbd "C-s") 'save-buffer)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(show-paren-mode +1)
(setq show-paren-style 'parenthesis)

 ;; highlight the current line
(global-hl-line-mode +1)
;; light theme
(set-face-background hl-line-face "grey96")
;; dark theme
;;(set-face-background hl-line-face "grey30")

;; Ido
(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-enable-last-directory-history nil
      ido-use-virtual-buffers nil
      ido-use-filename-at-point nil
      ido-ignore-buffers '("\\` " "^\\*")
      ido-max-prospects 8)

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

(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

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
;(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-,") 'smex)
(global-set-key (kbd "C-x &") 'delete-other-windows)

;(global-set-key (kbd "C-x C-b") 'helm-mini)

; Automatically delete trailing whitespace in puppet-mode
(add-hook 'puppet-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(require 'flymake-puppet)
(add-hook 'puppet-mode-hook
          (lambda ()
			(flymake-puppet-load)
            (make-local-hook 'before-save-hook)
            (add-hook 'before-save-hook 'delete-trailing-whitespace)))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq term-program "/bin/zsh")
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)
(setq exec-path (append exec-path '("~/bin")))
(setq exec-path (append exec-path '("~/.cabal/bin")))
; Haskell
;; [==:INIT haskell-mode==]
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; [==:INIT ghc-mod==]
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook
      (lambda ()
        (ghc-init)))

(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
             ac-source-dictionary
             ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)


;; [==:INIT fnd-file-hook==]
(defun my-haskell-ac-init ()
  (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
    (auto-complete-mode t)
    (my-ac-haskell-mode)))
(add-hook 'find-file-hook 'my-haskell-ac-init)

;(autoload 'ghc-init "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda () 
;                               (ghc-init)
;                               (setq ac-sources (append '(ac-source-ghc-mod) ac-sources))))
;;;(add-hook 'haskell-mode-hook 'flymake-hlint-load)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)
;(add-hook 'haskell-mode-hook 'haskell-doc-mode)

; structured-haskell-mode
;;(add-to-list 'load-path "~/.emacs.d/local/structured-haskell-mode")
;;(require 'shm)
;;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
;;(set-face-background 'shm-current-face "#eee8d5")
;;(set-face-background 'shm-quarantine-face "lemonchiffon")

; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'projectile)
(projectile-global-mode)
