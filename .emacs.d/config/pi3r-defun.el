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

(defun activate-package-docsets (root)
  "activate all docsets in a given directory"
  (progn
     ; force docsets in root to be recognized as installed docsets
     (setq helm-dash-docsets-path root)
     ; append those to the docset list
     (setq
        helm-dash-common-docsets
        (append (helm-dash-installed-docsets) helm-dash-common-docsets ))
  ))
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-logical-line)))
(provide 'pi3r-defun)
