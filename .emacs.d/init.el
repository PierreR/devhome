(require 'cl)

(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/config")

(setq exec-path (append exec-path '("/home/vagrant/bin")))
(setq exec-path (append exec-path '("/home/vagrant/.cabal/bin")))

(require 'pi3r-defun)
(require 'pi3r-packages)
(require 'pi3r-evil)
(require 'pi3r-puppet)
(require 'pi3r-haskell)
(require 'pi3r-keymap)

(require 'linum-relative)
(require 'ace-jump-buffer)
(require 'evil-rebellion)
(require 'flx-ido)
(require 'helm-dash)
(require 'projectile)
(require 'surround)
(require 'tramp)
(require 'volatile-highlights)
(require 'hindent)
(require 'multiple-cursors)
(require 'company)

(add-hook 'after-init-hook 'global-company-mode)
;; (require 'auto-complete-config)
;(auto-complete-mode t)

;; keep in mind known issues with zsh - see emacs wiki
(powerline-evil-vim-color-theme)
(global-auto-revert-mode t)
(global-surround-mode 1)
(global-linum-mode 1)
(global-hl-line-mode +1)
(global-undo-tree-mode)
(projectile-global-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode +1)
(setq show-paren-style 'parenthesis)
(set-default 'imenu-auto-rescan t)
(icomplete-mode +1) ;; auto-completion in minibuffer
(recentf-mode t)

(ido-mode 1)
(ido-ubiquitous 1)
(flx-ido-mode 1)

;; store all backup and autosave files in the tmp dir
;(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq recentf-max-saved-items 150
      recentf-max-menu-items 15)
(setq-default tab-width 4)
(setq column-number-mode t)
(setq-default indent-tabs-mode nil)
;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
;; Ido
(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-enable-last-directory-history nil
      ido-use-virtual-buffers nil
      ido-use-filename-at-point nil
      ;; ido-ignore-buffers '("\\` " "^\\*")
      ido-max-prospects 8)

 ;; highlight the current line
(set-face-background hl-line-face "grey96")
;; dark theme
;(set-face-background hl-line-face "grey30")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(smex-initialize)

(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "bf7ed640479049f1d74319ed004a9821072c1d9331bc1147e01d22748c18ebdf" "be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(evil-overriding-maps (quote ((Buffer-menu-mode-map) (color-theme-mode-map) (comint-mode-map) (compilation-mode-map) (dictionary-mode-map) (ert-results-mode-map . motion) (Info-mode-map . motion) (speedbar-key-map) (speedbar-file-key-map) (speedbar-buffers-key-map) (nil) (magit-status-mode-map) (magit-key-mode-maps) (term-mode-map) (shell-mode-map))))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(puppet-lint-command "puppet-lint --no-80chars-check --no-documentation-check --no-inherits_across_namespaces-check --no-selector_inside_resource-check --no-quoted_booleans-check --no-class_parameter_defaults-check --with-context --log-format \"%{path}:%{linenumber}: %{kind}: %{message} (%{check})\"")
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight normal :height 97 :width normal)))))


(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "chromium")


;; Ack
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; Auto-complete
;; (ac-config-default)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (setq ac-auto-start nil)
;; (ac-set-trigger-key "TAB")

;; (require 'multi-term)
;(setq tramp-efault-method "ssh")
;(setq multi-term-program "/bin/zsh")
(setq term-program "/bin/zsh")
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)

;;(setq helm-dash-common-docsets '("Redis"))
(setq helm-dash-min-length 3)
;(setq helm-dash-browser-func 'eww)
(activate-package-docsets "/home/vagrant/.docsets/cabal")
(setq hi2-show-indentations nil)
