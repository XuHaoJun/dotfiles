

(defun our-load-subpath (base)
  (add-to-list 'load-path base)
  (dolist (f (directory-files base))
    (let ((name (concat base "/" f)))
      (when (and (file-directory-p name) 
                 (not (equal f ".."))
                 (not (equal f ".")))
        (add-to-list 'load-path name)))))

(our-load-subpath "~/Dropbox/emacs/lib")

;; global settings
(mapc 'load (directory-files "~/Dropbox/emacs" t "\\.el$"))

;; module settings
(mapc 'load (directory-files "~/Dropbox/emacs/module" t "\\.el$"))


