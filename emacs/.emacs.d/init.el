;;; Leo's Emacs Init

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;-------------------------------------------------------------------------------

;;; disable menu bar
(menu-bar-mode -1)

;; No splash screen
(setq inhibit-startup-screen t)

;;; saves the desktop session
(desktop-save-mode 1)

;;; chose a startup theme
;(load-theme 'deeper-blue t)
(load-theme 'zenburn t)

;;; turn off the bell
(setq visible-bell 1)

;; save emacs backup files to /tmp
 (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;;; Use 4 spaces instead of tab.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;; Cursor and mouse.
(global-hl-line-mode t)           ; Highlight cursor line
(blink-cursor-mode 0)             ; No blinking cursor
(setq mouse-yank-at-point t)      ; Paste at cursor position
(set-cursor-color "yellow")       ; Cursor color
(mouse-wheel-mode t)              ; Mouse-wheel enabled

;(setq auto-save-default nil)
;(set-default-font "Consolas-11")
(set-frame-font "Anonymous Pro-14")

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;(setq-default whitespace-style '(face trailing lines empty indentation::space))
;(setq-default whitespace-line-column 80)
;(global-whitespace-mode t)

;; disable auto wrapping
(add-hook 'html-mode-hook '(lambda () (auto-fill-mode 0)))

;; map f5 to revert buffer.
(global-set-key [f5] 'revert-buffer)

;-------------------------------------------------------------------------------

;; Octave mode
;; http://cliodhna.cop.uop.edu/~hetrick/localdoc/octave/octave_34.html
;;
;; To begin using Octave mode for all `.m' files you visit, add the following lines to a file loaded by Emacs at startup time, typically your `~/.emacs' file:
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
;; Finally, to turn on the abbrevs, auto-fill and font-lock features automatically, also add the following lines to one of the Emacs startup files:
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))


;;; R Mode
;;;(require 'ess-site)
;;;(setq ess-history-directory "~/.R/")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;             GO LANG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Articles
;;; http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/
;;; DOTFILES EXAMPLE: https://github.com/dominikh/dotfiles/blob/master/emacs
;;;
;;; Flycheck: http://rz.scale-it.pl/2013/03/04/emacs_on_fly_syntax_checking_for_go_programming_language.html
;;;
;;; Install the following go packages:
;;; go get github.com/nsf/gocode

(defvar gofmt-command "goimports")
(require 'go-mode-load)
(add-hook 'before-save-hook 'gofmt-before-save)

;;; yasnippets
;(add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-go")
;(defvar yas-snippet-dirs "~/.emacs.d/yasnippet-go")
;(require 'yasnippet) ;; not yasnippet-bundle
;    (yas-global-mode 1)


;;; go autocomplete works with auto-complete mode and company mode.
;;; https://github.com/nsf/gocode
(require 'auto-complete)
(require 'go-autocomplete)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(add-hook 'go-mode-hook 'auto-complete-mode)

;;; go-errcheck
;;; https://github.com/dominikh/go-errcheck.el
(require 'go-errcheck)

;;; flycheck

;; To enable Flycheck mode in all buffers, in which it can be used:
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; go-eldoc
(require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)

;-------------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configuration for cc-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cc-mode)

(add-hook 'c-mode-hook
          (lambda ()
            (c-set-style "linux")))


;-------------------------------------------------------------------------------

(provide `init)
;;; init.el ends here
