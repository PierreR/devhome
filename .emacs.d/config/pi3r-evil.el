(setq evil-want-C-u-scroll t)
(require 'evil-leader)
(require 'powerline-evil)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-esc-delay 0)
(require 'evil)
(evil-mode 1)
(require 'evil-surround)
(global-evil-surround-mode 1)
(setq evil-move-cursor-back nil
      evil-normal-state-cursor '("grey" box)
      evil-insert-state-cursor '("green" bar)
      evil-visual-state-cursor '("grey50")
      evil-want-visual-char-semi-exclusive t
      evil-search-module 'evil-search)
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

(define-key evil-normal-state-map (kbd "q") nil)
(define-key evil-insert-state-map (kbd "C-d") nil)
(define-key evil-insert-state-map (kbd "C-e") nil) ;; copy from below
(define-key evil-motion-state-map (kbd "C-e") nil)
(define-key evil-insert-state-map (kbd "C-k") nil) ;; digraph

(define-key evil-normal-state-map (kbd "ç") 'evil-backward-paragraph)
(define-key evil-normal-state-map (kbd "à") 'evil-forward-paragraph)

(provide 'pi3r-evil)
