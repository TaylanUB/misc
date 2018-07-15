(global-undo-tree-mode)

(setq
 undo-tree-auto-save-history t
 undo-tree-history-directory-alist
 `(("." . ,(emacs-junk-dir "undo-tree-history")))
 )

(define-keys undo-tree-map
  ("C--" 'undo-tree-undo)
  ("C-=" 'undo-tree-redo)
  )
