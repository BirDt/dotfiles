;; Fixes a MELPA 403
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Utility functions
(defun pick-rand (lst)
  (nth (random (length lst)) lst))

(defun exec-exists? (cmd)
  (not (string-match-p (regexp-quote "command not found")
		   (shell-command-to-string (format "%s --version" cmd)))))

(defvar small-screen nil) ; set this to nil on normal devices, t for small screens (like a uConsole)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(eww-search-prefix "https://search.cyan.sh/search?q=")
 '(package-selected-packages
   '(geiser-racket graphql-mode sqlite3 goto-line-preview markdown-mode treemacs typescript-mode forge magit org-modern geiser-chicken rainbow-delimiters ac-geiser paredit geiser-guile gnu-elpa-keyring-update geiser auto-complete smart-mode-line dimmer beacon dashboard page-break-lines auto-package-updates)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dashboard-heading ((t (:inherit font-lock-keyword-face :foreground "light coral"))))
 '(font-lock-builtin-face ((t (:foreground "plum"))))
 '(font-lock-comment-face ((t (:foreground "#F05D5E"))))
 '(font-lock-function-name-face ((t (:foreground "light cyan"))))
 '(font-lock-keyword-face ((t (:foreground "sky blue"))))
 '(font-lock-string-face ((t (:foreground "#FF66B3"))))
 '(mode-line ((t (:background "#4C5C68" :foreground "#F05D5E" :inverse-video nil))))
 '(mode-line-emphasis ((t (:weight normal))))
 '(mode-line-inactive ((t (:background "#53595D" :foreground "#BD7979" :inverse-video nil))))
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :foreground "firebrick"))))
 '(sml/filename ((t (:inherit sml/global :foreground "#F05D5E" :weight bold))))
 '(sml/global ((t (:foreground "#DCDCDD" :inverse-video nil)))))

;;; MELPA Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)

;;; First Time Setup
;; Check if the user-emacs-directory exists; if not, create it
(unless (file-exists-p user-emacs-directory)
  (make-directory user-emacs-directory))

;; Create the check-file path
(defvar first-time-setup-file
  (expand-file-name "first-time-setup-done" user-emacs-directory))

;; If the check-file doesn't exist, set first-time-setup to true and create the file
(setq first-time-setup (not (file-exists-p first-time-setup-file)))
(when first-time-setup
  (write-region "" nil first-time-setup-file))

;;;; UI Enhancement
;; No bell
(setq ring-bell-function 'ignore)

;; Color Scheme
(set-foreground-color "#FFE8E8") ; foreground
(set-background-color "#3A3C40") ; background
(set-cursor-color "#C5C3C6") ; cursor
(set-face-attribute 'region nil :background "#D5D5D5") ; selection

;; Set default font size
(set-face-attribute 'default nil :height (if small-screen 100 80))

;; Custom text-scale function with default scale
(defun set-default-text-scale (&optional default-scale)
  (interactive)
  (let ((default-scale (or default-scale 0)))
    (text-scale-set default-scale)))

;; Keybindings for text-scale
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") '(lambda () (interactive) (set-default-text-scale)))

;; Smart line wrapping
(global-visual-line-mode)

;; Use y instead of yes, etc
(if (>= emacs-major-version 29)
    (setopt use-short-answers t)
  (defalias 'yes-or-no-p 'y-or-n-p))

;; Display line numbers in programming modes
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; zone after 5 minutes
(require 'zone)
(zone-when-idle 300)

;; Hide toolbar
(tool-bar-mode -1)

;; Don't show scrollbars
(scroll-bar-mode -1)

;;; Page Break Lines
(global-page-break-lines-mode)

;;; Dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;; Set title
(setq dashboard-banner-logo-title
      (pick-rand '("Welcome to Emacs"
		   "Welcome to Emac"
		   "Emac"
		   "E"
		   "Lisp Machine")))

;; Set banner & centre
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-vertically-center-content t)

;; Dashboard items
(setq dashboard-items '((recents . 5)
			(projects . 5)
			(bookmarks . 5)
			(registers . 5)))

(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-newline
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer))

;; Footer message
(setq dashboard-footer-messages
      '("Back again?"
	"Have you read your SICP today?"
	"The programmer must seek both perfection of part\nand adequacy of collection."
	"Programs must be written for people to read,\nand only incidentally for machines to execute."
	"One man's constant is another man's variable."
	"Optimization hinders evolution."
	"Simplicity does not precede complexity, but follows it."
	"Fools ignore complexity.\nPragmatists suffer it.\nSome can avoid it.\nGeniuses remove it."
	"Programming is an unnatural act."
	"There will always be things we wish to say in our programs\nthat in all known languages can only be said poorly."
	"It is easier to write an incorrect program\nthan understand a correct one."
	"A LISP programmer knows the value of everything,\nbut the cost of nothing."
	"Beware of the Turing tar-pit in which everything is possible\nbut nothing of interest is easy."))

;; Use icons
(setq dashboard-icon-type 'all-the-icons)

;;; Beacon
(beacon-mode 1)
(setq beacon-color "#D5D5D5")

;;; Dimmer
(require 'dimmer)
(dimmer-configure-which-key)
(dimmer-mode t)
(setq dimmer-fraction 0.35)

;;; Smart Mode Line
(sml/setup)
(setq sml/theme 'dark)

;;; Treemacs
(unless small-screen
  (treemacs-start-on-boot)
  (treemacs-git-mode 'deferred)
  (treemacs-indent-guide-mode))

;; Bind keys
(global-set-key (kbd "<f8>") 'treemacs)

;;;; Editing
;; Don't pop up UI dialogs
(setq use-dialog-box nil)

;; Save place in file
(save-place-mode 1)

;; Replace selection when pasting
(delete-selection-mode 1)

;; Start maximized
(toggle-frame-maximized)

;; Fullscreen and maximize button
(global-set-key (kbd "C-x <f10>") 'toggle-frame-maximized)
(global-set-key (kbd "C-x <f11>") 'toggle-frame-fullscreen)

;; Windmove bindings
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Create small buffer below
(defun create-tiny-buffer (&optional buf)
  (interactive)
  (let ((new-buffer (generate-new-buffer "*tiny-buffer*"))
        (window (split-window-below -5)))
    (set-window-buffer window new-buffer)
    (select-window window)
    (when buf ; If a buffer was passed in as a symbol, use it instead of the empty *tiny-buffer*
      (funcall buf)
      (kill-buffer new-buffer))))

(global-set-key (kbd "C-x <f8>") 'create-tiny-buffer)

;; Hotkey for creating a mini shell
(defun mini-shell ()
  (interactive)
  (create-tiny-buffer
   (if (project-current)
       'project-shell
     'shell)))

(global-set-key (kbd "M-RET") 'mini-shell)

;; Glasses mode for kebab-case identifier
(setq glasses-separator "-")
(setq glasses-uncapitalize-p t)
(setq glasses-uncapitalize-regexp "[A-z]")
(add-hook 'prog-mode-hook 'glasses-mode)

;;; CI
;; Hotkey to quickly open emacs init
(global-set-key (kbd "C-x <f12>") (lambda() (interactive)(find-file "~/.emacs")))

;;; Devcontainers
(defun devcontainer-project-shell ()
  (interactive)
  (create-tiny-buffer 'project-shell)
  (insert "devcontainer exec --workspace-folder . bash")
  (comint-send-input))

;;; goto-line-preview
(global-set-key [remap goto-line] 'goto-line-preview) ; Always use goto-line-preview instead of goto-line
(setq goto-line-preview-hl-duration 0.5) ; Highlight for 0.5 seconds

;; Global key shortcut for goto-line-preview
(global-set-key (kbd "C-x <f4>") 'goto-line-preview)

;;; Autocomplete Mode
;; Enable autocomplete mode in prog modes
(add-hook 'prog-mode-hook 'auto-complete-mode)

;; Enable autocomplete mode with ac-geiser
(require 'ac-geiser)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'geiser-repl-mode))

;;;; Modes
;; Enable show-paren-mode in prog modes
(add-hook 'prog-mode-hook 'show-paren-mode)

;;; Paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;; Org Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)))

;;; Org Modern
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;;; Rainbow Delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; Markdown Mode
;; Preserve the C-c <dir> windmove keybinds
(eval-after-load "markdown-mode"
  '(progn
     (define-key markdown-mode-map (kbd "C-c <left>") nil)
     (define-key markdown-mode-map (kbd "C-c <right>") nil)
     (define-key markdown-mode-map (kbd "C-c <up>") nil)
     (define-key markdown-mode-map (kbd "C-c <down>") nil)
     (define-key markdown-mode-map (kbd "C-c <left>") 'windmove-left)
     (define-key markdown-mode-map (kbd "C-c <right>") 'windmove-right)
     (define-key markdown-mode-map (kbd "C-c <up>") 'windmove-up)
     (define-key markdown-mode-map (kbd "C-c <down>") 'windmove-down)))

;;; Magit
;; Forge init
(with-eval-after-load 'magit
  (require 'forge))

;;;; Languages
;;; Geiser
;; Set scratch pad major mode to Geiser
(setq initial-major-mode 'scheme-mode)

;; Make guile the default scheme, unless it doesn't exist in which case use racket
(setq geiser-default-implementation
      (if (and (not(exec-exists? "guile"))
	       (exec-exists? "racket"))
	  'racket
	'guile))

;;; Typescript
;; Indent to 2 spaces by default
(setq typescript-indent-level 2)

;;;; Automatic Updates/Sync
(package-refresh-contents)
(auto-package-update-maybe)
