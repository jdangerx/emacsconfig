;; Adding package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

;; el-get
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;; evil!
(require 'evil)
(setq evil-default-state 'normal)
(setq evil-default-cursor t)
(evil-mode 1)

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

;; auto-indent
(global-set-key (kbd "RET") 'newline-and-indent)

;; Flycheck
(require 'flycheck-autoloads)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Text mode
(add-hook 'text-mode-hook 'auto-complete-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

;; Python mode
(add-hook 'python-mode-hook 'auto-complete-mode)

;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; SLIME
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "ccl")

;; Lisp mode
(add-hook 'lisp-mode-hook 'slime-mode)
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

;; C mode
(setq c-default-style "linux"
      c-basic-offset 2)

;; deft-mode
(require 'deft)
(setq deft-use-filename-as-title t)
(global-set-key [f5] 'deft)

;; Smart Home
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key [home] 'smart-beginning-of-line)

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

;; Long-line highlighting
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; trim whitespace
(require 'ws-trim)
(global-ws-trim-mode t)
(set-default 'ws-trim-level 2)
(setq ws-trim-global-modes '(guess (not message-mode eshell-mode)))

;===============================================================================

;; Cosmetics
(set-frame-font "Source Code Pro 10")
;; (set-frame-font "Inconsolata 12")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20130716.1457/")
(load-theme 'zenburn t)

;; Nyan-mode
;; (add-to-list 'load-path "~/.emacs.d/elpa/nyan-mode-20120710.1922/")
(require 'nyan-mode)
(nyan-mode t)
(nyan-start-animation)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#657b83" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#fdf6e3"))
 '(ansi-term-color-vector [unspecified "#1F1611" "#660000" "#144212" "#EFC232" "#5798AE" "#BE73FD" "#93C1BC" "#E6E1DC"])
 '(column-number-mode t)
 '(deft-extension "md")
 '(deft-text-mode (quote markdown-mode))
 '(fci-rule-character-color "#452E2E")
 '(fci-rule-color "#452E2E")
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-func ((t (:foreground "gainsboro"))) t))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
