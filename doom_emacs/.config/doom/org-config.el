;; org-config.el
;; Org-Mode configuration for Doom Emacs

;;;; Require
(require 'org-checklist)
(require 'org)
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
;;;; My Variables
(setq my-org-exclude-project-todo "-{^_.*}")
(setq my-org-agenda-gtd-filepath "~/11_Syncthing/40_Notes/42_Org/gtd.org")
(setq my-org-file-path "~/11_Syncthing/40_Notes/42_Org/")
(setq my-org-agenda-path "~/11_Syncthing/40_Notes/42_Org/")
(setq my-org-agenda-files (list my-org-agenda-gtd-filepath (concat my-org-agenda-path "remote.org")))

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
        ("n" "Note" entry (file+headline  org-personal-path "Org-Capture Notes")
         "* %? \n:PROPERTIES:\n:CREATED: %U\n:END:")
        ("p" "Plain Note" entry (file+headline  "~/110_Syncthing/210_Notes/050_orgTasks/personal.org" "Org-Capture Notes")
         "* %? ")
        ("N" "Note with Link" entry (file+headline  "~/110_Syncthing/210_Notes/050_orgTasks/personal.org" "Org-Capture Notes")
         "* %? \n:PROPERTIES:\n:CREATED: %U\n:LINK: %a\n:END:")
        ("l" "Link" entry (file+headline  "~/110_Syncthing/210_Notes/050_orgTasks/notes.org" "Unsorted Links")
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
            tags-todo (concat my-org-exclude-project-todo "/SCHD")
            ((org-agenda-files my-org-agenda-files)))
           ("gu" "Useful"
            tags-todo (concat my-org-exclude-project-todo "-@today/-DONE-PROJ-SCHD-SMDY")
            ((org-agenda-files my-org-agenda-files)))
           ("gx" "Today"
            tags-todo "@today"
            ((org-agenda-files my-org-agenda-files)))
           ("gd" "Done/Canceled"
            tags "/DONE|CANC"
            ((org-agenda-files my-org-agenda-files)))
           ("ga" "All"
            tags-todo "/-DONE"
            ((org-agenda-files my-org-agenda-files)
             (org-agenda-sorting-strategy '(todo-state-up))))
           ("p" . "Projects")
           ("pa" "Active"
            tags-todo "STATE=\"ACTIVE\""
            ((org-agenda-files my-org-agenda-files)))
           ("pb" "Active Book"
            tags-todo "STATE=\"ACTIVE\"+TYPE=\"BOOK\""
            ((org-agenda-files my-org-agenda-files)))
           ("pl" "Longterm Active"
            tags-todo "DURATION=\"LONG\"+STATE=\"ACTIVE\""
            ((org-agenda-files my-org-agenda-files)))
           ("pn" "Next Action"
            tags-todo "__p/NEXT"
            ((org-agenda-files my-org-agenda-files)))
           ("ps" "Short & Active"
            tags-todo "TODO=\"PROJ\"+DURATION=\"SHORT\"+STATE=\"ACTIVE\""
            ((org-agenda-files my-org-agenda-files)))
           ("px" "All"
            tags-todo "TODO=\"PROJ\""
            ((org-agenda-files my-org-agenda-files)))
           ("c" . "Closed")
           ("c" "Closed tasks today"
            ((tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "Tasks closed today")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'done))
                 (org-agenda-sorting-strategy '(todo-state-down priority-down))))))
           ))

;;;; Unsorted

;; Keybinding to toggle DONE quickly in agenda view
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
)
