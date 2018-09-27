 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(blink-cursor-interval 0.5)
 '(blink-cursor-mode nil)
 '(cursor-type '(bar . 4))
 '(custom-enabled-themes '(wheatgrass))
 '(display-time-24hr-format t)
 '(haskell-font-lock-symbols nil)
 '(ido-mode 'buffer nil (ido))
 '(inferior-lisp-program "clisp" t)
 '(initial-buffer-choice t)
 '(js-indent-level 4)
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(clang-format eshell-git-prompt visual-fill-column json-reformat prettier-js zenburn-theme wttrin which-key use-package tide smartparens slime simple-mpc popup-kill-ring peep-dired pdf-tools paredit org-journal org-bullets multiple-cursors monokai-theme monokai-alt-theme memoize matlab-mode magithub kotlin-mode iedit ido-vertical-mode hungry-delete htmlize highlight-parentheses highlight-indent-guides haskell-mode groovy-mode google-this go-guru gnuplot-mode ggo-mode flycheck-tip flycheck-cython flx-ido figlet expand-region epc engine-mode elpy dired-narrow diminish diff-hl cython-mode company-go company-erlang color-theme-sanityinc-tomorrow color-theme beacon auto-complete auctex ace-window))
 '(preview-gs-options
   '("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4" "-dNOSAFER"))
 '(python-shell-interpreter "python3.6")
 '(temporary-file-directory "/home/neon/tmp/")
 '(text-scale-mode-step 1.04))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "deep sky blue" :box nil :width extra-expanded))))
 '(font-lock-comment-face ((t (:foreground "tomato"))))
 '(haskell-constructor-face ((t (:foreground "orange red"))))
 '(haskell-definition-face ((t (:foreground "deep sky blue"))))
 '(haskell-keyword-face ((t (:foreground "orange"))))
 '(highlight ((t (:background "gray35" :foreground unspecified))))
 '(hl-line ((t (:background "gray21"))))
 '(isearch ((t (:background "lime green" :foreground "black"))))
 '(lazy-highlight ((t (:background "dark slate blue" :foreground "yellow"))))
 '(region ((t (:inherit nil :background "gray35" :foreground unspecified)))))

(require 'package)
(defvar gnu '("gnu" . "https://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "https://melpa.org/packages/"))
(defvar melpa-stable '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; Add marmalade to package repos
(setq package-archives nil)
(add-to-list 'package-archives melpa-stable t)
(add-to-list 'package-archives melpa t)
(add-to-list 'package-archives gnu t)
(package-initialize)

(setq load-prefer-newer t)

;; Fix zsh shell
(setenv "ESHELL" (expand-file-name "~/bin/eshell"))

;; (let ((path-from-shell
;;        (replace-regexp-in-string "\n" "" (shell-command-to-string
;;                                           "$SHELL -l -c 'echo $PATH'"))))
;;   (setenv "PATH" path-from-shell)
;;   (setq exec-path (split-string path-from-shell path-separator)))

;; Rebind C-x o
(global-set-key (kbd "M-o") 'other-window)

;; I should start using imenu
(global-set-key (kbd "M-i") 'imenu)


;; (windmove-default-keybindings)
;; You can now switch windows with your shift
;; key by pressing S-<left> , S-<right> , S-<up> ,
;; S-<down> .

;; glasses mode for camel case code

(defun sudo ()
  "Use TRAMP to `sudo' the current buffer"
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))


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
(global-diff-hl-mode 1)
;;When using Magit 2.4 or newer, add this to your init script:
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)


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
     (shell . t)
     (haskell . t)
     ))

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)



;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; multiple cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-:") 'mc/mark-all-like-this)

;; Fix java indentation
;;(defun my-jde-mode-hook ()
;;  (setq c-basic-offset 2))

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

(setq python-indent-offset 2)

;;(use-package company-erlang
;;  :ensure t
;;  :config
;;  (add-hook 'erlang-mode-hook #'company-erlang-init))



;; Autocompleteion
(require 'auto-complete)
;; (global-auto-complete-mode t)

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


(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(set-face-attribute 'default nil :height 170)
;; Matlab
(add-to-list 'exec-path "/home/neon/opt/matlabinstallation/bin")
(add-to-list 'exec-path "/usr/bin/gnuplot")
;(setq exec-path '())

(add-to-list 'load-path "~/.emacs.d/elpa/matlab-mode-20160902.459/matlab.el")
;; (load-library "matlab-load")
;; Enable CEDET feature support for MATLAB code. (Optional)
;; (matlab-cedet-setup)

;; (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")
(setq matlab-indent-level 2)
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


(defun tf-toggle-show-trailing-whitespace ()
  "Toggle show-trailing-whitespace between t and nil"
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (redraw-display))

(setq show-trailing-whitespace t) ;; default on
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

;; (use-package monokai-alt-theme
  ;; :ensure t
  ;; :config (load-theme 'monokai-alt t))
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config (load-theme 'sanityinc-tomorrow-eighties t))



;; Highlight current frame
(set-face-attribute  'mode-line
                 nil 
                 :foreground "misty rose"
                 :background "#000075" 
                 :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
                 nil 
                 :foreground "gray60"
                 :background "gray10" 
                 :box '(:line-width 1 :style released-button))


;; which-key shows what keys I can press to do commands
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
; (use-package hungry-delete
;   :ensure t
;   :config
;   (global-hungry-delete-mode))

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
  (defengine thesaurus
    "http://www.thesaurus.com/browse/%s?s=t"
    :keybinding "t")
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
  (defengine hoogle
    "https://www.haskell.org/hoogle/?hoogle=%s"
    :keybinding "h")
  (defengine tyda
    "http://tyda.se/search/%s"
    :keybinding "w") ; W-hat does this mean?
  (engine-mode t))

(use-package yasnippet
  :ensure t)

(use-package haskell-mode
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'yas-minor-mode)
  (add-hook 'haskell-mode-hook 'flyspell-prog-mode))

(use-package tide
  :ensure t)

(use-package company
  :ensure t)

;; Typescript stuff for the AI course
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (local-set-key (kbd "\C-ci") 'tide-jump-to-implementation)
  (local-set-key (kbd "\C-cr") 'tide-rename-symbol)
  (local-set-key (kbd "\C-cb") 'tide-jump-back)
  (local-set-key (kbd "\C-cq") 'tide-documentation-at-point))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))


;; END of typescript stuff

(use-package figlet
  :ensure t)

(display-time-mode 1)
(display-battery-mode 1)


(use-package simple-mpc
  :ensure t)


(setq highlight-indent-guides-method 'character)

 (use-package elpy
   :ensure t
   :commands elpy-enable
   :init (elpy-enable)
   :config (highlight-indent-guides-mode))

(use-package org-journal
  :ensure t)

;; Make sure we use listings for latex
(add-to-list 'org-latex-packages-alist '("" "listings" nil))
(setq org-latex-listings t)
;; Break lines, trying to get shorter source blocks
(setq org-latex-listings-options '(("breaklines" "true")))

(define-key global-map "\C-cc" 'org-capture)
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-capture-templates
      '(("t" "Todo list entry" entry (file+headline org-default-notes-file "Tasks") "* TODO %?\n %i\n %a")
        ("j" "Journal entry" entry (file+datetree "~/org/journal.org") (file "~/org/journal.orgcaptmpl"))
        ;; For marked area
        ("c"    ; key
         "Code" ; name
         entry  ; type
         (file+headline "~/notes.org" "Code") ; target
         "* TODO %^{TITLE} %^G\n:PROPERTIES:\n:Created: %U:Source: %a\n:END:\n%i%?" ; template
         :prepend t   ; properties
         :empty-lines 1   ; properties
         :created t   ; properties
         :kill-buffer t) ; properties
        ))


(use-package paredit
  :ensure t)

;; Promela for software engineering using formal methods
;; (add-to-list 'load-path "/home/neon/Documents/TDA294/promela-mode")
;; (require 'promela-mode)
;; (add-to-list 'auto-mode-alist '("\\.pml\\'" . promela-mode))
;; (setq promela-auto-match-delimiter nil)



(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'go-guru)




(use-package go-mode
  :ensure t
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "C-c i") 'go-goto-imports)))
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "M-.") 'godef-jump)))
  (add-hook 'go-mode-hook
      (lambda ()
        (set (make-local-variable 'company-backends) '(company-go))
        (company-mode)))
  (add-hook 'go-mode-hook (lambda()
                            (setq default-tab-width 4)))
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode))

;; C-x C-l nice function
(put 'downcase-region 'disabled nil)

;; I like line numbers atm
;;(global-linum-mode 1)
(global-display-line-numbers-mode)


(setq linum-format "%d") ;; leave extra space to allow for other indicators

(use-package slime
  :ensure t
  :config
  ;; Set your lisp system and, optionally, some contribs
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy))
  (add-hook 'slime-lisp-mode-hook 'paredit-mode)
  )

;; https://emacs.stackexchange.com/questions/3374/set-the-background-of-org-exported-code-blocks-according-to-theme
(defun my/org-inline-css-hook (exporter)
  "Insert custom inline css to automatically set the
background of code to whatever theme I'm using's background"
  (when (eq exporter 'html)
    (let* ((my-pre-bg (face-background 'default))
           (my-pre-fg (face-foreground 'default)))
      (setq
       org-html-head-extra
       (concat
        org-html-head-extra
        (format "<style type=\"text/css\">\n pre.src {background-color: %s; color: %s;}</style>\n"
                my-pre-bg my-pre-fg))))))

(add-hook 'org-export-before-processing-hook 'my/org-inline-css-hook)

(global-set-key (kbd "C-c C-1") 'ispell-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "C-c 1") 'flyspell-check-next-highlighted-word)


(put 'upcase-region 'disabled nil)

;; Take away the scroll bar
(scroll-bar-mode -1)
(global-set-key (kbd "C-;") #'comment-line)

;; trying to fix font
(add-to-list 'default-frame-alist
                       '(font . "DejaVu Sans Mono-16"))


(use-package color-theme
  :ensure t)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'cython-mode-hook 'highlight-indent-guides-mode)
(add-hook 'python-mode-hook 'superword-mode)

(use-package magithub
  :after magit
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/github"))

(use-package prettier-js
  :ensure t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode))

(setq-default word-wrap t)

(setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
(setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
(setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line


(setq elpy-rpc-python-command "python3.6")
(setq comint-scroll-to-bottom-on-input t)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(define-key c++-mode-map [f5] #'compile)
