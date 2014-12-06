(require 'package)

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

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                        ;("melpa" . "http://melpa-stable.milkbox.net/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; required because of a package.el bug
(setq url-http-attempt-keepalives nil)

(defvar my-packages
  '(ac-nrepl
    ace-jump-mode
    ag
    ack-and-a-half
    auto-complete
    company
    company-ghc
    evil
    evil-leader
    flx-ido
    ghc
    haskell-mode
    helm-dash
    ido-ubiquitous
    magit
    markdown-mode
    multiple-cursors
    multi-term
    paredit
    projectile
    puppet-mode
    solarized-theme
    smex
    surround
    undo-tree
    volatile-highlights
    yaml-mode
    zenburn-theme))

;;(my-install-packages)

(provide 'pi3r-packages)
