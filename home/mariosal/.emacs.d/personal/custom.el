(prelude-require-packages '(google-c-style emojify robe rbenv color-theme-sanityinc-tomorrow))
(add-hook 'after-init-hook #'global-prettify-symbols-mode)
(add-hook 'after-init-hook #'global-emojify-mode)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'prelude-prog-mode-hook (lambda () (smartparens-mode -1)) t)

(eval-after-load 'company
  '(push 'company-robe company-backends))

(eval-after-load 'flycheck
  '(flycheck-add-next-checker 'c/c++-clang
     '(warning . c/c++-googlelint)))

(global-rbenv-mode)

(setq
  ruby-insert-encoding-magic-comment nil
  default-directory "/home/mariosal/yogurt/"
  browse-url-browser-function 'browse-url-chromium
  helm-mode-fuzzy-match                 t
  helm-completion-in-region-fuzzy-match t
  helm-recentf-fuzzy-match              t
  helm-buffers-fuzzy-matching           t
  helm-locate-fuzzy-match               t
  helm-M-x-fuzzy-match                  t
  helm-semantic-fuzzy-match             t
  helm-imenu-fuzzy-match                t
  helm-apropos-fuzzy-match              t
  helm-lisp-fuzzy-completion            t
  helm-session-fuzzy-match              t
  web-mode-enable-auto-quoting          nil
  helm-etags-fuzzy-match                t)

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-to-list 'auto-mode-alist '("\\.s?css\\(\\.erb\\)?\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.pac\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'"  . web-mode))
(add-to-list 'interpreter-mode-alist '("node" . web-mode))

(setq web-mode-content-types-alist
  '(("css" . "\\.scss\\.erb\\'")))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                 (or (buffer-file-name) default-directory)
                 "node_modules"))
          (eslint (and root
                    (expand-file-name "node_modules/eslint/bin/eslint.js"
                      root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))
