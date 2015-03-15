;;; Leo's Emacs Init

(setq warning-suppress-types nil)
(setq debug-on-error t)

;;; Code:
;; (require 'package)
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa.milkbox.net/packages/")))
;; (package-initialize)

(require 'cl)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    magit
    yasnippet
    company
    company-go
    exec-path-from-shell
    f
    flycheck
    gnu-apl-mode
    go-autocomplete
    go-direx
    go-eldoc
    go-errcheck
    go-mode
    go-play
    go-snippets
    grandshell-theme
    gruber-darker-theme
    hemisu-theme
    highlight-current-line
    highlight-parentheses
    pkg-info
    solarized-theme
    soothe-theme
    tango-2-theme
    tangotango-theme
    yaml-mode
    zenburn-theme
    ) "a list of packages to ensure are installed at launch.")

					; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

					; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
					; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
					; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))


;-------------------------------------------------------------------------------

;;; Get env path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH"))

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

;;; Scrolling without moving the point
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))
(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))
(global-set-key "\M-p" 'gcm-scroll-down)
(global-set-key "\M-n" 'gcm-scroll-up)

;;; Cursor and mouse.
(global-hl-line-mode t)           ; Highlight cursor line
(blink-cursor-mode 0)             ; No blinking cursor
(setq mouse-yank-at-point t)      ; Paste at cursor position
(set-cursor-color "yellow")       ; Cursor color
;;;(mouse-wheel-mode t)              ; Mouse-wheel enabled
(when (require 'mwheel nil 'noerror)
  (mouse-wheel-mode t))

;(setq auto-save-default nil)
(set-default-font "Consolas-10")
;(set-frame-font "Anonymous Pro-12")
;(set-frame-font "DejaVu Sans Mono-12")

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;(setq-default whitespace-style '(face trailing lines empty indentation::space))
;(setq-default whitespace-line-column 80)
;(global-whitespace-mode t)

;; disable auto wrapping
(add-hook 'html-mode-hook '(lambda () (auto-fill-mode 0)))

;; map f5 to revert buffer.
(global-set-key [f5] 'revert-buffer)

;; Display time.
(display-time)

;; Highlight cursor line.
(global-hl-line-mode 1)

;; Highlight matching parenthesis.
(global-highlight-parentheses-mode 1)

;-------------------------------------------------------------------------------

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

(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
(defun my-go-mode-hook ()
  (setq gofmt-command "goimports") ; Use goimports instead of go-fmt
  (add-hook 'before-save-hook 'gofmt-before-save)  ; Call Gofmt before saving
  (if (not (string-match "go" compile-command)) ; Customize compile command to run go build
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)) ; Godef jump key binding
(go-oracle-mode) ; Go Oracle
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;; autocomplete using company mode
(require 'company)                                   ; load company mode
(require 'company-go)                                ; load company mode go backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

;;; go-errcheck
;;; https://github.com/dominikh/go-errcheck.el
(require 'go-errcheck)

;;; flycheck

;; To enable Flycheck mode in all buffers, in which it can be used:
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; go-eldoc
(require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)

;;; yasnippets
(yas-global-mode 1)
(setq yas-snippet-dirs (append yas-snippet-dirs '("~/.emacs.d/yassnippet-go")))

;; go lint
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

;-------------------------------------------------------------------------------


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configuration for cc-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cc-mode)

(add-hook 'c-mode-hook
          (lambda ()
            (c-set-style "linux")))


;-------------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configuration for APL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'gnu-apl-mode)

(defun em-gnu-apl-init ()
  (setq buffer-face-mode-face 'gnu-apl-default)
  (buffer-face-mode))

(add-hook 'gnu-apl-interactive-mode-hook 'em-gnu-apl-init)
(add-hook 'gnu-apl-mode-hook 'em-gnu-apl-init)

;-------------------------------------------------------------------------------

(provide `init)
;;; init.el ends here
