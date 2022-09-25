;;; customization by build in customize UI
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-tab-always-indent nil)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (misterioso)))
 '(desktop-path (quote ("./" "~/.emacs.d/" "~")))
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(org-agenda-prefix-format
   '((agenda . " %i %-12:c%?-12t% s%l")
     (todo . " %i %-12:c%l")
     (tags . " %i %-12:c%l")
     (search . " %i %-12:c")))
 '(org-agenda-sorting-strategy
   '((agenda habit-up time-up deadline-up priority-down category-keep)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep)))
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus org-habit ol-info ol-irc ol-mhe ol-rmail ol-w3m))
 '(safe-local-variable-values
   '((eval outline-hide-sublevels 3)
     (eval outline-minor-mode 't)
     (org-use-sub-superscripts . {})
     (org-export-with-sub-superscripts . {})))
 '(tab-always-indent nil)
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 142))))
 '(cursor ((t (:background "azure4"))))
 '(org-ellipsis ((t (:foreground "light slate gray" :underline nil))))
 '(tab-bar ((t (:inherit variable-pitch :background "gray10"))))
 '(tab-bar-tab ((t (:inherit tab-bar :background "default"))))
 '(tab-bar-tab-inactive ((t (:inherit tab-bar))))
 '(tab-line ((t (:inherit (variable-pitch tab-bar) :height 0.9))))
 '(tab-line-tab ((t (:inherit tab-line))))
 '(tab-line-tab-current ((t (:inherit tab-line-tab :background "default"))))
 '(tab-line-tab-inactive ((t (:inherit tab-line-tab))))
 '(tool-bar ((t (:inherit tab-bar)))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;;; local machine related settings  跟本地機器相關的設定
(defconst my-local-machine-init-file                    (concat user-emacs-directory "/localInit.el")
  "local machine specific emacs init file")
(defconst my-local-machine-org-directory                "~/Documents"
  "org-directory variable in local machine")
(defconst my-local-machine-org-screenshot-command-line  "powershell C:/Users/s0993/Documents/Program/Powershell/screenshot.ps1 %f"
  "org-screenshot-command-line variable of org-attach-screenshot package")
(defconst my-local-machine-org-agenda-git-repo          "~/Documents/Data/OrgAgenda"
  "git repository of org agenda files")
(defconst my-local-machine-github-io-git-repo           "~/Documents/Github/flotisable.github.io"
  "git repository of github io pahe")

(setenv "LC_ALL" "en_US.UTF-8")
; end local machine related settings

;;; self defined functions  自定義函式
;;;; function to toggle relative line number  切換相對行號
(defun my-toggle-relative ()
  "Toggle relative line number"
  (interactive)
  (if (equal (symbol-value 'display-line-numbers) t)
    (setq display-line-numbers 'relative)
    (setq display-line-numbers t        )))
; end function to toggle relative line number

;;;; function to edit emacs init file  編輯 emacs 設定檔
(defun my-edit-init-file ()
  "Edit emacs init file"
  (interactive)
  (find-file user-init-file))
; end function to edit emacs init file

;;;; function to edit local machine emacs init file  編輯本地機器 emacs 設定檔
(defun my-edit-local-machine-init-file ()
  "Edit local machine emacs init file"
  (interactive)
  (find-file my-local-machine-init-file))
; end function to edit emacs init file

;;;; function to edit org agenda file  編輯 org agenda 設定檔
(defun my-edit-org-agenda-file ()
  "Edit org agenda file"
  (interactive)
  (find-file org-agenda-files))
; end function to edit org agenda file

;;;; function to alert on Windows < 8  在 Windows 8 以下的 alert
(defun my-alert-w32-notify (info)
  "Alert on Windows < 8"
  (let ((id (w32-notification-notify :level  'info
                                     :title  (plist-get info :title)
                                     :body   (plist-get info :message))))
    (setq my-notify-id id)))
; end function alert on Windows < 8

;;;; function to close alert on Windows < 8  在 Windows 8 以下的 alert close
(defun my-alert-w32-close (info)
  "Close alert on Windows < 8"
  (when my-notify-id
    (w32-notification-close my-notify-id)))
; end function close alert on Windows < 8
; end self defined functions

;;; third-party archives  第三方套件庫
(require 'package)                                          ; 需要 package 這個套件
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)  ; 加入 melpa 套件庫
(package-initialize)                                        ; 讀入套件資料
; end third-party archives

;;; automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件
(defvar my-package-list '(evil
                          evil-collection
                          ivy
                          swiper
                          org
                          org-attach-screenshot
                          org-alert
                          htmlize
                          ebdb
                          perfect-margin
                          highlight-parentheses)
  "packages to be automatically downloaded when not exists")

(when (and (string= system-type "windows-nt") (>= (car (w32-version)) 8))
  (add-to-list 'my-package-list 'alert-toast))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package my-package-list)
  (unless (package-installed-p package)
    (package-install package)))
; end automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件

;;; general settings 通用設定
(set-message-beep 'silent)

(when (string= system-type "windows-nt")
  (set-face-attribute 'default nil :family "Consolas"))
; end general settings

;;; mode settings  模式設定
(column-number-mode 1   ) ; 在 mode line 顯示列號
(menu-bar-mode      -1  ) ; 關閉 menu bar
(tool-bar-mode      -1  ) ; 關閉 tool bar
(scroll-bar-mode    -1  ) ; 關閉 scroll bar
(display-time-mode  1   ) ; 在 mode line 顯示時間
(show-paren-mode    1   ) ; highlight 對應的小括號

(when (package-installed-p 'ivy)
  (ivy-mode 1)) ; 互動式模糊補全

(if (fboundp 'display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode  )
  (add-hook 'prog-mode-hook 'linum-mode                 )) ; 在 prog mode 下顯示行號

(when (package-installed-p 'highlight-parentheses)
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode))

(add-hook 'package-menu-mode-hook
          'hl-line-mode)
; end mode settings

;;; key bindings  按鍵設定
(global-set-key (kbd "C-c a") 'org-agenda ) ; 設定 C-c a 開啟 org agenda dispatcher
(global-set-key (kbd "C-c c") 'org-capture) ; 設定 C-c c 開啟 org capture
(global-set-key (kbd "C-s"  ) 'swiper     ) ; 設定 C-s 開啟互動式模糊搜尋
; end key bindings

;;; evil mode settings  evil mode 設定
(when (package-installed-p 'evil)
  (setq evil-want-keybinding 'nil)
  (require 'evil) ; 需要 evil 這個套件
  (evil-mode 1)   ; 開啟 evil mode
  (when (package-installed-p 'evil-collection)
    (evil-collection-init '(eww
                            gnus
                            info
                            (custom cus-edit)
                            (term term ansi-term multi-term))))

  (setq-default evil-shift-width 2) ; 設定縮排為 2 個字元

  ;;;; evil mode keybindings  evil mode 按鍵設定
  (evil-set-leader      'normal (kbd "\\"))
  (evil-global-set-key  'normal (kbd "DEL")        'evil-scroll-page-up             ) ; 設定退格鍵向上一頁
  (evil-global-set-key  'motion (kbd "SPC")        'evil-scroll-page-down           ) ; 設定空白鍵向下一頁
  (evil-global-set-key  'motion (kbd "DEL")        'evil-scroll-page-up             ) ; 設定退格鍵向上一頁
  (evil-global-set-key  'normal (kbd "<leader>c")  'hl-line-mode                    ) ; 設定 \c 高亮現在行數
  (evil-global-set-key  'normal (kbd "<leader>w")  'toggle-truncate-lines           ) ; 設定 \w 切換 wrap line
  (evil-global-set-key  'normal (kbd "<leader>er") 'my-edit-init-file               ) ; 設定 \er 編輯設定檔
  (evil-global-set-key  'normal (kbd "<leader>el") 'my-edit-local-machine-init-file ) ; 設定 \er 編輯設定檔
  (evil-global-set-key  'normal (kbd "<leader>ea") 'my-edit-org-agenda-file         ) ; 設定 \ea 編輯 org agenda 設定檔

  (if (fboundp 'display-line-numbers-mode)
    (evil-global-set-key 'normal (kbd "<leader>r") 'my-toggle-relative)) ; 設定 \r 切換行號顯示
  (when (package-installed-p 'perfect-margin)
    (evil-global-set-key 'normal (kbd "<leader>C") 'perfect-margin-mode))
  ; end evil mode keybindings

  ;;;; remove vim key binding in insert mode  清掉插入模式的 vim 按鍵
  (let ((key-to-be-removed '((insert ("C-w"
                                      "C-a"
                                      "C-d"
                                      "C-t"
                                      "C-x"
                                      "C-p"
                                      "C-n"
                                      "C-e"
                                      "C-y"
                                      "C-r"
                                      "C-o"
                                      "C-k"
                                      "C-v"))
                             (motion ("RET"
                                      "TAB")))))
    (dolist (key-map key-to-be-removed)
      (let ((mode (car  key-map))
            (keys (cadr key-map)))
        (dolist (key keys)
          (evil-global-set-key mode (kbd key) nil))))))
; end remove vim key binding in insert mode
; end evil mode settings

;;; org mode settings  org mode 設定
(defun my-skip-entry-if-not-priority (priority)
  "Skip entry in org agenda when no in specified priority"
  (when (not (= (org-get-priority (org-get-heading)) (org-get-priority (concat "[#" (string priority) "]"))))
    (org-entry-end-position)))
(defun my-remove-today-tag-when-done ()
  "Remove the :Today: tag when a task is marked as done"
  (when (org-entry-is-done-p)
    (org-set-tags (remove "Today" (org-get-tags)))))
(defun my-remove-focus-tag-when-done ()
  "Remove the :Focus: tag when a task is marked as done"
  (when (org-entry-is-done-p)
    (org-set-tags (remove "Focus" (org-get-tags)))))
(defun my-add-focus-tag-when-has-today-tag ()
  "Add the :Focus: tag is :Today: tag is set"
  (when (and (not (member "Focus" (org-get-tags))) (member "Today" (org-get-tags)))
    (org-set-tags (delete-dups (append (org-get-tags) '("Focus"))))))
(defun my-add-clock-effort-diff-property ()
  (interactive)
  "Calculate the clock effort diff and set to property ClockEffortDiff"
  (let ((effort (org-duration-to-minutes (org-entry-get nil "Effort")))
        (clock  (org-duration-to-minutes (org-clock-sum-current-item))))
    (let ((diff (- clock effort)))
      (org-entry-put nil "ClockEffortDiff" (concat (if (>= diff 0) "+" "-") (org-duration-from-minutes (abs diff)))))))

(defconst my-org-agenda-review-settings '((org-agenda-start-with-log-mode 't)
                                          (org-agenda-archives-mode       't)
                                          (org-agenda-use-time-grid       nil))
  "Common settings for review of org agenda")

(setq org-directory                                   my-local-machine-org-directory)
(setq org-agenda-files                                (concat org-directory "/orgAgendaFiles.org"))  ; 設定 agenda file 的列表設定檔
(setq org-icalendar-combined-agenda-file              (concat org-directory "/agenda.ics"))
(setq org-default-notes-file                          (concat org-directory "/note.org"))
(setq org-ellipsis                                    " ▼")
(setq org-adapt-indentation                           't)
(setq org-image-actual-width                          'nil)
(setq org-icalendar-timezone                          "Asia/Taipei")
(setq org-export-backends                             '(html latex odt beamer icalendar))
(setq org-agenda-span                                 'day)
(setq org-agenda-skip-scheduled-if-deadline-is-shown  'repeated-after-deadline)
(setq org-agenda-dim-blocked-tasks                    'invisible)
(setq org-highest-priority                            ?A)
(setq org-lowest-priority                             ?E)
(setq org-default-priority                            ?C)
(setq org-columns-default-format                      "%25ITEM %TODO %3PRIORITY %Effort %CLOCKSUM %ClockEffortDiff %TAGS")
(setq org-columns-default-format-for-agenda           (concat "%10CATEGORY " org-columns-default-format))
(setq org-log-done                                    'time)
(setq org-archive-location                            "%s_archive::datetree/")
(setq org-refile-use-outline-path                     'full-file-path)
(setq org-outline-path-complete-in-steps              'nil)
(setq org-refile-allow-creating-parent-nodes          't)
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel  . 2))
        (org-agenda-files . (:tag       . "Refile"))
        (org-agenda-files . (:tag       . "Project"))))
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "" "Todo") "** TODO %?")
        ("d" "date" entry (file+headline "" "Date") "** %?\n   %^t")
        ("n" "note" entry (file+headline "" "Note") "** %?")))
(let ((build-todo-entries
       (lambda (settings)
         (let ((build-priority-template-entry
                (lambda (priority)
                  (let (template-settings)
                    (dolist (setting settings)
                      (add-to-list 'template-settings setting))
                    (add-to-list 'template-settings `(org-agenda-overriding-header ,(concat "Todo List With Priority [#" (string priority) "]:")))
                    (add-to-list 'template-settings `(org-agenda-skip-function     '(my-skip-entry-if-not-priority ,priority)))
                    `(alltodo "" ,template-settings)))))
           (mapcar build-priority-template-entry
                   (number-sequence org-highest-priority org-lowest-priority)))))

      (build-agenda-priority-entries
       (lambda ()
         (let ((build-priority-entry
                (lambda (priority)
                  `(agenda "" ((org-agenda-overriding-header  ,(concat "Assigned Todo List With Priority [#" (string priority) "]:"))
                               (org-agenda-skip-function      '(lambda ()
                                                                 (let ((end-position (org-agenda-skip-entry-if 'regexp "[[:digit:]]\\{2\\}:[[:digit:]]\\{2\\}.*>")))
                                                                   (if end-position
                                                                       end-position
                                                                     (my-skip-entry-if-not-priority ,priority))))))))))
           (mapcar build-priority-entry
                   (number-sequence org-highest-priority org-lowest-priority))))))

  (setq org-agenda-custom-commands
        `(("t" . "List TODO entries")
          ("ta" "List all the TODO entries"
           ,(funcall build-todo-entries ()))
          ("tt" "List all the unscheduled TODO entries"
           ,(funcall build-todo-entries '((org-agenda-todo-ignore-scheduled 't))))
          ("tu" "List all the unassigned TODO entries"
           ,(funcall build-todo-entries '((org-agenda-todo-ignore-scheduled 't)
                                          (org-agenda-todo-ignore-deadlines 't))))
          ("a" . "List Agendas")
          ("aa" "Agenda and todo for current day"
           ((agenda     ""      ((org-agenda-overriding-header  "Daily Agenda:")
                                 (org-agenda-skip-function      '(org-agenda-skip-entry-if 'notregexp "[[:digit:]]\\{2\\}:[[:digit:]]\\{2\\}.*>"))
                                 (org-deadline-warning-days     0)))
            (tags-todo  "Today" ((org-agenda-overriding-header  "Today's Todo List:")))
            (tags-todo  "Focus" ((org-agenda-overriding-header  "Focused Todo List:")))
            ,@(funcall build-agenda-priority-entries)))
          ("ad" "Review daily agenda" agenda ""
           ((org-agenda-span                'day)
            (org-agenda-start-day           "-1d")
            ,@my-org-agenda-review-settings))
          ("aw" "Review weekly agenda" agenda ""
           ((org-agenda-span                'week)
            (org-agenda-start-on-weekday    nil)
            (org-agenda-start-day           "-1w")
            ,@my-org-agenda-review-settings))
          ("ay" "Review yearly agenda" agenda ""
           ((org-agenda-span                'year)
            (org-agenda-start-day           "-1y")
            ,@my-org-agenda-review-settings)))))
(setq org-todo-keywords
      '((sequence "TODO" "WIP" "|" "DONE" "CANCEL")))
(setq org-tag-persistent-alist          '(("Refile")
                                          ("Project")
                                          ("Today")
                                          ("Focus")))
(setq org-tags-exclude-from-inheritance '("Refile"
                                          "Project"
                                          "Today"
                                          "Focus"))
(setq org-publish-project-alist
      `(("github-io"
         :base-directory        ,my-local-machine-github-io-git-repo
         :publishing-directory  ,my-local-machine-github-io-git-repo
         :recursive             t)))

(when (package-installed-p 'org-attach-screenshot)
  (require 'org-attach-screenshot)

  (setq org-attach-screenshot-command-line my-local-machine-org-screenshot-command-line)
  (add-to-list 'org-attach-commands '((?C) org-attach-screenshot "Attach screenshot.")))

(when (package-installed-p 'org-alert)
  (require 'org-alert)
  (org-alert-enable)
  (if (string= system-type "windows-nt")
      (if (and (>= (car (w32-version)) 8) (package-installed-p 'alert-toast))
          ; for Windows version >= 8
          (progn
            (require 'alert-toast)
            (setq alert-default-style 'toast))
        ; for Windows version < 8
        (setq alert-default-style 'w32))
    ; for other OS
    (setq alert-default-style 'notifizations))
  (setq org-alert-interval 600))

(add-hook 'org-after-todo-state-change-hook 'my-remove-today-tag-when-done)
(add-hook 'org-after-todo-state-change-hook 'my-remove-focus-tag-when-done 1) ; should be after removing today tag
(add-hook 'org-after-tags-change-hook       'my-add-focus-tag-when-has-today-tag)
(add-hook 'org-clock-out-hook               'my-add-clock-effort-diff-property)
(add-hook 'org-property-changed-functions   (lambda (property value)
                                              (when (string= property "Effort")
                                                (my-add-clock-effort-diff-property))))

(defconst my-remote-cal-file (concat org-directory "/orgRemoteCal.org")
  "The file stores the information to synchronize with remote calendar.
Each line is an elisp list with two string elements.
The first element is the filename to store the agenda.
The second element is the url to fetch the ics file from remote calendar.")

;;;; export filter settings  匯出過濾器設定
(defun my-remote-cal-filter (body backend channel)
  "Filter agenda from remote calendar"
  (if (string-equal backend "icalendar")
      (let ((category (org-get-category))
            filtered)
        (with-temp-buffer
          (insert-file-contents my-remote-cal-file)
          (dolist (line (split-string (buffer-string) "\n" t))
            (when (string-equal category (car (read line)))
              (setq filtered 't))))
        (if filtered
            ""
          body))
    body))

(require 'ox)
(add-to-list 'org-export-filter-body-functions 'my-remote-cal-filter)
; end export filter settings

;;;; synchonized with remote calendar  與遠端日曆同步
(require 'term)
(defun my-sync-agenda-files-to-git-repo ()
  "Synchronize org agenda files to git repo"
  (interactive)
  (let ((buffer (get-buffer-create "*Sync Org Agenda Files*")))
    (with-current-buffer buffer
      (cd my-local-machine-org-agenda-git-repo)
      (split-window nil nil 'above)
      (switch-to-buffer buffer)
      (term-mode)
      (term-exec buffer "Sync Org Agenda Files" "make" nil '("sync")))))

(defun my-sync-agenda-from-remote-cal ()
  "Synchronize org agenda from remote calendar"
  (interactive)
  (let ((ics2org "ical2orgpy")
        line data url icsFile orgFile)
    (with-temp-buffer
      (insert-file-contents my-remote-cal-file)
      (dolist (line (split-string (buffer-string) "\n" t))
        (setq data    (read line))
        (setq url     (cadr data))
        (setq icsFile (concat (expand-file-name org-directory) "/" (car data) ".ics"))
        (setq orgFile (concat (expand-file-name org-directory) "/" (car data) ".org"))
        (call-process "curl"  nil nil nil url "-o" icsFile)
        (call-process ics2org nil nil nil icsFile orgFile)
        (delete-file icsFile)
        (let ((buffer (find-buffer-visiting orgFile)))
          (if buffer
            (save-current-buffer
              (set-buffer buffer)
              (revert-buffer 't 't))
            (princ "No buffer found\n"))))
      (princ "Synchronized from Remote Calendar"))))

(require 'org-agenda)
(defun my-sync-agenda-to-remote-cal ()
  "Synchronize org agenda to remote calendar"
  (interactive)
  (org-icalendar-combine-agenda-files)
  (princ "Synchronized to Remote Calendar"))
; end synchonized with remote calendar

;;;; org mode specific key bindings
(defun my-org-agenda-file-to-front ()
  "org-agenda-file-to-front works on single org-agenda-files"
  (interactive)
  (save-current-buffer
    (let ((current-file buffer-file-name)
          (agenda-file  org-agenda-files))
      (set-buffer (find-file-noselect agenda-file))
      (goto-char (point-min))
      (insert current-file "\n")
      (save-buffer)
      (princ (concat "Adding file " current-file " to agenda file")))))

(defun my-org-remove-file ()
  "org-remove-file works on single org-agenda-files"
  (interactive)
  (save-current-buffer
    (let ((current-file buffer-file-name)
          (agenda-file  org-agenda-files))
      (set-buffer (find-file-noselect agenda-file))
      (goto-char (point-min))
      (goto-char (re-search-forward (concat "^" current-file "$") nil t))
      (delete-region (- (point) (length current-file)) (1+ (point)))
      (save-buffer)
      (princ (concat "Removing file " current-file " from agenda file")))))

(defun my-org-agenda-toggle-blocked-tasks-visiblility ()
  "Toggle visitility of blocked tasks in org agenda"
  (interactive)
  (if (equal org-agenda-dim-blocked-tasks 'invisible)
      (setq org-agenda-dim-blocked-tasks 't)
    (setq org-agenda-dim-blocked-tasks 'invisible))
  (org-agenda-redo))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c [") 'my-org-agenda-file-to-front)
            (define-key org-mode-map (kbd "C-c ]") 'my-org-remove-file)))

(add-hook 'org-agenda-mode-hook
          'hl-line-mode)
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map (kbd "C-c d") 'my-org-agenda-toggle-blocked-tasks-visiblility)))
; end org mode settings

;;; mail settings  郵件設定
(setq gnus-select-method
      '(nnimap "imap.gmail.com"
               (nnmail-expiry-target "nnimap+gmail:[Gmail]/垃圾桶")
               (nnmail-expiry-wait immediate)))
(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-most-recent-date))
(setq gnus-summary-line-format "%U%R%z%-15,15&user-date;%I%(%[%4L: %-23,23f%]%) %s\n")
(setq compose-mail-user-agent-warnings nil)
(setq mail-user-agent 'message-user-agent)
(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(add-hook 'gnus-group-mode-hook 'hl-line-mode)
(add-hook 'gnus-summary-mode-hook 'hl-line-mode)
(when (package-installed-p 'ebdb)
  (require 'ebdb-gnus)
  (require 'ebdb-message))
; end mail settings

;;; eww settings  eww 瀏覽器設定
(defconst my-gui-browser-urls
  '(
    "gamer\\.com\\.tw"
    "quora\\.com"
    )
  "Urls should be opened with GUI browser")

(let ((gui-browser-urls (mapcar (lambda (url)
                                  `(,url . browse-url-default-browser))
                                my-gui-browser-urls)))
  (if (>= emacs-major-version 28)
      ; set browse-url-browser-function to alist is deprecated
      (progn
        (setq browse-url-browser-function 'eww)
        (setq browse-url-handlers         gui-browser-urls))
    (setq browse-url-browser-function
          `(,gui-browser-urls
            ("." . eww)))))

(defun my-eww-toggle-mouse-browse ()
  "toggle browsing eww with mouse"
  (interactive)
  (if (equal (symbol-value 'tool-bar-mode) nil)
      (progn
        (tool-bar-mode              1)
        (scroll-bar-mode            1)
        (horizontal-scroll-bar-mode 1)
        (tab-bar-mode               1))
    (progn
      (tool-bar-mode              -1)
      (scroll-bar-mode            -1)
      (horizontal-scroll-bar-mode -1)
      (tab-bar-mode               -1))))
; end eww settings

;;; perfect margin mode settings  perfect margin mode 設定
(when (package-installed-p 'perfect-margin)
  (setq perfect-margin-visible-width 80))
; end perfect margin mode settings

;;; alert settings  alert 設定
(when (package-installed-p 'alert)
  (require 'alert)
  (alert-define-style 'w32 :title "W32 notification style"
                      :notifier 'my-alert-w32-notify
                      :remover  'my-alert-w32-close))
; end alert settings  alert 設定

;;; load local machine settings  讀取本地機器設定
(when (file-readable-p my-local-machine-init-file)
    (load-file my-local-machine-init-file))
;;; local varialbe settings
;; Local Variables:
;; eval: (outline-minor-mode 't)
;; outline-regexp: "\s*;;;+"
;; eval: (outline-hide-sublevels 3)
;; End:
