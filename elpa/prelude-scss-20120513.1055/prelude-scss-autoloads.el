;;; prelude-scss-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "prelude-scss" "prelude-scss.el" (20725 6245))
;;; Generated autoloads from prelude-scss.el

(require 'prelude-css)

(defun prelude-scss-mode-defaults nil (prelude-css-mode-defaults) (setq scss-compile-at-save nil))

(setq prelude-scss-mode-hook 'prelude-scss-mode-defaults)

(add-hook 'scss-mode-hook (lambda nil (run-hooks 'prelude-scss-mode-hook)))

;;;***

;;;### (autoloads nil nil ("prelude-scss-pkg.el") (20725 6245 913473))

;;;***

(provide 'prelude-scss-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; prelude-scss-autoloads.el ends here
