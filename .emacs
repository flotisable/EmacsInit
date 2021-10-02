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
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
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
(setq local-machine-org-directory               "~/Documents")
(setq local-machine-org-screenshot-command-line "powershell C:/Users/s0993/Documents/Program/Powershell/screenshot.ps1 %f")
; end local machine related settings

;;; third-party archives  第三方套件庫
(require 'package)                                          ; 需要 package 這個套件
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)  ; 加入 melpa 套件庫
(package-initialize)                                        ; 讀入套件資料
; end third-party archives

;;; automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件
(setq package-list '(evil
                     evil-collection
                     ivy
                     swiper
                     org
                     org-attach-screenshot
                     htmlize
                     ebdb))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
; end automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件

;;; mode settings  模式設定
(column-number-mode 1   ) ; 在 mode line 顯示列號
(menu-bar-mode      -1  ) ; 關閉 menu bar
(tool-bar-mode      -1  ) ; 關閉 tool bar
(scroll-bar-mode    -1  ) ; 關閉 scroll bar
(display-time-mode  1   ) ; 在 mode line 顯示時間
(show-paren-mode    1   ) ; highlight 對應的小括號

(when (package-installed-p 'ivy)
  (ivy-mode 1 )) ; 互動式模糊補全

(if (fboundp 'display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode  )
  (add-hook 'prog-mode-hook 'linum-mode                 )) ; 在 prog mode 下顯示行號
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
    (evil-collection-init '(eww gnus info (custom cus-edit))))

  (setq-default evil-shift-width 2) ; 設定縮排為 2 個字元

  ;;;; function to toggle relative line number in evil mode  在 evil mode 切換相對行號的函式
  (defun evil-toggle-relative ()
    "Toggle relative line number in evil mode"
    (interactive)
    (if (equal (symbol-value 'display-line-numbers) t)
      (setq display-line-numbers 'relative)
      (setq display-line-numbers t        )))
  ; end function to toggle relative line number in evil mode

  ;;;; evil mode keybindings  evil mode 按鍵設定
  (evil-global-set-key 'normal (kbd "DEL") 'evil-scroll-page-up   ) ; 設定退格鍵向上一頁
  (evil-global-set-key 'motion (kbd "SPC") 'evil-scroll-page-down ) ; 設定空白鍵向下一頁
  (evil-global-set-key 'motion (kbd "DEL") 'evil-scroll-page-up   ) ; 設定退格鍵向上一頁

  (if (fboundp 'display-line-numbers-mode)
    (evil-global-set-key 'normal (kbd "<leader>r") 'evil-toggle-relative)) ; 設定 \r 切換行號顯示
  ; end evil mode keybindings

  ;;;; remove vim key binding in insert mode  清掉插入模式的 vim 按鍵
  (setq evil-insert-mode-key-to-be-removed '("C-w"
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

  (dolist (key evil-insert-mode-key-to-be-removed)
    (evil-global-set-key 'insert (kbd key) nil)))
; end remove vim key binding in insert mode
; end evil mode settings

;;; org mode settings  org mode 設定
(setq org-directory                           local-machine-org-directory)
(setq org-agenda-files                        (concat org-directory "/orgAgendaFiles.org"))  ; 設定 agenda file 的列表設定檔
(setq org-icalendar-combined-agenda-file      (concat org-directory "/agenda.ics"))
(setq org-default-notes-file                  (concat org-directory "/note.org"))
(setq org-ellipsis                            " ▼")
(setq org-image-actual-width                  'nil)
(setq org-icalendar-timezone                  "Asia/Taipei")
(setq org-export-backends                     '(html latex odt beamer icalendar))
(setq org-agenda-span                         'day)
(setq org-highest-priority                    ?A)
(setq org-lowest-priority                     ?E)
(setq org-default-priority                    ?C)
(setq org-log-done                            'time)
(setq org-refile-use-outline-path             'full-file-path)
(setq org-outline-path-complete-in-steps      'nil)
(setq org-refile-allow-creating-parent-nodes  't)
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel  . 2))
        (org-agenda-files . (:tag       . "Project"))))
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "" "Todo") "** TODO %?")
        ("d" "date" entry (file+headline "" "Date") "** %?\n   %^t")
        ("n" "note" entry (file+headline "" "Note") "** %?")))
(setq org-agenda-custom-commands
      '(("t" . "List TODO entries")
        ("ta" "List all the TODO entries" todo)
        ("tt" "List all the unscheduled TODO entries" todo ""
         ((org-agenda-todo-ignore-scheduled 't)))
        ("tu" "List all the unassigned TODO entries" todo ""
         ((org-agenda-todo-ignore-scheduled 't)
          (org-agenda-todo-ignore-deadlines 't)))
        ("a" "Agenda and todo for current day"
         ((agenda     ""      ((org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "[[:digit:]]\\{2\\}:[[:digit:]]\\{2\\}>"))))
          (tags-todo  "Today")
          (agenda     ""      ((org-agenda-skip-function '(org-agenda-skip-entry-if 'regexp "[[:digit:]]\\{2\\}:[[:digit:]]\\{2\\}>"))))))))
(setq org-todo-keywords
      '((sequence "TODO" "WIP" "|" "DONE" "CANCEL")))

(when (package-installed-p 'org-attach-screenshot)
  (require 'org-attach-screenshot)

  (setq org-attach-screenshot-command-line local-machine-org-screenshot-command-line)
  (add-to-list 'org-attach-commands '((?C) org-attach-screenshot "Attach screenshot.")))

; the file stores the information to synchronize with google calendar
; each line is a elisp list with two string elements
; the first element is the filename to store the agenda
; the second element is the url to fetch the ics file from google calendar
(setq my-google-cal-file (concat org-directory "/orgGoogleCal.org"))

;;;; export filter settings  匯出過濾器設定
(defun google-cal-filter (body backend channel)
  "Filter agenda from google calendar"
  (if (string-equal backend "icalendar")
      (let ((category (org-get-category))
            filtered)
        (with-temp-buffer
          (insert-file-contents my-google-cal-file)
          (dolist (line (split-string (buffer-string) "\n" t))
            (when (string-equal category (car (read line)))
              (setq filtered 't))))
        (if filtered
            ""
          body))
    body))

(require 'ox)
(add-to-list 'org-export-filter-body-functions 'google-cal-filter)
; end export filter settings

;;;; synchonized with google calendar  與 google 日曆同步
(defun sync-agenda-from-google-cal ()
  "Synchronize org agenda from google calendar"
  (interactive)
  (let ((ics2org "ical2orgpy")
        line data url icsFile orgFile)
    (with-temp-buffer
      (insert-file-contents my-google-cal-file)
      (dolist (line (split-string (buffer-string) "\n" t))
        (setq data    (read line))
        (setq url     (cadr data))
        (setq icsFile (concat (expand-file-name org-directory) "/" (car data) ".ics"))
        (setq orgFile (concat (expand-file-name org-directory) "/" (car data) ".org"))
        (call-process "curl"  nil nil nil url "-o" icsFile)
        (call-process ics2org nil nil nil icsFile orgFile)
        (delete-file icsFile)
        (let ((buffer (get-file-buffer orgFile)))
          (when buffer
            (save-current-buffer
              (set-buffer buffer)
              (revert-buffer 't 't)))))
      (princ "Synchronized from Google Calendar"))))

(require 'org-agenda)
(defun sync-agenda-to-google-cal ()
  "Synchronize org agenda to google calendar"
  (interactive)
  (org-icalendar-combine-agenda-files)
  (princ "Synchronized to Google Calendar"))
; end synchonized with google calendar
; end org mode settings

;;; mail settings
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
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(when (package-installed-p 'ebdb)
  (require 'ebdb-gnus)
  (require 'ebdb-message))
; end mail settings

;;; eww settings
(setq browse-url-browser-function
      '(("gamer\\.com\\.tw" . browse-url-default-browser)
        ("quora\\.com"      . browse-url-default-browser)
        ("."                . eww)))

(defun eww-toggle-mouse-browse ()
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

;;; local varialbe settings
;; Local Variables:
;; eval: (outline-minor-mode 't)
;; outline-regexp: "\s*;;;+"
;; eval: (outline-hide-sublevels 3)
;; End:
