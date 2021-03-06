;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name    "Mitch Gamburg"
      user-mail-address "mitch.gamburg@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq current-theme 'doom-solarized-dark) ;; want to use nord but it sucks for racket rn

(setq doom-theme 'doom-solarized-dark)
(add-hook 'racket-mode-hook (lambda () (set-face-foreground 'racket-keyword-argument-face "#b58900")))
;; FIXME doesn't work
;; (when (eq current-theme 'doom-solarized-dark)
;;   (add-hook 'racket-mode-hook (lambda () (set-face-foreground 'racket-keyword-argument-face "#b58900"))))

;; FIXME this doesn't load on start, need to run doom/reload
;; quoted expressions should also be orange
(set-face-foreground 'font-lock-variable-name-face "default")

(add-hook 'racket-mode-hook (lambda () (set-face-foreground 'racket-keyword-argument-face "#b58900")))

;; (set-background-color "#35446f")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '(org-directory))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)



;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! evil-snipe (evil-snipe-mode -1))

(add-hook 'racket-repl-mode-hook
          (lambda () (define-key racket-repl-mode-map (kbd "\C-w") nil)))

(add-hook 'racket-mode-hook (lambda () (setq racket-smart-open-bracket-mode nil)))

;; (setq tuareg-highlight-all-operators 1)
;; this doesn't work :sad-face:
;; (add-hook 'tuareg-mode-hook #'(lambda () (setq mode-name "🐫")))

;; (setq doom-modeline-icon (display-graphic-p))
;; (setq doom-modeline-major-mode-icon t)

;; (face-spec-set
;;  'tuareg-font-lock-constructor-face
;;  '((((class color) (background light)) (:foreground "SaddleBrown"))
;;    (((class color) (background dark)) (:foreground "#859900"))))

(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;; produce message containing the face for the text under the cursor
(defun what-face (pos)
  (interactive "d")
  (hl-line-mode -1)
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (hl-line-mode +1)
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun create-typed-egg ()
  (interactive)
  (let ((fname (read-string "Egg file name: ")))
    (shell-command (concat "touch " fname ".egg"))
    (shell-command (concat "touch " fname ".out"))
    (shell-command (concat "touch " fname ".options"))
    (shell-command (concat "echo check >" fname ".options"))
    (find-file (concat fname ".egg"))
    (split-window-right)
    (other-window 1)
    (find-file (concat fname ".out"))
    (other-window 1)))

(defun create-egg ()
  (interactive)
  (let ((fname (read-string "Egg file name: ")))
    (shell-command (concat "touch " fname ".egg"))
    (shell-command (concat "touch " fname ".out"))
    (find-file (concat fname ".egg"))
    (split-window-right)
    (other-window 1)
    (find-file (concat fname ".out"))
    (other-window 1)))

(defun create-typed-err-egg ()
  (interactive)
  (let ((fname (read-string "Egg file name: ")))
    (shell-command (concat "touch " fname ".egg"))
    (shell-command (concat "touch " fname ".err"))
    (shell-command (concat "touch " fname ".options"))
    (shell-command (concat "echo check >" fname ".options"))
    (find-file (concat fname ".egg"))
    (split-window-right)
    (other-window 1)
    (find-file (concat fname ".err"))
    (other-window 1)))

(defun create-err-egg ()
  (interactive)
  (let ((fname (read-string "Egg file name: ")))
    (shell-command (concat "touch " fname ".egg"))
    (shell-command (concat "touch " fname ".err"))
    (find-file (concat fname ".egg"))
    (split-window-right)
    (other-window 1)
    (find-file (concat fname ".err"))
    (other-window 1)))

;; (defun abstract-create-egg (typed? err?)
;;   (lambda ()
;;     (interactive)
;;     (let ((test-name (read-string "Egg file name: ")))
;;       (let ((fname (concat test-name ".egg"))
;;             (output-fname (concat test-name (if err? ".err" ".out")))
;;             (opts-fname (concat test-name ".options")))
;;         (shell-command (concat "touch " fname))
;;         (shell-command (concat "touch" output-fname))
;;         (when typed? (shell-command (concat "echo check >" opts-fname)))
;;         (find-file fname)
;;         (split-window-right)
;;         (other-window 1)
;;         (find-file output-fname)
;;         (other-window 1)))))

(setq flycheck-global-modes '(not racket-mode racket-repl-mode))
