;; org-config.el
;; Org-Mode configuration for Doom Emacs

;;;; Require
(require 'org-checklist)
(require 'org)
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
;;;; My Variables
(setq my-org-exclude-project-todo "+LEVEL=1")
(setq my-org-agenda-gtd-filepath "~/11_Syncthing/40_Notes/42_Org/gtd.org")
(setq my-org-agenda-project-filepath "~/11_Syncthing/40_Notes/42_Org/projects.org")
(setq my-org-file-path "~/11_Syncthing/40_Notes/42_Org/")
(setq my-org-agenda-path "~/11_Syncthing/40_Notes/42_Org/")
(setq my-org-agenda-files (list my-org-agenda-gtd-filepath (concat my-org-agenda-path "remote.org")))

(setq org-roam-directory (file-truename "~/main/notes/org/roam"))

(after! org

;;;; Hooks
(add-hook 'org-mode-hook 'org-fragtog-mode)

;;;; Variables
  (setq org-reverse-note-order t)
  (setq org-directory "~/org/")
  (setq org-todo-keywords
   '((sequence "TODO" "NEXT" "SMDY" "IDEA" "SCHD" "WAIT" "PROJ" "|" "DONE" "CANC")))

  ;; Indentation
  (setq org-indent-indentation-per-level 4)
  (setq org-src-tab-acts-natively t)
  (setq org-edit-src-content-indentation 4)
  ;; Adjust shift width (>> and <<) to move by 4 spaces
  (setq org-shift-width 4)

;;;; Capture
  (setq org-capture-templates
      '(("t" "Todo" entry (file my-org-agenda-gtd-filepath)
         "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("p" "Project" entry (file my-org-agenda-project-filepath)
         "* PROJ %?\n:PROPERTIES:\n:CREATED: %U\n:STATE: ACTIVE\n:NEXT: %t\n:END:\n** Data\n** Tasks\n** Log\n** Ideas\n*** Init\n**** Why?\n** Plan\n** Result")
        ("n" "Note" entry (file+headline  org-personal-path "Org-Capture Notes")
         "* %? \n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("r" "Plain Note" entry (file+headline  "~/110_Syncthing/210_Notes/050_orgTasks/personal.org" "Org-Capture Notes")
         "* %? ")
        ("N" "Note with Link" entry (file+headline  "~/110_Syncthing/210_Notes/050_orgTasks/personal.org" "Org-Capture Notes")
         "* %? \n:PROPERTIES:\n:CREATED: %U\n:LINK: %a\n:END:")
        ("l" "Link" entry (file"~/11_Syncthing/40_Notes/42_Org/weblinks.org")
         "* %?")
        ("j" "Journal" entry (file+datetree "~/11_Syncthing/40_Notes/42_Org/journal.org")
        "* %<%Y-%m-%d %a %H:%M>\n%?\n\n")))

;;;; Agenda
  (setq org-agenda-custom-commands
        '(("g" . "GTD views")
           ("gt" "Todo"
            tags-todo (concat my-org-exclude-project-todo "/TODO")
            ((org-agenda-files my-org-agenda-files)))
           ("gn" "Next"
            tags-todo (concat my-org-exclude-project-todo "/NEXT")
            ((org-agenda-files my-org-agenda-files)))
           ("gm" "Someday/Maybe"
            tags-todo (concat my-org-exclude-project-todo "/SMDY")
            ((org-agenda-files my-org-agenda-files)))
           ("gs" "Scheduled"
            tags-todo (concat "/SCHD")
            ((org-agenda-files my-org-agenda-files)))
           ("gi" "Idea"
            tags-todo (concat my-org-exclude-project-todo "/IDEA")
            ((org-agenda-files my-org-agenda-files)))
           ("gu" "Useful"
            tags-todo (concat my-org-exclude-project-todo "/-DONE-IDEA-PROJ-SCHD-SMDY")
            ((org-agenda-files my-org-agenda-files)))
           ("gd" "Done/Canceled"
            tags "/DONE|CANC"
            ((org-agenda-files my-org-agenda-files)))
           ("ga" "All"
            tags-todo "/-DONE"
            ((org-agenda-files my-org-agenda-files)
             (org-agenda-sorting-strategy '(todo-state-up))))
           ("gx" "All Grouped"
            alltodo ""
            ((org-agenda-files my-org-agenda-files)
             (org-super-agenda-groups '((:name "Sort!"
                                               :todo ("TODO"))
                                        (:name "Recurring events"
                                               :tag ("#cycle")
                                               :order 99)
                                        (:name "Next"
                                               :todo ("NEXT"))
                                        (:name "Waiting..."
                                               :todo ("WAIT"))
                                        (:name "Ideas"
                                               :todo ("IDEA"))
                                        (:name "Scheduled"
                                               :todo ("SCHD")
                                               :log t)
                                        (:name "Nothing Special"
                                               :todo ("SMDY"))
                                        (:name "Done"
                                               :todo ("DONE"))
                                        (:name "Canceled"
                                               :todo ("CANC"))
                                        (:name "Convert to Projects"
                                               :todo ("PROJ"))
                                        ))))
           ("p" . "Projects")
           ("pa" "Active"
            tags-todo "STATE=\"ACTIVE\""
            ((org-agenda-files (list my-org-agenda-project-filepath))))
           ("pb" "Active Book"
            tags-todo "STATE=\"ACTIVE\"+TYPE=\"BOOK\""
            ((org-agenda-files (list my-org-agenda-project-filepath))))
           ("pl" "Longterm Active"
            tags-todo "DURATION=\"LONG\"+STATE=\"ACTIVE\""
            ((org-agenda-files (list my-org-agenda-project-filepath))))
           ("pn" "Next Action"
            tags-todo "__p/NEXT"
            ((org-agenda-files (list my-org-agenda-project-filepath))))
           ("ps" "Short & Active"
            tags-todo "TODO=\"PROJ\"+DURATION=\"SHORT\"+STATE=\"ACTIVE\""
            ((org-agenda-files (list my-org-agenda-project-filepath))))
           ("px" "All"
            tags-todo "TODO=\"PROJ\""
            ((org-agenda-files (list my-org-agenda-project-filepath))))
           ("pg" "All Grouped"
            tags-todo "TODO=\"PROJ\"+STATE=\"ACTIVE\""
            ((org-agenda-files (list my-org-agenda-project-filepath))
             ;; (org-super-agenda-groups '((:auto-property "TYPE")))))
             (org-agenda-sorting-strategy '(priority-down))
             (org-super-agenda-groups '((:name "Short"
                                         ;; :auto-property "DURATION"
                                         :property ("DURATION" "SHORT")
                                         :order 1)
                                        (:name "Long"
                                         :property ("DURATION" "LONG")
                                         :order 2)
                                        (:name "Very Long"
                                         :property ("DURATION" "LIFETIME")
                                         :order 3)
                                        (:name "Other"
                                         :order 9)))))
           ("c" . "Closed")
           ("c" "Closed tasks today"
            ((tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "Tasks closed today")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'done))
                 (org-agenda-sorting-strategy '(todo-state-down priority-down))))))
           ("d" "Today"
            tags-todo "@today+LEVEL=1/-DONE-CANCELED"
            ((org-agenda-files (append my-org-agenda-files (list my-org-agenda-project-filepath)))))
           ))

(defun my-org-agenda-mark-done ()
  "Mark the current task as DONE."
  (interactive)
  (org-agenda-todo "DONE"))

  (map! :map org-agenda-mode-map
        :leader
        :desc "Mark task as DONE" "d" #'my-org-agenda-mark-done)

(setq org-indent-indentation-per-level 1)
(setq org-src-fontify-natively t)
(setq org-src-preserve-indentation t)

(setq org-clock-sound "~/010_Downloads/400_mp3/alarm_sound.mp3")

;; Plantum setup for src blocks:
(setq org-plantuml-jar-path "~/22_Software/001_Plantuml/plantuml-1.2024.7.jar")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (shell . t)
   (plantuml . t)))

(setq org-goto-interface (quote outline-path-completion))

(setq org-elp-split-fraction 0.2)
(setq org-elp-buffer-name "*Equation Live*")
(setq org-elp-idle-time 0.5)

(setq org-super-agenda-groups
      '(
        (:name "Projects"
               :todo ("PROJ"))
        (:name "Scheduled"
         :scheduled t)
        (:name "Tasks"
               :todo ("NEXT"))))


(setq org-deadline-warning-days 0)
(setq org-super-agenda-header-map (make-sparse-keymap))

;; (defun my-org-agenda-start-at-top ()
;;   "Start Org Agenda at the top of the buffer."
;;    (goto-char (point-min)))

;; (add-hook 'org-agenda-finalize-hook 'my-org-agenda-start-at-top)
;; (add-hook 'org-agenda-finalize-hook (goto-char (point-min)))


(add-hook 'org-mode-hook '+org-pretty-mode)
(add-hook 'org-mode-hook 'olivetti-mode)

;;;; Something

(defun my/org-agenda-set-focus-for-task ()
  "Add :focus: tag and a PROPERTY with current timestamp to the item selected"
  (interactive)
  (when (eq major-mode 'org-agenda-mode)
     ;; (org-agenda-set-tags "focus" "ON")
     (my/org-agenda-set-property "NEXT" (org-read-date))))

(defun my/org-agenda-set-property (prop val)
  "Set a property for the current headline."
  (org-agenda-check-no-diary)
  (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
           (org-agenda-error)))
     (buffer (marker-buffer hdmarker))
     (pos (marker-position hdmarker))
     (inhibit-read-only t)
     newhead)
    (org-with-remote-undo buffer
       (with-current-buffer buffer
          (widen)
          (goto-char pos)
          (org-fold-show-context 'agenda)
          (org-set-property prop val)))))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(org-roam-db-autosync-mode)
(setq org-roam-database-connector 'sqlite)

(setq org-roam-capture-templates
      '(("m" "main" plain
         "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new
         (file+head "reference/${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "article" plain "%?"
         :if-new
         (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t)
        ("b" "book" plain "%?"
         :if-new
         (file+head "books/${title}.org" "#+title: ${title}\n#+filetags: \n")
         :immediate-finish t
         :unnarrowed t)
        ("p" "project" plain "%?"
         :if-new
         (file+head "projects/%<%Y-%m-%d>_${title}.org" "#+title: ${title}\n#+filetags: :incomplete:\n")
         ;; (file+head "projects/%Y-%m-%d_${title}.org" "#+title: ${title}\n#+filetags: ::\n")
         :immediate-finish t
         :unnarrowed t)
        ("x" "problem" plain "%?"
         :if-new
         (file+head
          (format "problems/%s_%s.org"
                (format-time-string "%Y-%m-%d")
                (replace-regexp-in-string " " "-" (downcase "${title}")))
        "#+title: ${title}\n#+filetags: :incomplete:\n")
         ;; (file+head "problems/%<%Y-%m-%d>_${title}.org" "#+title: ${title}\n#+filetags: :incomplete:\n")
         :immediate-finish t
         :unnarrowed t)
        ("s" "research" plain "%?"
         :if-new
         (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :research:\n")
         :immediate-finish t
         :unnarrowed t)))
(custom-set-faces
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-document-title ((t (:height 1.4 :underline nil)))))

(defun my/gtd-view ()
  "Description"
  (interactive)
  (org-toggle-sticky-agenda)
  (split-window-right)
  (org-agenda nil "pg")
  (split-window-below)
  (evil-window-down 1)
  (org-agenda nil "a")
  (evil-window-right 1)
  (org-agenda nil "gx")
  (text-scale-adjust -0.8)
  (enlarge-window-horizontally 15)
  (org-agenda-redo)
  (evil-window-left 1)
  (org-agenda-redo)
  (evil-window-right 1)
  (org-agenda-next-item 1)
  (split-window-below)
  (evil-window-down 1)
  (find-file (concat my-org-file-path "gtd-tags"))
  (evil-scroll-line-down 1)
  (olivetti-mode -1)
  (enlarge-window -7)
  (evil-window-up 1))
(setq org-agenda-dim-blocked-tasks nil)
(setq org-agenda-show-all-dates nil)

(setq org-hide-emphasis-markers t)

(require 'org-download)
(setq-default org-download-heading-lvl nil)
(setq-default org-download-image-dir "./attachments"))
