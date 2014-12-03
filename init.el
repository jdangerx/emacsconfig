;; Adding package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path)) ; doesn't actually add .emacs.d, only subdirs

;; general purpose shortcuts
(global-set-key (kbd "C-x r") 'revert-buffer)

;; frame-oriented
(setq default-frame-alist
      '((font . "Source Code Pro 14") (scroll-bar-mode . nil)))
(setq pop-up-frames t)
(global-set-key (kbd "C-x 3") 'new-frame)

;; unique buffer name
(require 'uniquify)

;; evil!
(require 'evil)
(setq evil-default-state 'normal)
(setq evil-default-cursor t)
(evil-mode 1)
(setq-default truncate-lines 1)

;; linum-relative
(require 'linum-relative)

;;; quits that make sense
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'keyboard-quit)

; evil-surround
(require 'surround)
(global-surround-mode 1)

;; better comments
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-logical-line)))
(global-set-key "\M-;" 'comment-or-uncomment-region-or-line)

;; Setup Auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(global-set-key (kbd "<backtab>") 'dabbrev-expand)
(add-hook 'after-init-hook 'abbrev-mode)

;; auto-indent
(global-set-key (kbd "RET") 'newline-and-indent)

;; Flycheck
(require 'flycheck-autoloads)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'js-mode-hook 'flycheck-mode)
(add-hook 'haskell-mode-hook 'flycheck-mode)

;; Python mode
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))
(add-hook 'python-mode-hook (function (lambda () (setq python-indent-offset 4))))
(add-hook 'python-mode-hook (function (lambda () (setq evil-shift-width python-indent-offset))))
(require 'ein)

;; css mode
(add-hook 'css-mode-hook 'rainbow-mode)

;; Javascript mode
(setq js-indent-level 2)
(add-hook 'js-mode-hook
          (function (lambda ()
                      (setq evil-shift-width js-indent-level))))

;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook
          (function (lambda ()
                      (setq evil-shift-width js-indent-level))))

;; SLIME
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "ccl")

;; Lisp mode
;; (add-hook 'lisp-mode-hook 'slime-mode)
;; (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

;; haskell-mode
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; C mode
(setq c-default-style "linux"
      c-basic-offset 2)
(add-hook 'c-mode-hook
   (function (lambda () (setq evil-shift-width c-basic-offset))))

;; LaTeX mode
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'fill-nobreak-predicate 'texmathp)))

;; deft-mode
(require 'deft)
(setq deft-use-filename-as-title t)
(evil-set-initial-state 'deft-mode 'emacs)
(global-set-key [f5] 'deft)

;; Spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; save session
(require 'desktop)
  (desktop-save-mode 1)
  (defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
  (add-hook 'auto-save-hook 'my-desktop-save)

;; ido-mode
(require 'ido)
(ido-mode t)

;; ;; Long-line highlighting
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; trim whitespace
(require 'ws-trim)
(global-set-key (kbd "C-x t") 'ws-trim-buffer)
(set-default 'ws-trim-level 2)
(setq ws-trim-global-modes '(guess (not message-mode eshell-mode)))

;; prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;=============================================================================

;; Cosmetics
;; themes
(add-hook 'after-init-hook (lambda () (load-theme 'solarized-light)))
;; (add-hook 'after-init-hook (lambda () (load-theme 'zenburn)))

;; Nyan-mode
(require 'nyan-mode)
(nyan-mode t)
(nyan-start-animation)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(background-mode light)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(deft-directory "/home/john/Dropbox/deft/")
 '(deft-extension "md")
 '(deft-text-mode (quote markdown-mode))
 '(flycheck-display-errors-function (quote flycheck-display-error-messages))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(rainbow-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(whitespace-line-column 99))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-warning ((t (:underline (:color "dim gray" :style wave)))))
 '(which-func ((t (:foreground "gainsboro"))) t))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
