(load "file-dwim")

(defun shellplayer-play (file)
  (shell-command (shqq (sp play ,file))))

(defun guitarpro-file-p (file)
  (file-has-extension file))

(defun tuxguitar (file)
  (start-process "tuxguitar" nil "tuxguitar" file))

(defun evince (file)
  (start-process "evince" nil "evince" file))

;; (dolist
;;     (entry
;;      '((("mp3" "flac" "aac" "wav") . shellplayer-play)
;;        (("mkv" "mp4" "wmv" "webm" "avi" "mpg" "mov" "flv" "mts") . mplayer)
;;        (("gp3" "gp4") . tuxguitar)
;;        ("pdf" . evince)))
;;   (add-to-list 'file-dwim-action-list entry))
