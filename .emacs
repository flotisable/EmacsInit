(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-tab-always-indent nil)
 '(custom-enabled-themes (quote (misterioso)))
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(package-selected-packages (quote (ox-ioslide evil)))
 '(tab-always-indent nil)
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 142))))
 '(cursor ((t (:background "azure4")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


; third-party archives  第三方套件庫
(require 'package)                                          ; 需要 package 這個套件
(add-to-list 'package-archives 
             '("melpa" . "https://melpa.org/packages/") t)  ; 加入 melpa 套件庫
(package-initialize)                                        ; 讀入套件資料
; end third-party archives

; automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件
(setq package-list '(evil ox-ioslide))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
; end automatic download package when using emacs for the first time  在第一次使用 emacs 時自動下載套件

; mode settings  模式設定
(column-number-mode 1 ) ; 在 mode line 顯示列號
(menu-bar-mode -1     ) ; 關閉 menu bar
(tool-bar-mode -1     ) ; 關閉 tool bar
(scroll-bar-mode -1   ) ; 關閉 scroll bar
(display-time-mode 1  ) ; 在 mode line 顯示時間

(if (fboundp 'display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode  )
  (add-hook 'prog-mode-hook 'linum-mode                 )) ; 在 prog mode 下顯示行號
; end mode settings

; key bindings  按鍵設定
(global-set-key "\C-ca" 'org-agenda) ; 設定 C-c a 開啟 org agenda dispatcher
; end key bindings

; evil mode settings  evil mode 設定
(require 'evil) ; 需要 evil 這個套件
(evil-mode 1)   ; 開啟 evil mode

(setq-default evil-shift-width 2) ; 設定縮排為 2 個字元

; function to toggle relative line number in evil mode  在 evil mode 切換相對行號的函式
(defun evil-toggle-relative ()
  (interactive)
  (if (equal (symbol-value 'display-line-numbers) t)
    (setq display-line-numbers 'relative)
    (setq display-line-numbers t        )))
; end function to toggle relative line number in evil mode

(define-key evil-normal-state-map " "     'evil-scroll-page-down  ) ; 設定空白鍵向上一頁
(define-key evil-normal-state-map "\d"    'evil-scroll-page-up    ) ; 設定退格鍵向下一頁

(if (fboundp 'display-line-numbers-mode)
  (define-key evil-normal-state-map "\\r" 'evil-toggle-relative)) ; 設定 \r 切換行號顯示

; remove vim key binding in insert mode  清掉插入模式的 vim 按鍵
(define-key evil-insert-state-map "\C-w"  nil )
(define-key evil-insert-state-map "\C-a"  nil )
(define-key evil-insert-state-map "\C-d"  nil )
(define-key evil-insert-state-map "\C-t"  nil )
(define-key evil-insert-state-map "\C-x"  nil )
(define-key evil-insert-state-map "\C-p"  nil )
(define-key evil-insert-state-map "\C-n"  nil )
(define-key evil-insert-state-map "\C-e"  nil )
(define-key evil-insert-state-map "\C-y"  nil )
(define-key evil-insert-state-map "\C-r"  nil )
(define-key evil-insert-state-map "\C-o"  nil )
(define-key evil-insert-state-map "\C-k"  nil )
(define-key evil-insert-state-map "\C-v"  nil )
; end remove vim key binding in insert mode
; end evil mode settings

; org mode settings  org mode 設定
(setq org-agenda-files "~/Documents/orgAgendaFiles.org")  ; 設定 agenda file 的列表設定檔
(setq org-export-backends '(html latex odt ioslide beamer))
; end org mode settings
