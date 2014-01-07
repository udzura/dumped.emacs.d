;; load path
;;(add-to-list 'load-path "~/.emacs.d/")
;;(add-to-list 'load-path "~/.emacs.d/color-theme")
(add-to-list 'load-path "~/.emacs.d/misc")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


(dolist (hook (list
	      'c-mode-hook
	      'emacs-lisp-mode-hook
	      'lisp-interaction-mode-hook
	      'lisp-mode-hook
	      'java-mode-hook
	      'sh-mode-hook
	      'ruby-mode-hook
	      'js-mode-hook
	      'js2-mode-hook
	      'coffee-mode-hook
	      'd-mode-hook
	      'html-mode-hook
	      'haml-mode-hook
	      'css-mode-hook
	      ))
(add-hook hook (lambda () (linum-mode t))))

;; 言語設定とか
;;(set-language-environment "Japanese")
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(setq default-buffer-file-coding-system 'utf-8)

;; for Mac backslash issue
(define-key global-map [?¥] [?\\])

;; フォント設定
(set-face-attribute 'default nil
;;  :family "VL ゴシック"
  :height 127)

;; 起動時のフレームサイズ
(setq initial-frame-alist '((width . 165) (height . 46)))

;; Window移動
(windmove-default-keybindings)

;; テーマ読み込み
(require 'color-theme)
;; ここでテーマ設定、好きなものに変更
(color-theme-initialize)
(color-theme-hober)

;; ispell
(setq ispell-program-name "aspell")

;; prelude
(setq prelude-guru nil)
(setq prelude-whitespace nil)
(setq prelude-flyspell nil)

;; popwin!

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; anything

;; (require 'anything-config)
;; (require 'anything)
;; (setq anything-sources (list anything-c-source-buffers
;;                             anything-c-source-bookmarks
;;                             anything-c-source-recentf
;;                             anything-c-source-file-name-history
;;                             anything-c-source-complex-command-history
;;                             anything-c-source-emacs-commands
;;                             anything-c-source-locate))
;;(define-key anything-map (kbd "C-p") 'anything-previous-line)
;;(define-key anything-map (kbd "C-n") 'anything-next-line)
;;(define-key anything-map (kbd "C-v") 'anything-next-source)
;;(define-key anything-map (kbd "M-v") 'anything-previous-source)

;;; helm
(require 'helm-config)
(helm-descbinds-mode)

(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "C-M-;") 'helm-mini)
;;(global-set-key (kbd "C-c C-;") 'anything)

;;(require 'anything-rcodetools)
;; Command to get all RI entries.
;;(setq rct-get-all-methods-command "PAGER=cat fri -l")
;; See docs
;;(define-key anything-map "\C-e" 'anything-execute-persistent-action)

(cua-mode t)
(setq cua-enable-cua-keys nil)

(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; grep-edit
(require 'grep-edit)

(autoload 'js2-mode "js2-mode" "Enhanced Javascript mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; dired
;; (define-key dired-mode-map (kbd "C-c C-g") 'find-grep-dired)

(require 'rsense)
;; C-c .で補完
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c .") 'ac-complete-rsense)))
;; 自動補完～～
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (add-to-list 'ac-sources 'ac-source-rsense-method)
	    (add-to-list 'ac-sources 'ac-source-rsense-constant)))
(setq ruby-deep-indent-paren-style nil)

;; http://willnet.in/13
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
	indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
	(setq offset (- column (current-column)))
	(when (and (eq (char-after) ?\))
		   (not (zerop (car state))))
	  (goto-char (cadr state))
	  (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(require 'flymake)
(require 'flymake-ruby)
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
		       temp-file
		       (file-name-directory buffer-file-name))))
    (list "/Users/ukondo/.rvm/bin/ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("(Rake|Cap|Gem)file$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))

    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
	 (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	 (count               (length line-err-info-list))
	 )
    (while (> count 0)
      (when line-err-info-list
	(let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
	       (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
	       (text (flymake-ler-text (nth (1- count) line-err-info-list)))
	       (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
	  (message "[%s] %s" line text)
	  )
	)
      (setq count (1- count)))))

;;(require 'rcodetools)
;;(require 'anything-rcodetools)
;;(define-key ruby-mode-map "\C-cl" 'rct-complete-symbol)
;;(define-key ruby-mode-map "\C-cx" 'xmpfilter)

(define-key ruby-mode-map (kbd "C-;") 'helm-mini)

(defun ruby-mode-hook-prevent-auto-encode-insertion ()
  "encodingを自動挿入しないようにする"
  (remove-hook 'before-save-hook 'ruby-mode-set-encoding))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-prevent-auto-encode-insertion)

(defun my-ruby-mode-set-encoding ()
  "set-encoding ruby-mode"
  (interactive)
  (ruby-mode-set-encoding))
(define-key ruby-mode-map "\C-ce" 'my-ruby-mode-set-encoding)


(require 'auto-complete-config)
(ac-config-default)


(setq ac-modes (append ac-modes '(js2-mode)))
(setq ac-modes (append ac-modes '(coffee-mode)))

(global-set-key (kbd "C-c C-a") 'auto-complete-mode)

(setq x-select-enable-clipboard t)

(setq auto-mode-alist
   (cons '("\\.mkdn" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-tab-change ()
  "coffee-mode-hook"
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'coffee-tab-change)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

;; http://d.hatena.ne.jp/sugyan/20100705/1278306885
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

;; http://www.erlang.org/doc/apps/tools/erlang_mode_chapter.html
;; (add-to-list 'load-path "/usr/local/Cellar/erlang/R15B/lib/erlang/lib/tools-2.6.6.6/emacs")
;; (setq erlang-root-dir "/usr/local/Cellar/erlang/R15B/lib/erlang")
;; (setq exec-path (cons "/usr/local/Cellar/erlang/R15B/lib/erlang/bin" exec-path))
;; (require 'erlang-start)

;; https://github.com/secondplanet/elixir-mode
;; (add-to-list 'load-path "~/.emacs.d/elixir-mode")
;; (require 'elixir-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;; 何か最後がいいらしい
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; http://subtech.g.hatena.ne.jp/antipop/20071016/1192546147
(setq truncate-partial-width-windows nil)

(dolist (hook (list
	      'c-mode-hook
	      'emacs-lisp-mode-hook
	      'lisp-interaction-mode-hook
	      'lisp-mode-hook
	      'java-mode-hook
	      'sh-mode-hook
	      ))
(add-hook hook (lambda () (linum-mode t))))

(powerline-default)

(setq indent-tabs-mode nil)
(setq ruby-indent-tabs-mode nil)

(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
