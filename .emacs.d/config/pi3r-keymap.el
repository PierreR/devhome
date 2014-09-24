(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-,") 'smex)
(global-set-key (kbd "<C-mouse-1>") 'find-tag)
(global-set-key (kbd "<C-down-mouse-1>") nil)
(global-set-key (kbd "<f5>") 'projectile-ibuffer)
(global-set-key (kbd "<f6>") 'magit-status)

(evil-leader/set-key
  "-" 'comment-or-uncomment-region-or-line
  "," 'evil-buffer
  "!" 'highlight-changes-mode
  "~" 'toggle-case-fold-search
  "ç" 'evil-backward-paragraph
  "à" 'evil-forward-paragraph
  "a" 'ace-jump-mode
  "b" 'ido-switch-buffer
  "B" 'ace-jump-buffer
  "c" 'ace-jump-char-mode
  "d" 'dired-jump
  "e" 'helm-dash-at-point
  "f" 'ido-find-file
  "h" 'recentf-ido-find-file
  ;; i is for show-info
  "l" 'ace-jump-line-mode
  "j" 'find-tag
  "pa" 'projectile-ag
  "pb" 'projectile-switch-to-buffer
  "pc" 'projectile-compile-project
  "pf" 'projectile-find-file
  "ps" 'projectile-switch-project
  "r" 'undo-tree-redo
  "s" (lambda () (interactive) (save-some-buffers t))
  ;; t is for show-type
  ;; v is used for visit
  "uv" 'undo-tree-visualize
  )

(provide 'pi3r-keymap)
