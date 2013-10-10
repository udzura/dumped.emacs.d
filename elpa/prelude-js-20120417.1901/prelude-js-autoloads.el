;;; prelude-js-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "prelude-js" "prelude-js.el" (20725 6196))
;;; Generated autoloads from prelude-js.el

(eval-after-load 'js-mode '(progn (defun prelude-js-mode-defaults nil (electric-layout-mode -1)) (setq prelude-js-mode-hook 'prelude-js-mode-defaults) (add-hook 'js-mode-hook (lambda nil (run-hooks 'prelude-js-mode-hook)))))

;;;***

;;;### (autoloads nil nil ("prelude-js-pkg.el") (20725 6196 966696))

;;;***

(provide 'prelude-js-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; prelude-js-autoloads.el ends here
