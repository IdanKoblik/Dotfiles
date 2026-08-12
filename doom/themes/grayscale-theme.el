;;; grayscale-theme.el --- port of my Neovim grayscale colorscheme -*- lexical-binding: t; -*-

;;; Commentary:
;; A port of ~/.config/nvim/lua/colors/grayscale.lua to Emacs.
;;
;; The Neovim original is almost entirely monochrome: keywords are bright white
;; and bold, identifiers/functions are mid-gray, operators and punctuation sink
;; into the comment gray, and only three hues exist at all -- a sage green for
;; strings/constants, a warm tan for types, and green/red for diffs.
;;
;; Tree-sitter capture groups have no direct Emacs equivalent, so they are
;; folded onto the Emacs 29+ font-lock faces that fire in the same places
;; (@function.call -> font-lock-function-call-face, @operator and
;; @punctuation.* -> font-lock-operator-face / -punctuation-face, and so on).

;;; Code:

(deftheme grayscale
  "Near-monochrome dark theme, ported from the Neovim colorscheme of the same name.")

(let ((bg        "#000000")
      (fg        "#909090")
      (white     "#b0b0b0")
      (accent    "#bbb0a0")
      (comment   "#545454")
      (constant  "#a0b8a0")
      (blackish  "#202020")
      (selection "#383838")
      (diff-add  "#68bb26")
      (diff-del  "#fb4934"))

  (custom-theme-set-faces
   'grayscale

;;; Core UI  (Normal, LineNr, CursorLine, Visual, StatusLine)
   `(default                      ((t (:foreground ,fg :background ,bg))))
   `(cursor                       ((t (:background ,white))))
   `(fringe                       ((t (:foreground ,comment :background ,bg))))
   `(shadow                       ((t (:foreground ,comment))))
   `(highlight                    ((t (:background ,selection))))
   ;; CursorLine is bg-on-bg in the original: the current line is not tinted.
   `(hl-line                      ((t (:background ,bg :extend t))))
   `(region                       ((t (:background ,selection :extend t))))
   `(secondary-selection          ((t (:background ,blackish :extend t))))
   `(line-number                  ((t (:foreground ,comment :background ,bg))))
   `(line-number-current-line     ((t (:foreground ,white :background ,bg :weight bold))))
   `(minibuffer-prompt            ((t (:foreground ,white :weight bold))))
   `(trailing-whitespace          ((t (:background ,blackish))))
   `(fill-column-indicator        ((t (:foreground ,blackish))))
   `(escape-glyph                 ((t (:foreground ,accent))))
   `(homoglyph                    ((t (:foreground ,accent))))
   `(link                         ((t (:foreground ,white :underline t))))
   `(link-visited                 ((t (:foreground ,accent :underline t))))
   `(tooltip                      ((t (:foreground ,fg :background ,blackish))))
   `(error                        ((t (:foreground ,diff-del :weight bold))))
   `(warning                      ((t (:foreground ,accent :weight bold))))
   `(success                      ((t (:foreground ,diff-add :weight bold))))

   ;; WinSeparator links to Normal upstream, so the divider takes the body
   ;; foreground rather than a dimmed one.
   `(vertical-border              ((t (:foreground ,fg :background ,bg))))
   `(window-divider               ((t (:foreground ,fg))))
   `(window-divider-first-pixel   ((t (:foreground ,fg))))
   `(window-divider-last-pixel    ((t (:foreground ,fg))))
   `(border                       ((t (:foreground ,blackish :background ,blackish))))
   `(internal-border              ((t (:background ,bg))))
   `(child-frame-border           ((t (:background ,blackish))))

;;; MatchParen -- deliberately flat in the original (fg on bg, no highlight)
   `(show-paren-match             ((t (:foreground ,fg :background ,bg))))
   `(show-paren-match-expression  ((t (:background ,blackish))))
   `(show-paren-mismatch          ((t (:foreground ,diff-del :background ,bg :weight bold))))

;;; Search
   `(isearch                      ((t (:foreground ,white :background ,selection :weight bold))))
   `(isearch-fail                 ((t (:foreground ,diff-del :background ,bg :weight bold))))
   `(lazy-highlight               ((t (:foreground ,fg :background ,blackish))))
   `(match                        ((t (:foreground ,white :background ,selection))))

;;; StatusLine / StatusLineNC
   `(mode-line                    ((t (:foreground ,white :background ,blackish))))
   `(mode-line-active             ((t (:foreground ,white :background ,blackish))))
   `(mode-line-inactive           ((t (:foreground ,fg :background ,blackish))))
   `(mode-line-buffer-id          ((t (:foreground ,white :weight bold))))
   `(mode-line-emphasis           ((t (:foreground ,white :weight bold))))
   `(mode-line-highlight          ((t (:background ,selection))))
   `(header-line                  ((t (:foreground ,white :background ,blackish))))

;;; Syntax  (Keyword, Identifier, Operator, Comment, String, Function, Type)
   `(font-lock-keyword-face             ((t (:foreground ,white :weight bold))))
   `(font-lock-builtin-face             ((t (:foreground ,white :weight bold))))
   `(font-lock-escape-face              ((t (:foreground ,white :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,white :weight bold))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,white :weight bold))))

   `(font-lock-variable-name-face       ((t (:foreground ,fg))))
   `(font-lock-variable-use-face        ((t (:foreground ,fg))))
   `(font-lock-property-name-face       ((t (:foreground ,fg))))
   `(font-lock-property-use-face        ((t (:foreground ,fg))))
   `(font-lock-function-name-face       ((t (:foreground ,fg))))
   `(font-lock-preprocessor-face        ((t (:foreground ,fg))))
   ;; @function.call is the one place the original adds weight to mid-gray.
   `(font-lock-function-call-face       ((t (:foreground ,fg :weight bold))))

   `(font-lock-comment-face             ((t (:foreground ,comment :slant italic))))
   `(font-lock-comment-delimiter-face   ((t (:foreground ,comment :slant italic))))
   `(font-lock-operator-face            ((t (:foreground ,comment))))
   `(font-lock-punctuation-face         ((t (:foreground ,comment))))
   `(font-lock-delimiter-face           ((t (:foreground ,comment))))
   `(font-lock-bracket-face             ((t (:foreground ,comment))))
   `(font-lock-misc-punctuation-face    ((t (:foreground ,comment))))
   `(font-lock-negation-char-face       ((t (:foreground ,comment))))

   `(font-lock-string-face              ((t (:foreground ,constant))))
   `(font-lock-constant-face            ((t (:foreground ,constant))))
   `(font-lock-number-face              ((t (:foreground ,constant))))
   `(font-lock-regexp-face              ((t (:foreground ,constant))))
   ;; Docstrings are @string.documentation upstream, so they follow String;
   ;; markup *inside* them follows Comment.
   `(font-lock-doc-face                 ((t (:foreground ,constant))))
   `(font-lock-doc-markup-face          ((t (:foreground ,comment :slant italic))))

   `(font-lock-type-face                ((t (:foreground ,accent))))
   `(font-lock-warning-face             ((t (:foreground ,diff-del :weight bold))))

;;; Diff / Magit  (the Neogit groups map onto Magit's equivalents)
   `(diff-added                       ((t (:foreground ,diff-add :background ,bg :extend t))))
   `(diff-removed                     ((t (:foreground ,diff-del :background ,bg :extend t))))
   `(diff-changed                     ((t (:foreground ,accent :background ,bg :extend t))))
   `(diff-context                     ((t (:foreground ,fg :background ,bg :extend t))))
   `(diff-header                      ((t (:foreground ,white :weight bold :extend t))))
   `(diff-file-header                 ((t (:foreground ,white :weight bold :extend t))))
   `(diff-hunk-header                 ((t (:foreground ,comment :extend t))))
   `(diff-indicator-added             ((t (:foreground ,diff-add))))
   `(diff-indicator-removed           ((t (:foreground ,diff-del))))

   `(magit-diff-added                 ((t (:foreground ,diff-add :background ,bg :extend t))))
   `(magit-diff-added-highlight       ((t (:foreground ,diff-add :background ,bg :extend t))))
   `(magit-diff-removed               ((t (:foreground ,diff-del :background ,bg :extend t))))
   `(magit-diff-removed-highlight     ((t (:foreground ,diff-del :background ,bg :extend t))))
   ;; NeogitDiffContextHighlight links straight to the context face -- no tint.
   `(magit-diff-context               ((t (:foreground ,fg :background ,bg :extend t))))
   `(magit-diff-context-highlight     ((t (:foreground ,fg :background ,bg :extend t))))
   `(magit-diff-hunk-heading          ((t (:foreground ,white :background ,blackish :extend t))))
   `(magit-diff-hunk-heading-highlight ((t (:foreground ,white :background ,selection :extend t))))
   `(magit-diff-file-heading          ((t (:foreground ,white :weight bold :extend t))))
   `(magit-diff-file-heading-highlight ((t (:foreground ,white :background ,blackish :weight bold :extend t))))
   `(magit-section-heading            ((t (:foreground ,white :weight bold))))
   `(magit-section-highlight          ((t (:background ,bg :extend t))))
   `(magit-branch-local               ((t (:foreground ,white))))
   `(magit-branch-remote              ((t (:foreground ,accent))))
   `(magit-hash                       ((t (:foreground ,comment))))
   `(magit-log-author                 ((t (:foreground ,accent))))
   `(magit-log-date                   ((t (:foreground ,comment))))

;;; vc-gutter (+pretty uses diff-hl)
   `(diff-hl-insert                   ((t (:foreground ,diff-add :background ,bg))))
   `(diff-hl-delete                   ((t (:foreground ,diff-del :background ,bg))))
   `(diff-hl-change                   ((t (:foreground ,accent :background ,bg))))
   `(git-gutter:added                 ((t (:foreground ,diff-add :background ,bg))))
   `(git-gutter:deleted               ((t (:foreground ,diff-del :background ,bg))))
   `(git-gutter:modified              ((t (:foreground ,accent :background ,bg))))

;;; Checkers -- the original turns undercurl off in favour of a plain underline
   `(flyspell-incorrect  ((t (:underline (:style line :color ,diff-del)))))
   `(flyspell-duplicate  ((t (:underline (:style line :color ,accent)))))
   `(flymake-error       ((t (:underline (:style line :color ,diff-del)))))
   `(flymake-warning     ((t (:underline (:style line :color ,accent)))))
   `(flymake-note        ((t (:underline (:style line :color ,constant)))))
   `(flycheck-error      ((t (:underline (:style line :color ,diff-del)))))
   `(flycheck-warning    ((t (:underline (:style line :color ,accent)))))
   `(flycheck-info       ((t (:underline (:style line :color ,constant)))))

;;; Completion  (Pmenu links to Normal upstream, so popups sit on pure black)
   `(company-tooltip                  ((t (:foreground ,fg :background ,bg))))
   `(company-tooltip-selection        ((t (:background ,selection))))
   `(company-tooltip-common           ((t (:foreground ,white :weight bold))))
   `(company-tooltip-annotation       ((t (:foreground ,comment))))
   `(company-scrollbar-bg             ((t (:background ,blackish))))
   `(company-scrollbar-fg             ((t (:background ,selection))))
   `(company-preview                  ((t (:foreground ,comment :background ,bg))))
   `(company-preview-common           ((t (:foreground ,white :background ,bg))))
   `(corfu-default                    ((t (:foreground ,fg :background ,bg))))
   `(corfu-current                    ((t (:background ,selection))))
   `(corfu-border                     ((t (:background ,blackish))))
   `(corfu-bar                        ((t (:background ,selection))))
   `(vertico-current                  ((t (:background ,selection :extend t))))
   `(vertico-group-title              ((t (:foreground ,comment :slant italic))))
   `(orderless-match-face-0           ((t (:foreground ,white :weight bold))))
   `(orderless-match-face-1           ((t (:foreground ,accent :weight bold))))
   `(orderless-match-face-2           ((t (:foreground ,constant :weight bold))))
   `(orderless-match-face-3           ((t (:foreground ,fg :weight bold))))

;;; Doom chrome -- no upstream equivalent, kept inside the same palette
   `(solaire-default-face             ((t (:background ,bg))))
   `(solaire-hl-line-face             ((t (:background ,bg))))
   `(solaire-mode-line-face           ((t (:background ,blackish))))
   `(solaire-mode-line-inactive-face  ((t (:background ,blackish))))
   `(solaire-fringe-face              ((t (:background ,bg))))
   `(solaire-org-hide-face            ((t (:foreground ,bg))))

   `(doom-modeline-bar                ((t (:background ,white))))
   `(doom-modeline-bar-inactive       ((t (:background ,blackish))))
   `(doom-modeline-buffer-file        ((t (:foreground ,white :weight bold))))
   `(doom-modeline-buffer-modified    ((t (:foreground ,diff-del :weight bold))))
   `(doom-modeline-buffer-path        ((t (:foreground ,fg))))
   `(doom-modeline-buffer-major-mode  ((t (:foreground ,white :weight bold))))
   `(doom-modeline-project-dir        ((t (:foreground ,accent :weight bold))))
   `(doom-modeline-info               ((t (:foreground ,diff-add))))
   `(doom-modeline-warning            ((t (:foreground ,accent))))
   `(doom-modeline-urgent             ((t (:foreground ,diff-del))))
   `(doom-modeline-debug              ((t (:foreground ,comment))))
   `(doom-modeline-evil-normal-state  ((t (:foreground ,white))))
   `(doom-modeline-evil-insert-state  ((t (:foreground ,diff-add))))
   `(doom-modeline-evil-visual-state  ((t (:foreground ,accent))))
   `(doom-modeline-evil-replace-state ((t (:foreground ,diff-del))))
   `(doom-modeline-evil-motion-state  ((t (:foreground ,constant))))
   `(doom-modeline-evil-operator-state ((t (:foreground ,white))))
   `(doom-modeline-evil-emacs-state   ((t (:foreground ,constant))))

   `(doom-dashboard-banner            ((t (:foreground ,comment))))
   `(doom-dashboard-footer            ((t (:foreground ,comment))))
   `(doom-dashboard-footer-icon       ((t (:foreground ,accent))))
   `(doom-dashboard-loaded            ((t (:foreground ,comment))))
   `(doom-dashboard-menu-title        ((t (:foreground ,white))))
   `(doom-dashboard-menu-desc         ((t (:foreground ,fg))))

   `(hl-todo                          ((t (:foreground ,diff-del :weight bold))))
   `(evil-goggles-default-face        ((t (:background ,blackish))))
   `(vi-tilde-fringe-face             ((t (:foreground ,comment))))

;;; Whitespace
   `(whitespace-tab       ((t (:foreground ,blackish :background ,bg))))
   `(whitespace-space     ((t (:foreground ,blackish :background ,bg))))
   `(whitespace-newline   ((t (:foreground ,blackish :background ,bg))))
   `(whitespace-indentation ((t (:foreground ,blackish :background ,bg))))
   `(whitespace-trailing  ((t (:foreground ,diff-del :background ,blackish))))
   `(whitespace-line      ((t (:background ,blackish))))

;;; Tabs / workspaces
   `(tab-bar              ((t (:foreground ,fg :background ,blackish))))
   `(tab-bar-tab          ((t (:foreground ,white :background ,bg :weight bold))))
   `(tab-bar-tab-inactive ((t (:foreground ,comment :background ,blackish))))
   `(tab-line             ((t (:foreground ,fg :background ,blackish))))

;;; Dired  (Directory)
   `(dired-directory      ((t (:foreground ,white :background ,bg :weight bold))))
   `(dired-header         ((t (:foreground ,white :weight bold))))
   `(dired-symlink        ((t (:foreground ,constant))))
   `(dired-marked         ((t (:foreground ,accent :weight bold))))
   `(dired-flagged        ((t (:foreground ,diff-del :weight bold))))
   `(dired-broken-symlink ((t (:foreground ,diff-del :weight bold))))

;;; Org
   `(org-hide                 ((t (:foreground ,bg))))
   `(org-document-title       ((t (:foreground ,white :weight bold))))
   `(org-level-1              ((t (:foreground ,white :weight bold))))
   `(org-level-2              ((t (:foreground ,accent :weight bold))))
   `(org-level-3              ((t (:foreground ,constant))))
   `(org-level-4              ((t (:foreground ,fg))))
   `(org-level-5              ((t (:foreground ,fg))))
   `(org-level-6              ((t (:foreground ,fg))))
   `(org-block                ((t (:background ,bg :extend t))))
   `(org-block-begin-line     ((t (:foreground ,comment :background ,bg :extend t))))
   `(org-block-end-line       ((t (:foreground ,comment :background ,bg :extend t))))
   `(org-code                 ((t (:foreground ,constant))))
   `(org-verbatim             ((t (:foreground ,constant))))
   `(org-table                ((t (:foreground ,fg))))
   `(org-link                 ((t (:foreground ,white :underline t))))
   `(org-date                 ((t (:foreground ,constant))))
   `(org-special-keyword      ((t (:foreground ,comment))))
   `(org-drawer               ((t (:foreground ,comment))))
   `(org-todo                 ((t (:foreground ,diff-del :weight bold))))
   `(org-done                 ((t (:foreground ,diff-add :weight bold))))
   `(org-headline-done        ((t (:foreground ,comment))))
   `(org-checkbox             ((t (:foreground ,white))))
   `(org-ellipsis             ((t (:foreground ,comment :underline nil))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'grayscale)

;;; grayscale-theme.el ends here
