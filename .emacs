(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(blink-cursor-interval 0.5)
 '(blink-cursor-mode nil)
 '(cursor-type (quote (bar . 4)))
 '(custom-enabled-themes (quote (wheatgrass)))
 '(ido-mode (quote buffer) nil (ido))
 '(inferior-lisp-program "clisp")
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4" "-dNOSAFER"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "deep sky blue" :box nil :width extra-expanded))))
 '(hl-line ((t (:background "gray21"))))
 '(region ((t (:background "dark green" :foreground "white")))))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; Fix zsh shell
(setenv "ESHELL" (expand-file-name "~/bin/eshell"))

;; (let ((path-from-shell
;;        (replace-regexp-in-string "\n" "" (shell-command-to-string
;;                                           "$SHELL -l -c 'echo $PATH'"))))
;;   (setenv "PATH" path-from-shell)
;;   (setq exec-path (split-string path-from-shell path-separator)))

;; create more beautiful code blocks in the scource code
(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#202020")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#202020")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#202020")))
  "Face used for the line delimiting the end of source blocks.")

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; set load path 
(add-to-list 'load-path "~/elisp")

;; load highlight parentheses and enable them
(require 'highlight-parentheses)
;; make sure its used in all buffers
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; No tabs please
(setq-default indent-tabs-mode nil)

;; Some offset?
(c-set-offset (quote substatement-open) 0 nil)

;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
(defconst emacs-tmp-dir (format "%s%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)


;; fix ^ bug
(require 'iso-transl)

(defalias 'yes-or-no-p 'y-or-n-p)

;; for deleting regions of text etc
;; it works as one thinks it should
(delete-selection-mode t)
(transient-mark-mode t)
;; use same clipboard as the system
(setq x-select-enable-clipboard t)

;; increase/decrease text size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; org mode adding inprogress
(setq org-todo-keywords
      '((sequence "TODO" "INPROG" "DONE")))
(setq org-todo-keyword-faces
      '(("INPROG" . (:foreground "blue" :weight bold))))

;; auto refresh buffers when file changed on disk
(global-auto-revert-mode)

;; highlight current line
(global-hl-line-mode 1)

;; turn off toolbar
(tool-bar-mode -1)

;; trying to fix babel-load-langugaes
(org-babel-do-load-languages
 'org-babel-load-languages
 '(  (ruby . t)
     (C . t)
     (python . t)
     (emacs-lisp . t)
     (java . t)
     (latex . t)
     (matlab . t)
     (octave . t)
     (sh . t)
     ))

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)



(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; multiple cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Fix java indentation
(defun my-jde-mode-hook ()
  (setq c-basic-offset 2))

;; (add-hook 'jde-mode-hook 'my-jde-mode-hook)
;; (add-hook 'java-mode-hook 'my-jde-mode-hook)

;; (setq jdee-server-dir "/home/neon/myJars/jdeeserver")



;; Autocomplete tabs Not needed anymore.
                                        ; (global-set-key (kbd "C-<tab>") 'dabbrev-expand)
                                        ; (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; Better scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; Erlang indentation
(setq erlang-indent-level 4)




(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Autocompleteion
(require 'auto-complete)
(global-auto-complete-mode t)

(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
(set-face-foreground 'ac-candidate-face "black")


(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-auto-start t)
(setq ac-auto-show-menu t)

(add-hook 'after-init-hook #'global-flycheck-mode)

(global-set-key (kbd "C-x g") 'magit-status)

(set-face-attribute 'default nil :height 170)
;; Matlab
(add-to-list 'exec-path "/home/neon/opt/matlabinstallation/bin")
;(setq exec-path '())

(add-to-list 'load-path "~/.emacs.d/elpa/matlab-mode-20160902.459/matlab.el")
(load-library "matlab-load")
;; Enable CEDET feature support for MATLAB code. (Optional)
(matlab-cedet-setup)

(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")

;; better pdf viewer.
(pdf-tools-install)

;; Better kill-ring usage.
(require 'popup)
(require 'pos-tip)
(require 'popup-kill-ring)
;; (global-set-key "\M-y" 'popup-kill-ring) doesnt work proerply

;;
;; * If you insert a selected item interactively, add following line to
;;   your .emacs.
;;
;;   (setq popup-kill-ring-interactive-insert t)

;; Google-this
(use-package google-this
  :config
  (google-this-mode 1))

;; remove error from this file
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;;;;;;
(require 'ediff)
;; don't start another frame
;; this is done by default in preluse
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; put windows side by side
(setq ediff-split-window-function (quote split-window-horizontally))
;;revert windows on exit - needs winner mode
(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)



;;preview files in dired
(use-package peep-dired
  :ensure t
  :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
  :bind (:map dired-mode-map
              ("P" . peep-dired)))

(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))


;; weather from wttr.in
(use-package wttrin
  :ensure t
  :commands (wttrin)
  :init
  (setq wttrin-default-cities '("Göteborg")))


(global-set-key [remap goto-line] 'goto-line-with-feedback)

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(defun tf-toggle-show-trailing-whitespace ()
  "Toggle show-trailing-whitespace between t and nil"
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (redraw-display))

(global-set-key (kbd "M-p") 'tf-toggle-show-trailing-whitespace)

;; Require org mode to be able to export to markdown
(require 'ox-md)

;; Org-mode src block syntax highlighting 
(setq org-src-fontify-natively t)

(require 'tls)


;; What is current buffer? 
(global-set-key (kbd "M-?") 'flash-active-buffer)

(make-face 'flash-active-buffer-face)
(set-face-attribute 'flash-active-buffer-face nil
                    :background "red"
                    :foreground "black")
(defun flash-active-buffer ()
  (interactive)
  (run-at-time "100 millisec" nil
               (lambda (remap-cookie)
                 (face-remap-remove-relative remap-cookie))
               (face-remap-add-relative 'default 'flash-active-buffer-face)))


;; Highlight current frame
(set-face-attribute  'mode-line
                 nil 
                 :foreground "misty_rose"
                 :background "#000075" 
                 :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                 nil 
                 :foreground "gray60"
                 :background "gray10" 
                 :box '(:line-width 1 :style released-button))


;; Which-key shows what keys I can press to do commands
(use-package which-key
  :ensure t
  :config
  (which-key-mode))


;; Ace-window lets me easier choose which window I want to select
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "C-x p") 'ace-window))

;; Expand region, can not live without
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package iedit
  :ensure t)

;; if you're windened, narrow to the region, if you're narrowed, widen
;; bound to C-x n
(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing command.
         ;; Remove this first conditional if you don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((org-at-block-p)
                (org-narrow-to-block))
               (t (org-narrow-to-subtree))))
        (t (narrow-to-defun))))

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)


;; When using isearch, if i stop the search with C-RET
;; TODO fix this to work with reverse search as well
(define-key isearch-mode-map [(control return)]
  #'isearch-exit-other-end)
(defun isearch-exit-other-end ()
  "Exit isearch, at the opposite end of the string."
  (interactive)
  (isearch-exit)
  (goto-char isearch-other-end))

;; Show where the cursor is by highlighting the row when scrolling
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  (setq beacon-color "#666600"))

;; (defun modi/multi-pop-to-mark (orig-fun &rest args)
;;   "Call ORIG-FUN until the cursor moves.
;; Try the repeated popping up to 10 times."
;;   (let ((p (point)))
;;     (dotimes (i 10)
;;       (when (= p (point))
;;         (apply orig-fun args)))))

;; ;; Do not save multiple instances of the same mark position
;; (advice-add 'pop-to-mark-command :around
;;             #'modi/multi-pop-to-mark)

;; Easier to move to mark with C-SPACE,SPACE...
(setq set-mark-command-repeat-pop t)

(use-package smartparens
  :ensure t
  :config
  (add-hook 'latex-mode-hook 'smartparens-mode)
  (add-hook 'LaTeX-mode-hook 'smartparens-mode)
  (add-hook 'tex-mode-hook 'smartparens-mode)
  (add-hook 'TeX-mode-hook 'smartparens-mode)
  (add-hook 'bibtex-mode-hook 'smartparens-mode))


;; (use-package flx-ido
;;   :ensure t
;;   :config
;;   (ido-mode 1)
;;   (ido-everywhere 1)
;;   (flx-ido-mode 1)
;;   (setq ido-enable-flex-matching t)
;;   (setq ido-use-faces nil))

;; (use-package ido-vertical-mode
;;   :ensure t
;;   :config
;;   (ido-vertical-mode 1)
;;   (setq ido-vertical-define-keys 'C-n-and-C-p-only)
;;   )

;; From wikipedia, nice stuff
;; https://en.wikipedia.org/wiki/Emacs_Lisp
(defun my-split-window-vertically ()
  (interactive)
  (split-window-vertically)
  (set-window-buffer (next-window) (other-buffer)))

(global-set-key "\C-x2" 'my-split-window-vertically)

(defun my-split-window-horizontally ()
  (interactive)
  (split-window-horizontally)
  (set-window-buffer (next-window) (other-buffer)))

(global-set-key "\C-x3" 'my-split-window-horizontally)
(setq latex-run-command "pdflatex")

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; remove all whitespace with one key stroke.
(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

;; Toggle between vertical split and horizontal split
;; Only works when working with 2 windows.
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

;; engine mode alows quick searches using different engines.
;; bound to C-x / KEYSTROKE
;; google=this might conflict here some.
(use-package engine-mode
  :ensure t
  :config
  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s")
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d")
  (defengine google
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
    :keybinding "g")
  (defengine stack-overflow
    "https://stackoverflow.com/search?q=%s"
    :keybinding "s")
  (defengine wikipedia
    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
    :keybinding "w"
    :docstring "Searchin' the wikis.")
  (defengine wolfram-alpha
    "http://www.wolframalpha.com/input/?i=%s"
    :keybinding "m")
  (defengine youtube
    "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
    :keybinding "y")
  (engine-mode t))
