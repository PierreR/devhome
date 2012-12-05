(require 'cl)
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
                        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; required because of a package.el bug
(setq url-http-attempt-keepalives nil)

(defvar my-packages
  '(ac-nrepl
    ack-and-a-half
    auto-complete
    clojure-mode
    evil
    ido-ubiquitous
    haskell-mode
    nrepl
    magit
    markdown-mode
    paredit
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

;(my-install-packages)

;; Evil
(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/local")
(require 'evil)
(evil-mode 1)
(setq evil-move-cursor-back nil
      evil-normal-state-cursor '("grey" box)
      evil-insert-state-cursor '("green" bar)
      evil-visual-state-cursor '("grey50"))
      ;; evil-motion-state-cursor '("grey50")
      ;;evil-emacs-state-modes nil)
;; (setq evil-motion-state-modes (append evil-emVacs-state-modes evil-motion-state-modes))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("bf7ed640479049f1d74319ed004a9821072c1d9331bc1147e01d22748c18ebdf" "be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(evil-overriding-maps (quote ((Buffer-menu-mode-map) (color-theme-mode-map) (comint-mode-map) (compilation-mode-map) (dictionary-mode-map) (ert-results-mode-map . motion) (Info-mode-map . motion) (speedbar-key-map) (speedbar-file-key-map) (speedbar-buffers-key-map) (nil) (magit-status-mode-map) (magit-key-mode-maps) (term-mode-map) (shell-mode-map))))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
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
 )

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

;(global-set-key (kbd "C-c f") 'recentf-ido-find-file)
(recentf-mode t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(show-paren-mode +1)
(setq show-paren-style 'parenthesis)

 ;; highlight the current line
(global-hl-line-mode +1)
;; light theme
;(set-face-background hl-line-face "grey96")
;; dark theme
(set-face-background hl-line-face "grey30")

;; Ido
(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-enable-last-directory-history nil
      ido-use-virtual-buffers nil
      ido-use-filename-at-point nil
      ;; ido-ignore-buffers '("\\` " "^\\*")
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
(global-set-key (kbd "C-x C-b") 'helm-mini)

; Automatically delete trailing whitespace in puppet-mode
(add-hook 'puppet-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

(require 'flymake-puppet)
(add-hook 'puppet-mode-hook
          (lambda ()
			(flymake-puppet-load)
            (make-local-hook 'before-save-hook)
            (add-hook 'before-save-hook 'delete-trailing-whitespace)))

;(require 'multi-term)
;(setq multi-term-program "/bin/zsh")
(setq term-program "/bin/zsh")
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)


