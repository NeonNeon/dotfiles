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

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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
     (emacs-lisp . t)
     ))

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)


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

(add-hook 'jde-mode-hook 'my-jde-mode-hook)
(add-hook 'java-mode-hook 'my-jde-mode-hook)

(setq jdee-server-dir "/home/neon/myJars/jdeeserver")



;; Autocomplete tabs Not needed anymore.
; (global-set-key (kbd "C-<tab>") 'dabbrev-expand)
; (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; Better scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; Erlang indentation
(setq erlang-indent-level 4)

;; Fix zsh shell
(setenv "ESHELL" (expand-file-name "~/bin/eshell"))


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
 (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")

;; better pdf viewer.
(pdf-tools-install)
