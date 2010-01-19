;; Set the load path
(setq load-path (cons "~/.emacs.d" load-path))

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun my-save-hook ()
       )
(add-hook 'after-save-hook 'my-save-hook)

;; Don't make me type out 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; Color the code
(require 'font-lock)
(global-font-lock-mode t)

;; Set the starting appearance
(setq default-frame-alist
      '(;;(cursor-color . "Firebrick")
        (cursor-color . "White")
        (cursor-type . box)
        ;;(foreground-color . "White")
        ;;(background-color . "DarkSlateGray")
        (foreground-color . "White")
        (background-color . "Black")
        (vertical-scroll-bars . right)))

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

;;;;Make sure that .emacs file is edited in lisp mode:
(setq auto-mode-alist (cons '("\.emacs" . lisp-mode) auto-mode-alist))

;; Fix the worse part about emacs: indentation craziness
;;   1. When I hit the TAB key, I always want a TAB character inserted
;;   2. Don't automatically indent the line I am editing.
;;   3. When I hit C-j, I always want a newline, plus enough tabs to put me on
;;      the same column I was at before.
;;   4. When I hit the BACKSPACE key to the right of a TAB character, I want the
;;      TAB character deleted-- not replaced with tabwidth-1 spaces.
(defun newline-and-indent-relative ()
  "Insert a newline, then indent relative to the previous line."
  (interactive "*") (newline) (indent-relative))
(defun indent-according-to-mode () ())
(defalias 'newline-and-indent 'newline-and-indent-relative)
(defun my-c-hook ()
  (defalias 'c-electric-backspace 'delete-backward-char)
  (defun c-indent-command () (interactive "*") (self-insert-command 1)))
(add-hook 'c-mode-common-hook 'my-c-hook)
;;(defun indent-region-with-tab ()
;;  (interactive)
;;  (save-excursion
;;	(if (< (point) (mark)) (exchange-point-and-mark))
;;	(let ((save-mark (mark)))
;;	  (if (= (point) (line-beginning-position)) (previous-line 1))
;;	  (goto-char (line-beginning-position))
;;	  (while (>= (point) save-mark)
;;		(goto-char (line-beginning-position))
;;		(insert "\t")
;;		(previous-line 1)))))
;;(global-set-key [?\C-x tab] 'indent-region-with-tab)
;;(global-set-key [f4] 'indent-region-with-tab)
;;(defun unindent-region-with-tab ()
;;  (interactive)
;;  (save-excursion
;;	(if (< (point) (mark)) (exchange-point-and-mark))
;;	(let ((save-mark (mark)))
;;	  (if (= (point) (line-beginning-position)) (previous-line 1))
;;	  (goto-char (line-beginning-position))
;;	  (while (>= (point) save-mark)
;;		(goto-char (line-beginning-position))
;;		(if (= (string-to-char "\t") (char-after (point))) (delete-char 1))
;;		(previous-line 1)))))

(defun grep-find-web (command-args)
  "find+grep within web files"
  (interactive
   (progn
	 (list (read-string "grep expression: "))))
  (when command-args
	(grep-find (concat "find . -type f \\( -name \"*.php\" -or -name \"*.phtml\" -or -name \"*.js\" -or -name \"*.css\" -or -name \\*.sh -or -name \\*.ksh \\) -print0 | xargs -0 -e grep -nH -e '" command-args "'"))))
(global-set-key [f9] 'grep-find-web)

;;(require 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.phtml$" . php-mode))

(defun php-list-functions ()
  "List PHP functions in the current buffer"
  ;; TODO Delete window holding the function list
  ;; Delete all windows showing BUFFER.
  ;; (delete-windows-on BUFFER &optional FRAME)
  (interactive)
  (occur-1 "function " 0 (list (current-buffer)) "*PHP Functions*"))

;;(defun moxley-php-mode-hook ()
;;  (setq tab-width 4
;;        c-basic-offset 4
;;        indent-tabs-mode t)
;;  (c-set-offset 'arglist-intro '+)
;;  (c-set-offset 'arglist-cont-nonempty '+)
;;  (c-set-offset 'arglist-close 0)
;;  (global-set-key [f8] 'php-list-functions))
;;(add-hook 'php-mode-hook 'moxley-php-mode-hook)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(defun moxley-js2-mode-hook ()
;;       (setq tab-width 4
;;	     c-basic-offset 4
;;	     indent-tabs-mode t))
;;(add-hook 'js2-mode-hook 'moxley-js2-mode-hook)

(require 'psvn)

;; Hide password prompts
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; Display the time
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; Show the column number
(column-number-mode t)

;; Key bindings
(global-set-key [?\C-z] 'shell)
(global-set-key [?\C-x ?\C-g] 'goto-line)

;; Temporary directory
(setq temporary-file-directory "~/tmp")

(setq tramp-default-method "ssh")
(require 'tramp)

;;;;"I always compile my .emacs, saves me about two seconds
;;;;startuptime. But that only helps if the .emacs.elc is newer
;;;;than the .emacs. So compile .emacs if it's not."
(defun autocompile nil
  "compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (if (string= (buffer-file-name) (expand-file-name (concat
default-directory ".emacs")))
      (byte-compile-file (buffer-file-name))))

(add-hook 'after-save-hook 'autocompile)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js2-basic-offset 4)
 '(js2-highlight-level 2))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

