;; -*- lexical-binding: t -*-

(require 'dashboard)
(dashboard-setup-startup-hook)

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Jun's Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner 'official)
;; Value can be
;; - nil to display no banner
;; - 'official which displays the official emacs logo
;; - 'logo which displays an alternative emacs logo
;; - 1, 2 or 3 which displays one of the text banners
;; - "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer
;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)


(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)))


;;(add-to-list 'dashboard-items '(agenda) t);;today adgenda
(setq dashboard-week-agenda t) ;; next seven days adgenda




(add-to-list 'load-path "~/.emacs.d/lisp/")


(setq mac-option-modifier 'meta
      mac-command-modifier 'super)

(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "s-c") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "s-v") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'kill-region) ;对应Windows上面的Ctrol-x 剪切

(global-linum-mode 1)

(setq inhibit-startup-screen t)

(setq tab-always-indent 'complete) ;; 补全功能，类似于commandline

(electric-pair-mode t) ;; 不全括号 引号

(toggle-frame-maximized) ;; 开启直接最大化

(setq debug-on-signal t);; debug

(setq-default cursor-type '(bar . 3)) ;;更改光标形态


(global-company-mode t) ;; 补全功能


;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)


(setq company-minimum-prefix-length 1) ;;出现一个字母就开始补全
(setq company-idle-delay 0) ;; 补全延时为0

    ;; company mode 默认选择上一条和下一条候选项命令 M-n M-p
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(require 'init-packages) ;; 插入init packages.el here

(package-install 'vertico);; minibuffer向下垂直
(vertico-mode t)

(package-install 'orderless) ;; minibuffer类似于模糊搜素
(setq completion-styles '(orderless))

(package-install 'embark)
(global-set-key (kbd "C-;") 'embark-act) ;;minibuffer action 和自适应的 context menu：Embark
(setq prefix-help-command 'embark-prefix-help-command) ;; 不用再去记住快捷键，这个在minibuffer可以直接使用


;; 我还安装了marginalia,可以直接在minibuffer看到通过m-h-v看到变量的值 或者函数的定义
(marginalia-mode 1)

;;增强文件内搜索和跳转函数定义：Consult
;;replace swiper
(global-set-key (kbd "C-s") 'consult-line)
;;consult-imenu
;; 设置是为了看函数列表在写代码的时候
(global-set-key (kbd "C-c s") 'consult-imenu)

(setq make-backup-files nil)

;;使用下面的配置来加入最近打开过文件的选项让我们更快捷的在图形界面的菜单中打开最近 编辑过的文件。
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10) 
;; 这个快捷键绑定可以用之后的插件 counsel 代替
;; (global-set-key (kbd "C-x C-r") 'recentf-open-files)



(require 'init-ui)


;; Support Chinese word
;;(setq osx-dictionary-use-chinese-text-segmentation t)

(setq osx-dictionary-use-chinese-text-segmentation t)


;; Key bindings for dinctionary, 字典 字典
(global-set-key (kbd "C-c d") 'osx-dictionary-search-word-at-point)
;; (global-set-key (kbd "C-c i") 'osx-dictionary-search-input)

;; Work with popwin-el (https://github.com/m2ym/popwin-el)
;; (push "*osx-dictionary*" popwin:special-display-config)


;;分屏之间的跳转设置
(when (fboundp 'windmove-default-keybindings))
(windmove-default-keybindings)
(global-set-key (kbd "C-c j") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c i") 'windmove-up)
(global-set-key (kbd "C-c k") 'windmove-down)



;;格式化整个文件函数
(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))
;;绑定到F7键
(global-set-key [f11] 'indent-whole)


(global-set-key (kbd "C-x b") 'consult-buffer);; 将按键映射到consult buffer，这样既显示目前打开的buffer，也可以将最近打开的文件显示粗来

(global-set-key (kbd "C-h C-f") 'find-function);; 跳转到函数 变量和key
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
 

(package-install 'embark-consult) ;;批量修改
(package-install 'wgrep)
(setq wgrep-auto-save-buffer t)

(eval-after-load
    'consult
  '(eval-after-load
       'embark
     '(progn
	(require 'embark-consult)
	(add-hook
	 'embark-collect-mode-hook
	 #'consult-preview-at-point-mode))))


(defun embark-export-write ()
  "Export the current vertico results to a writable buffer if possible.
Supports exporting consult-grep to wgrep, file to wdeired, and consult-location to occur-edit"
  (interactive)
  (require 'embark)
  (require 'wgrep)
  (pcase-let ((`(,type . ,candidates)
               (run-hook-with-args-until-success 'embark-candidate-collectors)))
    (pcase type
      ('consult-grep (let ((embark-after-export-hook #'wgrep-change-to-wgrep-mode))
                       (embark-export)))
      ('file (let ((embark-after-export-hook #'wdired-change-to-wdired-mode))
               (embark-export)))
      ('consult-location (let ((embark-after-export-hook #'occur-edit-mode))
                           (embark-export)))
      (x (user-error "embark category %S doesn't support writable export" x)))))

(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

;;使用ripgrep来进行搜索
;;consult-ripgrep

(setq consult-locate-args "mdfind")


;; org mode: set up easy templates
(progn (require 'org-tempo))


;;(setq org-capture-templates
;;      '(("t" "Todo" entry (file+headline "~/gtd.org" "Workspace")
;;	 "* TODO [#B] %?\n  %i\n %U"
;;	 :empty-lines 1)))

(global-set-key (kbd "C-c c") 'org-capture)



;; 设置任务流程
(setq org-todo-keywords
      '((sequence "not started(p!)" "in progress(t!)" "blocked(s!)" "|" "finished(d!)" "canceled(a@/!)")))

;; 设置任务样式
(setq org-todo-keyword-faces
   '(("not started" .   (:foreground "red" :weight bold))
    ("blocked" .   (:foreground "red" :weight bold))
    ("in progress" .      (:foreground "orange" :weight bold))
    ("finished" .      (:foreground "green" :weight bold))
    ("canceled" .     (:background "gray" :foreground "black"))
))



;; 设置 Org Agenda 快捷键
(global-set-key (kbd "C-c a") 'org-agenda)

;; 加入到日程列表里
(setq org-agenda-files (list "~/.emacs.d/agenda.org"))



;; org mode to wirte blog
(use-package ox-hugo
  :ensure t   ;Auto-install the package from Melpa
  :after ox)

(with-eval-after-load 'org-capture
      (defun org-hugo-new-subtree-post-capture-template ()
	"Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
	(let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
	       (fname (org-hugo-slug title)))
	  (mapconcat #'identity
		     `(
		       ,(concat "* TODO " title)
		       ":PROPERTIES:"
		       ,(concat ":EXPORT_FILE_NAME: " fname)
		       ":END:"
		       "\n\n")          ;Place the cursor here finally
		     "\n")))

      (add-to-list 'org-capture-templates
		   '("h"                ;`org-capture' binding + h
		     "Hugo post"
		     entry
		     ;; It is assumed that below file is present in `org-directory'
		     ;; and that it has a "Blog Ideas" heading. It can even be a
		     ;; symlink pointing to the actual location of all-posts.org!
		     (file+headline "~/blog/all-blog.org" "Blog Ideas")
		     (function org-hugo-new-subtree-post-capture-template))))









(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(wgrep embark-consult realgud-lldb realgud google-java-format chinese-word-at-point osx-dictionary xpdf vertico orderless monokai-theme marginalia embark consult company))
 '(warning-suppress-types '((auto-save))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

