;; org-roam basic config
(setq org-roam-directory (file-truename "~/org/roam"))
(org-roam-db-autosync-mode)

;; org-roam-ui config
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

;; org-roam capture templates
(after! org-roam
    (setq org-roam-capture-templates
          '(("d" "default" plain "%?"
             :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                "#+title: ${title}\n")
             :unnarrowed t)

            ("b" "book notes" plain
             "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
             :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                "#+title: ${title}\n")
             :unnarrowed t)

            ("p" "project" plain
             "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
             :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                "#+title: ${title}\n#+filetags: Project")
             :unnarrowed t)
           )
    )
)
