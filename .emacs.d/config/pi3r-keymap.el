(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-,") 'smex)
(global-set-key (kbd "<C-mouse-1>") 'find-tag)
(global-set-key (kbd "<C-down-mouse-1>") nil)
(global-set-key (kbd "<f5>") 'projectile-ibuffer)
(global-set-key (kbd "<f6>") 'magit-status)

(evil-leader/set-key
  "," 'evil-buffer
  "pa" 'projectile-ack
  "b" 'ace-jump-buffer
  "c" 'ace-jump-char-mode
  "d" 'dired-jump
  "f" 'ido-find-file
  "pf" 'projectile-find-file
  "h" 'recentf-ido-find-file
  "l" 'ace-jump-line-mode
  "r" 'undo-tree-redo
  "s" (lambda () (interactive) (save-some-buffers t))
  "w" 'ace-jump-mode)

(provide 'pi3r-keymap)
