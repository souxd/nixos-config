;; fix magit SPC-g-g
(defun doom-modeline-set-vcs-modeline () 1)

;; org-roam config
(setq org-roam-directory (file-truename "~/org/roam"))
(org-roam-db-autosync-mode)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
