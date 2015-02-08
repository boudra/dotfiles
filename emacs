(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'cl)
(require 'iso-transl)

(defvar my-packages
  '(evil flycheck color-theme-sanityinc-tomorrow yasnippet
	 emmet-mode evil-surround evil-numbers evil-nerd-commenter evil-leader
	 )
  "A list of packages to ensure are installed at launch.")
 
(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))
 
(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; Evil
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
 "w" 'save-buffer
 "e" 'find-file
)

(evil-mode 1)
(global-evil-surround-mode 1)
(evilnc-default-hotkeys)

(global-set-key (kbd "C-a") 'mark-whole-buffer)

;; Yasnippet
(yas-global-mode 1)

;; Emmet
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(load-theme 'sanityinc-tomorrow-night t)

(add-to-list 'default-frame-alist '(font . "Inconsolata for Powerline Medium 11"))
(set-face-attribute 'default t :font "Inconsolata for Powerline Medium 13")

;;; esc quits

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
