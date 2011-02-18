;; .emacs

(setq load-path (cons "~/.emacs.d" load-path))

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; Don't make me type out 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
(setq
    backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
    delete-old-versions t
    kept-new-versions 6
    kept-old-versions 2
    version-control t)       ; use versioned backups

;; Key bindings
(global-set-key [?\C-z] 'shell)
(global-set-key [?\C-x ?\C-g] 'goto-line)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Hide password prompts
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; Show the column number
(column-number-mode t)

;(load "~/.emacs.d/nxhtml/autostart.el")

;; PHP mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.phtml$" . php-mode))
(defun moxley-php-mode-hook ()
  (setq tab-width 4
        c-basic-offset 4
        indent-tabs-mode nil)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-cont-nonempty '+)
  (c-set-offset 'arglist-close 0)
  (global-set-key [f8] 'php-list-functions))
(add-hook 'php-mode-hook 'moxley-php-mode-hook)

;; Javascript mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript.el" nil t)
(defun javascript-outline ()
  "List JavaScript functions in the current buffer"
  ;; TODO Delete window holding the function list
  ;; Delete all windows showing BUFFER.
  ;; (delete-windows-on BUFFER &optional FRAME)
  (interactive)
  (occur-1 "function" 0 (list (current-buffer)) "*JavaScript Outline*"))
(global-set-key [f8] 'javascript-outline)
(defun moxley-javascript-mode-hook ()
  (setq tab-width 4
        c-basic-offset 4
        indent-tabs-mode nil)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-cont-nonempty '+)
  (c-set-offset 'arglist-close 0)
  (global-set-key [f8] 'javascript-list-functions))
(add-hook 'javascript-mode-hook 'moxley-javascript-mode-hook)

(require 'git)
(require 'psvn)
(require 'git-blame)
