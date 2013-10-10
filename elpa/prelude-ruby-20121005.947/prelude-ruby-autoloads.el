;;; prelude-ruby-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "prelude-ruby" "prelude-ruby.el" (20725 6210))
;;; Generated autoloads from prelude-ruby.el

(require 'ruby-block)

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

(add-to-list 'completion-ignored-extensions ".rbc")

(define-key 'help-command (kbd "R") 'yari)

(eval-after-load 'ruby-mode '(progn (defun prelude-ruby-mode-defaults nil (inf-ruby-setup-keybindings) (setq comint-process-echoes t) (ruby-block-mode t) (ruby-end-mode 1) (ruby-tools-mode 1) (subword-mode 1)) (setq prelude-ruby-mode-hook 'prelude-ruby-mode-defaults) (add-hook 'ruby-mode-hook (lambda nil (run-hooks 'prelude-ruby-mode-hook)))))

;;;***

;;;### (autoloads nil nil ("prelude-ruby-pkg.el") (20725 6210 267709))

;;;***

(provide 'prelude-ruby-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; prelude-ruby-autoloads.el ends here
