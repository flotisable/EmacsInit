# EmacsInit
備份 emacs 設定檔

# 索引
- [檔案](#檔案)
- [使用 Emacs 設定檔](#使用-emacs-設定檔)
  - [在 Linux 和 Mac 上](#在-linux-和-mac-上)
- [安裝](#安裝)
  - [設定檔](#設定檔)
  - [使用安裝腳本](#使用安裝腳本)
  - [使用 Makefile](#使用-makefile)
- [初次使用](#初次使用)
- [快捷鍵](#快捷鍵)
- [套件包](#套件包)

# 檔案
- **.emacs**      : [emacs](https://www.gnu.org/software/emacs/index.html) 的設定
- **install.sh**  : **.emacs** 的安裝腳本
- **makefile**    : 處理 **.emacs** 的 makefile
- **settings**    : 安裝/移除設定檔

# 使用 Emacs 設定檔
開啟 emacs 並輸入 **C-h r** 會打開 emacs 文檔

接著輸入 **g Init File** 並按下 **Enter** 鍵, 會開啟如何放置 emacs 設定檔的說明文件

下面我會講我將 emacs 設定檔放在哪作為參考

## 在 Linux 和 Mac 上
我將 ".emacs" 放在 "$HOME/"

這是 emacs 設定檔的預設位置

# 安裝
## 設定檔
- **targetDir**

  這是 **.emacs** 的安裝資料夾
- **initTargetName**

  這是 **.emacs** 安裝後的檔案名稱

## 使用安裝腳本
這個腳本是用 **bash** script 寫的，所以任何支援 bash script 的 shell 都可以使用

下面會講解如何使用這個腳本

- 首先在 shell 輸入 ```chmod u+x install.sh``` 來讓安裝腳本可以被執行
- 視情況修改設定檔中的變數
- 在 shell 輸入 ```./install.sh``` 來安裝 **.emacs** 檔

## 使用 Makefile
makefile 是為那些想用 **make** 來處理的人寫的

一個原因是因為這樣可以方便我更新原始檔

目前 makefile 提供下列選項
- 預設      : 更新原始檔

  當 **make** 沒有給參數時會做這件事
- install   : 安裝 **.emacs**

  實際上這是使用安裝腳本，因此在使用前要確認安裝腳本可以被執行
- uninstall : 解除安裝 **.emacs**

若要改變 **.emacs** 的安裝路徑與檔案名稱，請直接修改設定檔中的變數

# 初次使用
在第一次使用 emacs init 檔時，可以先決定要不要使用套件

如果不想使用的話，只要將 init 檔中相關的行數刪掉即可

如果要使用套件的話，只要安裝 emacs init 檔，再開啟 emacs 即可。

如果你是第一次使用 emacs，那麼套件將會自動被安裝

如果套件沒有自動安裝並出現錯誤訊息

請在 emacs 中輸入 ```<M-x> package-refresh-contents```， 接著輸入 ```<M-x> load <emacs init 檔的路徑>```

這樣子問題應該就會被解決了。

接下來就是好好享受這個 init 檔了
# 快捷鍵
- C-c a : 開啟 org agenda dispatcher

# 套件包
- evil        : Extensable VI Layer, 讓 emacs 可以使用 vi 的按鍵配置與 mode
- ox-ioslide  : org mode 相關的套件，用來產生 Google I/O 形式的投影片
