;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Charles Miquelon"
      user-mail-address "miqueloncharles@gmail.com")

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
(setq doom-font (if IS-MAC
                    (font-spec :family "Fira Code")
                  (font-spec :family "Fira Code Retina" :size 24)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:


;; emacs-mac
(setq doom-theme (if (if IS-MAC
                         (equal (plist-get (mac-application-state) :appearance)
                                "NSAppearanceNameDarkAqua")
                       (let ((hour (decoded-time-hour (decode-time (current-time)))))
                         (or (< hour 6) (> hour 18))))
                     'doom-vibrant
                   'doom-one-light))

;; ;; emacs-plus
;; (add-hook 'ns-system-appearance-change-functions #'(lambda (appearance)
;;                                                      (mapc #'disable-theme custom-enabled-themes)
;;                                                      (pcase appearance
;;                                                        ('light (load-theme 'doom-one-light t))
;;                                                        ('dark (load-theme 'doom-vibrant t)))))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

;; auto-fill
(add-hook! (emacs-lisp-mode) #'auto-fill-mode)

;; auto-format
(delete 'emacs-lisp-mode +format-on-save-enabled-modes)

;; alert
(use-package alert
  :config
  (setq alert-default-style 'osx-notifier))

;; org
(require 'org-habit)

(map! :leader

      :desc "Grab Mac link" "nL" #'org-mac-grab-link

      :prefix ("T" . "timer")
      :desc "set" "s" #'org-timer-set-timer
      :desc "stop" "k" #'org-timer-stop
      :desc "pause/continue" "p" #'org-timer-pause-or-continue)

(setq org-show-notification-handler 'alert)

;; auto-mode
(dolist (extension-mode '(("\\.rain\\'" . web-mode)))
  (add-to-list 'auto-mode-alist extension-mode))

;; css
(setq css-indent-offset 2)

;; smart-semicolon
(add-hook 'js-mode-hook #'smart-semicolon-mode)
