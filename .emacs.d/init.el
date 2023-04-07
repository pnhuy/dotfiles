(require 'package)
(require 'use-package)
(require 'ls-lisp)
(require 'yasnippet)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


; (setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq-default c-basic-offset 4)
;; (desktop-save-mode 1)

(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first"))
(setq ls-lisp-dirs-first t)


(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :hook
  ((python-mode . lsp))
  )

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config (setq lsp-ui-sideline-show-diagnostic t
                lsp-ui-flycheck t
                lsp-ui-sideline-delay 0.1
                lsp-ui-doc-delay 5
                lsp-ui-doc-position 'bottom
                lsp-ui-doc-alignment 'frame
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :commands lsp-ui-mode)


(setq lsp-pyls-plugins-pycodestyle-enabled nil)
(setq lsp-diagnostics-provider :flycheck)
(setq lsp-diagnostics-flycheck-default-level 'warning)
(setq lsp-pylsp-plugins-flake8-ignore 'D)
(setq lsp-pylsp-plugins-pycodestyle-ignore 'D)
(setq lsp-pylsp-plugins-flake8-max-line-length 120)
(set lsp-pylsp-plugins-pycodestyle-max-line-length 120)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm yasnippet dap-mode company-box company lsp-ui use-package lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dap-ui-pending-breakpoint-face ((t ("blue"))))
 '(dap-ui-verified-breakpoint-face ((t ("green")))))


(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.1))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package dap-mode
  :after lsp-mode
  :commands dap-debug
  :hook ((python-mode . dap-ui-mode) (python-mode . dap-mode))
  :config
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)
  (setq dap-python-executable "python3")
  ; (add-hook 'dap-stopped-hook
  ;           (lambda (arg) (call-interactively #'dap-hydra)))
  )


;; (setq left-fringe-width 16)


(global-linum-mode)

(setq treemacs-no-load-time-warnings t)

;; Format linum
(setq linum-format "%4d ")

(add-to-list 'helm-grep-ignored-directories "venv")
