;;; customization by build in customize UI
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-tab-always-indent nil)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote ("98b4ef49c451350c28a8c20c35c4d2def5d0b8e5abbc962da498c423598a1cdd" default)))
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
   '((org-archive-save-context-info)
     (eval outline-hide-sublevels 3)
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
(defconst my-local-machine-org-directory                "~/Documents/Org"
  "org-directory variable in local machine")
(defconst my-local-machine-org-screenshot-command-line  "magick clipboard: %f"
  "org-screenshot-command-line variable of org-attach-screenshot package")
(defconst my-local-machine-org-agenda-git-repo          "~/Documents/Data/OrgAgenda"
  "git repository of org agenda files")
(defconst my-local-machine-github-io-git-repo           "~/Documents/Github/flotisable.github.io"
  "git repository of github io page")

(setenv "LC_ALL" "en_US.UTF-8")
; end local machine related settings

;;; self defined functions  自定義函式
;;;; function to toggle line number  切換行號
(defun my-toggle-relative ()
  "Toggle relative line number"
  (interactive)
  (my-toggle-display-line t))

(defun my-toggle-absolute ()
  "Toggle absolute line number"
  (interactive)
  (my-toggle-display-line nil))

(defun my-toggle-display-line (is-relative)
  "Toggle line number"
  (setq display-line-numbers (cond
                              (is-relative
                               (cond
                                ((equal display-line-numbers 'visual) t)
                                ('visual)))
                              ((not display-line-numbers)))))
; end function to toggle relative line number

;;;; function to toggle frame alpha  切換透明度
(defun my-toggle-frame-alpha ()
  "Toggle frame alpha"
  (interactive)
  (let ((default-alpha 100)
        (opacity-alpha 80)
        (current-alpha (frame-parameter (selected-frame) 'alpha)))
    (set-frame-parameter (selected-frame) 'alpha
                         (cond
                          ((or (not current-alpha) (= current-alpha default-alpha)) opacity-alpha)
                            (default-alpha)))))
; end function to toggle frame alpha

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

;;;; function to edit org file  編輯 org 檔案
(defun my-edit-org-dir-file ()
  "Edit org file in org directory"
  (interactive)
  (ido-find-file-in-dir my-local-machine-org-directory))
; end function to edit org file

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
; end function to close alert on Windows < 8

;;;; function to format mode line with right alignment  支援置右的 format-mode-line
(defun my-format-mode-line (left right)
  "Format mode line with right alignment support"
  (let ((left-format  (format-mode-line left))
        (right-format (format-mode-line right)))
    (concat left-format
            (string-pad right-format
                        (- (window-total-width) (string-width left-format))
                        ?\s t))))
; end function to format mode line with right alignment

;;;; function to install predefined packages  安裝預設的套件
(defun my-install-predefined-packages ()
  "Install predefined packages"
  (interactive)
  (require 'package)
  (let ((my-package-list  '(evil
                            evil-collection
                            ivy
                            swiper
                            org
                            org-attach-screenshot
                            org-alert
                            htmlize
                            ebdb
                            perfect-margin
                            highlight-parentheses)))
    (when (and (string= system-type "windows-nt") (>= (car (w32-version)) 8))
      (add-to-list 'my-package-list 'alert-toast))

    (unless package-archive-contents
      (package-refresh-contents))

    (dolist (package my-package-list)
      (unless (package-installed-p package)
        (package-install package)))))
; end function to install predefined packages  安裝預設的套件
; end self defined functions

;;; third-party archives  第三方套件庫
(with-eval-after-load 'package
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t)) ; 加入 melpa 套件庫
; end third-party archives

;;; automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件
(unless (file-exists-p package-user-dir)
  (my-install-predefined-packages))
; end automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件

;;; general settings 通用設定
(defconst my-nord0  "#2E3440" "Nord them nord0  color")
(defconst my-nord1  "#3B4252" "Nord them nord1  color")
(defconst my-nord2  "#434C5E" "Nord them nord2  color")
(defconst my-nord3  "#4C566A" "Nord them nord3  color")
(defconst my-nord4  "#D8DEE9" "Nord them nord4  color")
(defconst my-nord5  "#E5E9F0" "Nord them nord5  color")
(defconst my-nord6  "#ECEFF4" "Nord them nord6  color")
(defconst my-nord7  "#8FBCBB" "Nord them nord7  color")
(defconst my-nord8  "#88C0D0" "Nord them nord8  color")
(defconst my-nord9  "#81A1C1" "Nord them nord9  color")
(defconst my-nord10 "#5E81AC" "Nord them nord10 color")
(defconst my-nord11 "#BF616A" "Nord them nord11 color")
(defconst my-nord12 "#D08770" "Nord them nord12 color")
(defconst my-nord13 "#EBCB8B" "Nord them nord13 color")
(defconst my-nord14 "#A3BE8C" "Nord them nord14 color")
(defconst my-nord15 "#B48EAD" "Nord them nord15 color")

(defvar my-fixed-pitch-font-family ""
  "Fixed pitch font family")
(defvar my-variable-pitch-font-family ""
  "Variable pitch font family")
(defvar my-chinese-font-family ""
  "Chinese font family")

(if (string= system-type "windows-nt")
    (progn
      (set-message-beep 'silent)
      (setq my-fixed-pitch-font-family    "Consolas")
      (setq my-variable-pitch-font-family "Times New Romain")
      (setq my-chinese-font-family        "標楷體"))
  (setq my-fixed-pitch-font-family    "DejaVu Sans Mono")
  (setq my-variable-pitch-font-family "DejaVu Serif")
  (setq my-chinese-font-family        "AR PL New Kai"))

(when (member my-fixed-pitch-font-family (font-family-list))
  (set-face-attribute 'fixed-pitch nil :family my-fixed-pitch-font-family))
(when (member my-variable-pitch-font-family (font-family-list))
  (set-face-attribute 'variable-pitch nil :family my-variable-pitch-font-family))
(unless (string= my-fixed-pitch-font-family "")
  (set-face-attribute 'default nil :family my-fixed-pitch-font-family))
(unless (string= my-chinese-font-family "")
  (set-fontset-font t 'han my-chinese-font-family))

; This is needed for running with daemon mode
(add-hook 'window-setup-hook
          (lambda ()
            (unless (string= my-chinese-font-family "")
              (set-fontset-font t 'han my-chinese-font-family))
            (when (x-list-fonts "DejaVuSansM Nerd Font")
              (add-hook 'emacs-lisp-mode-hook (lambda ()
                                                (setq mode-name "")))
              (add-hook 'org-mode-hook        (lambda ()
                                                (setq mode-name ""))))))

(setq-default mode-line-format
              `(:eval (my-format-mode-line
                       '((:propertize ("" "%e" mode-line-front-space (vc-mode vc-mode) " ")
                                      face (:foreground ,my-nord7 :background ,my-nord11))
                         (:eval (propertize
                                 (string-replace
                                  "%" "%%"
                                  (format-mode-line
                                   '(" " mode-line-mule-info mode-line-client mode-line-modified mode-line-remote)))
                                 'face '(:foreground ,my-nord8 :background ,my-nord1 :weight bold)))
                         (:propertize evil-mode-line-tag
                                      face (:foreground ,my-nord8 :background ,my-nord1 :weight bold))
                         (:eval (propertize
                                 (format-mode-line
                                  '("" mode-line-frame-identification mode-line-buffer-identification))
                                 'face '(:foreground ,my-nord4 :weight bold))))
                       '((:eval (propertize
                                 (format-mode-line '(" " mode-line-modes))
                                 'face '(:foreground ,my-nord8 :background ,my-nord1 :weight bold)))
                         (:eval (propertize
                                 (format-mode-line '(" " mode-line-position))
                                 'face '(:foreground ,my-nord13 :background ,my-nord9)))
                         (:propertize (" " mode-line-misc-info mode-line-end-spaces) face (:background ,my-nord10))))))

(when (package-installed-p 'nord-theme)
  (load-theme 'nord)
  ; This is needed for running with daemon mode
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (with-selected-frame frame
                (load-theme 'nord)))))

(setq display-line-numbers-type         'visual)
(setq display-time-default-load-average nil)
; end general settings

;;; mode settings  模式設定
(column-number-mode       1 ) ; 在 mode line 顯示列號
(menu-bar-mode            -1) ; 關閉 menu bar
(tool-bar-mode            -1) ; 關閉 tool bar
(scroll-bar-mode          -1) ; 關閉 scroll bar
(display-time-mode        1 ) ; 在 mode line 顯示時間
(show-paren-mode          1 ) ; highlight 對應的小括號
(global-auto-revert-mode  1 ) ; 自動讀取更改的檔案

(if (fboundp 'display-line-numbers-mode)
    (progn
      (add-hook 'prog-mode-hook 'display-line-numbers-mode)
      (add-hook 'text-mode-hook 'display-line-numbers-mode))
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'text-mode-hook 'linum-mode)) ; 在 prog mode 下顯示行號

(when (package-installed-p 'highlight-parentheses)
  (add-hook 'prog-mode-hook 'highlight-parentheses-mode))

(add-hook 'package-menu-mode-hook 'hl-line-mode)
; end mode settings

;;; key bindings  按鍵設定
(global-set-key (kbd "C-c a") 'org-agenda           ) ; 設定 C-c a 開啟 org agenda dispatcher
(global-set-key (kbd "C-c c") 'org-capture          ) ; 設定 C-c c 開啟 org capture
(global-set-key (kbd "C-c l") 'org-store-link       ) ; 設定 C-c l 儲存當前位置連結
(global-set-key (kbd "C-s"  ) 'swiper               ) ; 設定 C-s 開啟互動式模糊搜尋
(global-set-key (kbd "C-c o") 'my-toggle-frame-alpha) ; 設定 C-c o 切換透明度
; end key bindings

;;; evil mode settings  evil mode 設定
(when (package-installed-p 'evil)
  (setq evil-want-keybinding 'nil)
  (add-hook 'window-setup-hook (lambda () (evil-mode 1))) ; 開啟 evil mode
  (add-hook 'evil-mode-hook
            (lambda ()
              (when (package-installed-p 'evil-collection)
                (evil-collection-init '(eww
                                        gnus
                                        info
                                        (custom cus-edit)
                                        (term term ansi-term multi-term)))
                (add-hook 'evil-collection-unimpaired-mode-hook
                          (lambda ()
                            (setq minor-mode-alist (assoc-delete-all 'evil-collection-unimpaired-mode minor-mode-alist)))))

              (setq evil-shift-width  2) ; 設定縮排為 2 個字元
              (setq evil-echo-state   nil)

              ;;;; state symbol customization  狀態符號設定
              (setq evil-normal-state-tag   " Ⓝ ")
              (setq evil-insert-state-tag   " Ⓘ ")
              (setq evil-visual-state-tag   " Ⓥ ")
              (setq evil-replace-state-tag  " Ⓡ ")
              (setq evil-operator-state-tag " Ⓞ ")
              (setq evil-motion-state-tag   " Ⓜ ")
              (setq evil-emacs-state-tag    " Ⓔ ")
              ; end state symbol customization

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
              (evil-global-set-key  'normal (kbd "<leader>eo") 'my-edit-org-dir-file            ) ; 設定 \eo 編輯 org 檔案
              (when (fboundp 'display-line-numbers-mode)
                (evil-global-set-key 'normal (kbd "<leader>r") 'my-toggle-relative)   ; 設定 \r 切換相對行號顯示
                (evil-global-set-key 'normal (kbd "<leader>n") 'my-toggle-absolute))  ; 設定 \n 切換行號顯示
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
                      (evil-global-set-key mode (kbd key) nil))))))))
              ; end remove vim key binding in insert mode
; end evil mode settings

;;; org mode settings  org mode 設定
;;;; self defined functions  自定義函式
;;;;; miscs  雜項
(defun my-skip-entry-if-not-priority (priority)
  "Skip entry in org agenda when no in specified priority"
  (when (not (= (org-get-priority (org-get-heading)) (org-get-priority (concat "[#" (string priority) "]"))))
    (org-entry-end-position)))
(defun my-skip-entry-if-not-specific-time ()
  "Skip entry in org agenda when not today non specific time"
  (let* ((point-start     (org-element-property :begin  (org-element-at-point)))
         (point-end       (org-element-property :end    (org-element-at-point)))
         (element-string  (buffer-substring point-start point-end)))
    (with-temp-buffer
      (insert element-string)
      (unless (org-element-map (org-element-parse-buffer) 'timestamp
                (lambda (timestamp)
                  (not (or (org-element-property :hour-start    timestamp)
                           (org-element-property :minute-start  timestamp))))
                nil t)
        point-end))))
(defun my-remove-today-tag-when-done ()
  "Remove the :Today: tag when a task is marked as done"
  (when (org-entry-is-done-p)
    (org-set-tags (remove "Today" (org-get-tags (point) t)))))
(defun my-remove-focus-tag-when-done ()
  "Remove the :Focus: tag when a task is marked as done"
  (when (org-entry-is-done-p)
    (org-set-tags (remove "Focus" (org-get-tags (point) t)))))
(defun my-add-focus-tag-when-has-today-tag ()
  "Add the :Focus: tag is :Today: tag is set"
  (when (and (not (member "Focus" (org-get-tags))) (member "Today" (org-get-tags)))
    (org-set-tags (delete-dups (append (org-get-tags (point) t) '("Focus"))))))
(defun my-change-parent-todo-state ()
  "Change parent todo state"
  (if (> (org-outline-level) 1)
    (save-excursion
      (outline-up-heading 1)
      (if (org-get-todo-state)
          (org-todo org-state)))))
(defun my-change-children-priority (is-up)
  "Change children priority"
  (let* ((element             (org-element-at-point))
         (priority            (cond (is-up  'up)
                                    (t      'down)))
         (begin-point         (org-element-property :begin          element))
         (content-begin-point (org-element-property :contents-begin element)))
    (when (and content-begin-point (equal (org-element-type element) 'headline))
      (save-excursion
        (goto-char content-begin-point)
        (while (< (point) (org-element-property :end element))
          (when (equal (org-element-type (org-element-at-point)) 'headline)
            (org-priority priority nil))
          (setq content-begin-point (org-entry-end-position))
          (goto-char begin-point)
          (setq element (org-element-at-point))
          (goto-char content-begin-point))))))
(defun my-add-clock-effort-diff-property ()
  (interactive)
  "Calculate the clock effort diff and set to property ClockEffortDiff"
  (let ((effort (org-duration-to-minutes (org-entry-get nil "Effort")))
        (clock  (org-duration-to-minutes (org-clock-sum-current-item))))
    (let ((diff (- clock effort)))
      (org-entry-put nil "ClockEffortDiff" (concat (if (>= diff 0) "+" "-") (org-duration-from-minutes (abs diff)))))))

;;;;; org capture for tiling window manager  在平鋪式視窗管理員使用 org capture
(defconst my-org-capture-frame-name "Org Capture"
  "Frame name of org capture used for tiling window manager")

(defun my-delete-org-capture-frame ()
  "Delete the frame of org capture used for tiling window manager"
  (dolist (frame (frame-list))
    (if (string= my-org-capture-frame-name (frame-parameter frame 'title))
        (delete-frame frame))))
(defun my-org-capture ()
  "Create a new frame to do org capture. This is mainly to be used for tiling window manager"
  (with-current-buffer "*scratch*"
    (let ((frame  (make-frame `((title  . ,my-org-capture-frame-name)
                                (height . 0.5)
                                (width  . 0.5)))))
      (with-selected-frame frame
        (add-hook 'org-capture-mode-hook 'delete-other-windows)
        (condition-case nil
            (org-capture)
          (error
           (delete-frame frame)))
        (remove-hook  'org-capture-mode-hook            'delete-other-windows)
        (add-hook     'org-capture-after-finalize-hook  'my-delete-org-capture-frame)))))

;;;;; automatically refresh daily agenda  自動更新 daily agenda
(defconst my-org-agenda-refresh-interval 600
  "Update interval for daily agenda in seconds")

(defvar my-org-agenda-refresh-timer nil
  "Timer used to refresh daily agenda")

(defun my-agenda-auto-refresh ()
  "Automatically refresh daily agenda"
  (when my-org-agenda-refresh-timer
    (cancel-timer my-org-agenda-refresh-timer)
    (setq my-org-agenda-refresh-timer nil))
  (when (and (equal org-agenda-type 'agenda) (equal org-agenda-span 'day))
    (setq my-org-agenda-refresh-timer (run-with-timer my-org-agenda-refresh-interval nil
                                                      (lambda ()
                                                        (undo-boundary)
                                                        (with-current-buffer org-agenda-buffer-name
                                                          (org-agenda-redo))
                                                        (undo-boundary))))))
;;;;; building org agenda  用於建構 org agenda
(defun my-build-todo-priority-template-entry (priority settings)
  "Build priority template entry for custom todo agenda"
  (let ((template-settings  settings)
        (default-settings   `((org-agenda-overriding-header ,(concat "Todo List With Priority [#" (string priority) "]:"))
                              (org-agenda-skip-function     '(my-skip-entry-if-not-priority ,priority)))))
    (dolist (setting default-settings)
      (add-to-list 'template-settings setting))
    `(todo "TODO|WIP" ,template-settings)))

(defun my-build-agenda-priority-template-entry (priority settings-place-holder)
  "Build priority template entry for custom agenda"
  (let ((settings `((org-agenda-overriding-header  ,(concat "Assigned Todo List With Priority [#" (string priority) "]:"))
                    (org-agenda-skip-function      '(lambda ()
                                                      (let ((end-position (my-skip-entry-if-not-specific-time)))
                                                        (if end-position
                                                            end-position
                                                          (my-skip-entry-if-not-priority ,priority))))))))
    `(agenda "" ,settings)))

(defun my-build-priority-entries (build-template-function settings)
  "Build priority entries for custom agenda"
  (mapcar (lambda (priority)
            (funcall build-template-function priority settings))
          (number-sequence org-highest-priority org-lowest-priority)))

(defun my-build-todo-entries (settings)
  "Build todo entries for custom agenda"
  (my-build-priority-entries 'my-build-todo-priority-template-entry settings))

(defun my-build-agenda-priority-entries ()
  "Build priority entries for custom agenda"
  (my-build-priority-entries 'my-build-agenda-priority-template-entry ()))

;;;;; building org agenda report  用於建構 org agenda report
(defun my-agenda-report ()
  "Generate report for Org agenda"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((buffer         (get-buffer-create "*Org Agenda Report*"))
          (current-point  (point))
          (item-level     3)
          items)
      ; initialize temp buffer
      (with-current-buffer buffer
        (erase-buffer)
        (org-mode)
        (insert "* [" (org-timestamp-format (org-timestamp-from-time (current-time) t t) "%F %a %R") "] Org Agenda Report\n")
        (insert "** Summary\n")
        (insert "** Details\n"))

      ; parse org agenda and put to temp buffer
      (org-agenda-next-item 1)
      (while (not (= current-point (point)))
        (let ((marker (org-get-at-bol 'org-marker)))
          (with-current-buffer (marker-buffer marker)
            (goto-char (marker-position marker))
            (let ((outline  (append (list (buffer-name)) (org-get-outline-path)))
                  (item     (append (list (buffer-name)) (org-get-outline-path t))))
              (when (not (member item items))
                (push item items)
                (insert-into-buffer buffer (org-entry-beginning-position) (org-entry-end-position))
                (with-current-buffer buffer
                  (save-excursion
                    (org-backward-heading-same-level 0)
                    (org-entry-put (point) "Outline" (mapconcat 'identity outline "/"))
                    (while (> (org-current-level) item-level)
                      (org-do-promote))
                    (while (< (org-current-level) item-level)
                      (org-do-demote))))))))

        (setq current-point (point))
        (org-agenda-next-item 1)))))
;;;;; synchonized with remote calendar  與遠端日曆同步
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

(defun my-sync-agenda-files-to-git-repo ()
  "Synchronize org agenda files to git repo"
  (interactive)
  (let ((buffer (get-buffer-create "*Sync Org Agenda Files*")))
    (with-current-buffer buffer
      (cd my-local-machine-org-agenda-git-repo)
      (split-window nil nil 'above)
      (switch-to-buffer buffer)
      (require 'term)
      (term-mode)
      (term-exec buffer "Sync Org Agenda Files" "make" nil '("sync")))))

(defun my-sync-agenda-files-from-google-drive ()
  "Synchronize org agenda files from google drive"
  (interactive)
  (let ((process (start-process "sync" "*Sync Org Agenda Files*" "rclone" "copyto" "google:Emacs/Org/note.org.gpg" my-org-note-gpg-file)))
    (set-process-sentinel process (lambda (process event)
                                    (epa-decrypt-file my-org-note-gpg-file (expand-file-name org-default-notes-file))))))

(defun my-sync-agenda-files-to-google-drive ()
  "Synchronize org agenda files to google drive"
  (interactive)
  (epa-encrypt-file (expand-file-name org-default-notes-file) (epg-list-keys (epg-make-context epa-protocol) "Wei-Chih"))
  (start-process "sync" "*Sync Org Agenda Files*" "rclone" "copyto" my-org-note-gpg-file "google:Emacs/Org/note.org.gpg"))

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

(defun my-sync-agenda-to-remote-cal ()
  "Synchronize org agenda to remote calendar"
  (interactive)
  (org-icalendar-combine-agenda-files)
  (princ "Synchronized to Remote Calendar"))
; end synchonized with remote calendar

;;;;; for org agenda keybindings  用於 org agenda 快捷鍵
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

;;;; org mode settings  org mode 設定
(defconst my-org-agenda-review-settings '((org-agenda-start-with-log-mode                   't)
                                          (org-agenda-archives-mode                         't)
                                          (org-agenda-use-time-grid                         nil)
                                          (org-agenda-include-inactive-timestamps           't)
                                          (org-agenda-skip-deadline-if-done                 't)
                                          (org-agenda-skip-scheduled-if-done                't)
                                          (org-agenda-skip-additional-timestamps-same-entry 't))
  "Common settings for review of org agenda")

(defconst my-org-agenda-settings '((org-agenda-use-time-grid          nil)
                                   (org-agenda-skip-deadline-if-done  't)
                                   (org-agenda-skip-scheduled-if-done 't))
  "Common settings for org agenda")

(require 'org-protocol)

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
(setq org-agenda-skip-scheduled-if-done               't)
(setq org-agenda-skip-deadline-if-done                't)
(setq org-deadline-past-days                          7)
(setq org-scheduled-past-days                         7)
(setq org-agenda-dim-blocked-tasks                    'invisible)
(setq org-highest-priority                            ?A)
(setq org-lowest-priority                             ?E)
(setq org-default-priority                            ?C)
(setq org-priority-faces
      (let* ((highest-priority-color  my-nord11)
             (lowest-priority-color   my-nord10)
             (priorities              (number-sequence org-highest-priority org-lowest-priority))
             (colors                  (append (list (color-name-to-rgb highest-priority-color))
                                              (color-gradient (color-name-to-rgb highest-priority-color)
                                                              (color-name-to-rgb lowest-priority-color)
                                                              (- (length priorities) 2))
                                              (list (color-name-to-rgb lowest-priority-color)))))
        (mapcar (lambda (priority)
                  (let ((color (nth (- priority org-highest-priority) colors)))
                    (list priority `(:foreground  ,(color-rgb-to-hex (nth 0 color) (nth 1 color) (nth 2 color))
                                     :weight      bold))))
                priorities)))
(setq org-columns-default-format                      "%25ITEM %TODO %3PRIORITY %Effort %CLOCKSUM %ClockEffortDiff %TAGS")
(setq org-columns-default-format-for-agenda           (concat "%10CATEGORY " org-columns-default-format))
(setq org-log-done                                    'time)
(setq org-log-reschedule                              'time)
(setq org-log-redeadline                              'time)
(setq org-log-into-drawer                             't)
(setq org-archive-location                            "%s_archive::datetree/")
(setq org-refile-use-outline-path                     'full-file-path)
(setq org-outline-path-complete-in-steps              'nil)
(setq org-refile-allow-creating-parent-nodes          't)
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel  . 2))
        (org-agenda-files . (:tag       . "Refile"))
        (org-agenda-files . (:tag       . "Project"))))
(setq org-capture-templates
      '(("t" "todo"       entry (file+olp "" "Todo" "Inbox") "*** TODO %?")
        ("d" "date"       entry (file+olp "" "Date" "Inbox") "*** %?\n   %^t")
        ("n" "note"       entry (file+olp "" "Note" "Inbox") "*** %?")
        ("w" "work note"  entry (file+olp "" "Note" "Inbox") "*** %?\n   %U")))
(setq org-agenda-custom-commands
      `(("t" . "List TODO entries")
        ("ta" "List all the TODO entries"
         ,(my-build-todo-entries ()))
        ("tt" "List all the unscheduled TODO entries"
         ,(my-build-todo-entries '((org-agenda-todo-ignore-scheduled 't))))
        ("tu" "List all the unassigned TODO entries"
         ,(my-build-todo-entries '((org-agenda-todo-ignore-scheduled 't)
                                   (org-agenda-todo-ignore-deadlines 't))))
        ("tw" "List all wait TODO entries" todo "WAIT")
        ("tp" "List all pending TODO entries" todo "PENDING")
        ("td" "List all done TODO entries" todo "DONE|CANCEL" ((org-agenda-todo-list-sublevels nil)))
        ("tf" "List all focus TODO entries" tags-todo "Focus" ((org-agenda-overriding-header  "Focused Todo List:")
                                                               (org-agenda-hide-tags-regexp   "Focus")))
        ("a" . "List Agendas")
        ("aa" "Agenda and todo for current day"
         ((agenda     ""            ((org-agenda-overriding-header              "Daily Agenda:")
                                     (org-scheduled-past-days                   0)
                                     (org-deadline-past-days                    0)
                                     (org-deadline-warning-days                 0)
                                     (org-habit-scheduled-past-days             10000)
                                     (org-agenda-hide-tags-regexp               "Today\\\|Focus")))
          (tags-todo  "Today"       ((org-agenda-overriding-header              "Today's Todo List:")
                                     (org-agenda-hide-tags-regexp               "Today\\\|Focus")
                                     (org-agenda-tags-todo-honor-ignore-options 't)
                                     (org-agenda-todo-ignore-scheduled          't)))
          (tags-todo  "Focus-Today" ((org-agenda-overriding-header              "Focused Todo List:")
                                     (org-agenda-hide-tags-regexp               "Focus")))))
        ("ap" "Prioritized agenda and todo for current day"
         (,@(my-build-agenda-priority-entries)))
        ("ad" "Daily agenda" agenda ""
         ((org-agenda-span 'day)
          ,@my-org-agenda-settings))
        ("aw" "Weekly agenda" agenda ""
         ((org-agenda-span 'week)
          ,@my-org-agenda-settings))
        ("am" "Monthly agenda" agenda ""
         ((org-agenda-span 'month)
          ,@my-org-agenda-settings))
        ("ay" "Yearly agenda" agenda ""
         ((org-agenda-span 'year)
          ,@my-org-agenda-settings))
        ("r" . "List Review Agendas")
        ("rd" "Review daily agenda" agenda ""
         ((org-agenda-span                'day)
          (org-agenda-start-day           "-1d")
          ,@my-org-agenda-review-settings))
        ("rw" "Review weekly agenda" agenda ""
         ((org-agenda-span                'week)
          (org-agenda-start-on-weekday    nil)
          (org-agenda-start-day           "-1w")
          ,@my-org-agenda-review-settings))
        ("rm" "Review monthly agenda" agenda ""
         ((org-agenda-span                'month)
          (org-agenda-start-on-weekday    nil)
          (org-agenda-start-day           "-1m")
          ,@my-org-agenda-review-settings))
        ("ry" "Review yearly agenda" agenda ""
         ((org-agenda-span                'year)
          (org-agenda-start-day           "-1y")
          ,@my-org-agenda-review-settings))
        ("i" "List all uncategorized captured entries" tags "Inbox"
         ((org-agenda-overriding-header "Uncategorizaed Captured Items:")
          (org-agenda-hide-tags-regexp  "Inbox")
          (org-agenda-skip-function     '(org-agenda-skip-entry-if 'regexp "Inbox"))))))
(setq org-todo-keywords
      '((sequence "TODO(t)" "WIP(w)" "WAIT(a)" "PENDING(p)" "|" "DONE(d)" "CANCEL(c)")))
(setq org-clock-in-switch-to-state      "WIP")
(setq org-clock-out-switch-to-state     "TODO")
(setq org-todo-keyword-faces            `(("WIP"      . (:foreground ,my-nord8 :weight bold))
                                          ("WAIT"     . (:foreground ,my-nord9))
                                          ("PENDING"  . (:foreground ,my-nord3))
                                          ("CANCEL"   . (:foreground ,my-nord12))))
(setq org-tag-persistent-alist          '(("Refile"   . ?r)
                                          ("Project"  . ?p)
                                          ("Today"    . ?t)
                                          ("Focus"    . ?f)
                                          (:startgroup)
                                          ("Home" . ?h)
                                          ("Work" . ?w)
                                          (:endgroup)))
(setq org-tag-faces                     `(("Today"  . (:foreground ,my-nord8 :weight bold))
                                          ("Focus"  . (:foreground ,my-nord9))
                                          ("Home"   . (:foreground ,my-nord14))
                                          ("Work"   . (:foreground ,my-nord15))))
(setq org-tags-exclude-from-inheritance '("Refile"
                                          "Project"
                                          "Today"))
(setq org-publish-project-alist
      `(("github-io"
         :base-directory        ,my-local-machine-github-io-git-repo
         :publishing-directory  ,my-local-machine-github-io-git-repo
         :recursive             t)))

(when (package-installed-p 'org-attach-screenshot)
  (with-eval-after-load 'org
    (require 'org-attach-screenshot)

    (setq org-attach-screenshot-command-line my-local-machine-org-screenshot-command-line)
    (add-to-list 'org-attach-commands '((?C) org-attach-screenshot "Attach screenshot."))))

(when (package-installed-p 'org-alert)
  (with-eval-after-load 'org-agenda
    (if (string= system-type "windows-nt")
        (if (and (>= (car (w32-version)) 8) (package-installed-p 'alert-toast))
            ; for Windows version >= 8
            (progn
              (require 'alert-toast)
              (setq alert-default-style 'toast))
          ; for Windows version < 8
          (setq alert-default-style 'w32))
      ; for other OS
      (setq alert-default-style 'libnotify))
    (setq org-alert-interval 600)
    (unless (boundp 'my-org-alert-timer)
      (run-with-timer 0 org-alert-interval
                      (lambda ()
                        (start-process "org-alert" "*Org Alert*" "emacs" "--daemon" "--eval" "
                          (progn
                            (setq my-org-alert-timer 1)
                            (require 'org-alert)
                            (org-agenda-list)
                            (org-alert-check)
                            (sleep-for alert-fade-time)
                            (kill-emacs))"))))))

(add-hook 'org-agenda-mode-hook               'hl-line-mode)
(add-hook 'org-agenda-mode-hook               (lambda ()
                                                (setq mode-name "📅")))
(add-hook 'org-agenda-finalize-hook           'my-agenda-auto-refresh)
(add-hook 'org-after-todo-state-change-hook   'my-remove-today-tag-when-done)
(add-hook 'org-after-todo-state-change-hook   'my-remove-focus-tag-when-done 1) ; should be after removing today tag
(add-hook 'org-after-todo-state-change-hook   'my-change-parent-todo-state)
(add-hook 'org-shiftup-hook                   (lambda ()
                                                (my-change-children-priority t)))
(add-hook 'org-shiftdown-hook                 (lambda ()
                                                (my-change-children-priority nil)))
(add-hook 'org-after-tags-change-hook         'my-add-focus-tag-when-has-today-tag)
(add-hook 'org-clock-out-hook                 'my-add-clock-effort-diff-property)
(add-hook 'org-property-changed-functions     (lambda (property value)
                                                (when (string= property "Effort")
                                                  (my-add-clock-effort-diff-property))))
(add-hook 'org-capture-prepare-finalize-hook  (lambda ()
                                                (org-entry-put (point) "CAPTURED"
                                                               (concat "[" (org-timestamp-format (org-timestamp-from-time (current-time) t t) "%F %a %R") "]"))))
(defconst my-remote-cal-file (concat org-directory "/orgRemoteCal.org")
  "The file stores the information to synchronize with remote calendar.
Each line is an elisp list with two string elements.
The first element is the filename to store the agenda.
The second element is the url to fetch the ics file from remote calendar.")

(add-hook 'org-mode (lambda ()
                      (require 'ox)
                      (add-hook 'org-export-filter-body-functions 'my-remote-cal-filter)))

(defconst my-org-note-gpg-file (concat (expand-file-name org-default-notes-file) ".gpg")
  "The file is the gpg encrypt note file of org mode")

;;;; org mode specific key bindings
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c [") 'my-org-agenda-file-to-front)
            (define-key org-mode-map (kbd "C-c ]") 'my-org-remove-file)))

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
  (add-hook 'gnus-started-hook          (lambda () (require 'ebdb-gnus)))
  (add-hook 'message-header-setup-hook  (lambda () (require 'ebdb-message))))
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
  (let ((set-width (lambda (&optional size)
                      (setq perfect-margin-visible-width (max 80 (/ (window-total-width) 2))))))
    (funcall set-width)
    (add-hook 'window-size-change-functions set-width)))
; end perfect margin mode settings

;;; alert settings  alert 設定
(when (package-installed-p 'alert)
  (add-hook 'window-setup-hook
            (lambda ()
              (require 'alert)
              (alert-define-style 'w32 :title "W32 notification style"
                                  :notifier 'my-alert-w32-notify
                                  :remover  'my-alert-w32-close))))
; end alert settings

;;; ivy mode settings  ivy mode 設定
(when (package-installed-p 'ivy)
  (add-hook 'window-setup-hook (lambda () (ivy-mode 1))) ; 互動式模糊補全
  (add-hook 'ivy-mode-hook
            (lambda ()
              (setq ivy-use-virtual-buffers 't)
              (setq minor-mode-alist (assoc-delete-all 'ivy-mode minor-mode-alist))
              (add-to-list 'minor-mode-alist '(ivy-mode " ❧")))))
; end ivy mode settings

;;; load local machine settings  讀取本地機器設定
(when (file-readable-p my-local-machine-init-file)
  (load-file my-local-machine-init-file))
;;; local varialbe settings
;; Local Variables:
;; eval: (outline-minor-mode 't)
;; outline-regexp: "\s*;;;+"
;; eval: (outline-hide-sublevels 3)
;; End:
