;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
(setq doom-font "JetBrains Mono")
;; (setq doom-font "Consola Mono")
;; (setq doom-font "DejaVu Serif")
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-monokai-pro)
(setq doom-theme 'net-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(set-face-attribute 'default nil :height 150)


(setq evil-shift-width 4)

(setq display-line-numbers-type 'relative)

(setq olivetti-body-width 0.6)
(global-set-key (kbd "<f9>") 'olivetti-mode)

;;;; Require

(org-super-agenda-mode)
;; Load other personal config files
(load "~/.dots/doom_emacs/.config/doom/org-config.el")


(setq org-roam-directory "/home/raceer/11_Syncthing/40_Notes/42_Org/roam")

(setq org-roam-completion-everywhere nil)

(setq which-key-use-C-h-commands t)

;; Ensure LSP is configured to use Pyright
;; (after! lsp-mode
;;   (setq lsp-python-ms-executable (executable-find "pyright"))
;;   (setq lsp-enable-symbol-highlighting t)
;;   (setq lsp-enable-file-watchers t))
;;
(after! lsp-mode
    (setq lsp-pyright-langserver-command "pyright")
    (setq lsp-enable-symbol-highlighting t)
    (setq lsp-enable-file-watchers t))

(map! "C-/" #'comment-line)

(use-package! gptel
  :config
  (setq! gptel-api-key (getenv "OPENAI_API_KEY"))
  (setq gptel-default-mode 'org-mode))

;; (map! "C-n" #'evil-next-visual-line)
;;       ;; "C-p" #'evil-previous-visual-line)

;; (define-key evil-normal-state-map (kbd "C-p") 'evil-previous-visual-line)
;; (define-key evil-normal-state-map (kbd "C-n") 'evil-next-visual-line)

(after! evil
    (map! :map evil-normal-state-map
        "C-n" #'evil-next-visual-line
        "C-p" #'evil-previous-visual-line))


(use-package nand-hdl-mode
  :load-path "~/.config/emacs/modules/lang/nand-hdl-mode")

(visual-line-mode 1)
