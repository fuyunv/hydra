;;; hydra-test.el --- Tests for Hydra

;; Copyright (C) 2015  Free Software Foundation, Inc.

;; Author: Oleh Krehel

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;

;;; Code:

(require 'ert)
(message "Emacs version: %s" emacs-version)

(ert-deftest hydra-red-error ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-error (global-map "M-g")
       "error"
       ("h" first-error "first")
       ("j" next-error "next")
       ("k" previous-error "prev")
       ("SPC" hydra-repeat "rep" :bind nil)))
    '(progn
      (set
       (defvar hydra-error/keymap nil
         "Keymap for hydra-error.")
       (quote
        (keymap
         (32 . hydra-repeat)
         (107 . hydra-error/previous-error)
         (106 . hydra-error/next-error)
         (104 . hydra-error/first-error)
         (kp-subtract . hydra--negative-argument)
         (kp-9 . hydra--digit-argument)
         (kp-8 . hydra--digit-argument)
         (kp-7 . hydra--digit-argument)
         (kp-6 . hydra--digit-argument)
         (kp-5 . hydra--digit-argument)
         (kp-4 . hydra--digit-argument)
         (kp-3 . hydra--digit-argument)
         (kp-2 . hydra--digit-argument)
         (kp-1 . hydra--digit-argument)
         (kp-0 . hydra--digit-argument)
         (57 . hydra--digit-argument)
         (56 . hydra--digit-argument)
         (55 . hydra--digit-argument)
         (54 . hydra--digit-argument)
         (53 . hydra--digit-argument)
         (52 . hydra--digit-argument)
         (51 . hydra--digit-argument)
         (50 . hydra--digit-argument)
         (49 . hydra--digit-argument)
         (48 . hydra--digit-argument)
         (45 . hydra--negative-argument)
         (21 . hydra--universal-argument))))
      (set
       (defvar hydra-error/heads nil
         "Heads for hydra-error.")
       (quote
        (("h"
          first-error
          "first"
          :exit nil)
         ("j"
          next-error
          "next"
          :exit nil)
         ("k"
          previous-error
          "prev"
          :exit nil)
         ("SPC"
          hydra-repeat
          "rep"
          :bind nil
          :exit nil))))
      (defun hydra-error/first-error nil
        "Create a hydra with a \"M-g\" body and the heads:

\"h\":    `first-error',
\"j\":    `next-error',
\"k\":    `previous-error',
\"SPC\":    `hydra-repeat'

The body can be accessed via `hydra-error/body'.

Call the head: `first-error'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (progn
              (setq this-command
                    (quote first-error))
              (call-interactively
               (function first-error)))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-error/hint))
            (message
             (eval hydra-error/hint))))
        (hydra-set-transient-map
         hydra-error/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil))
      (defun hydra-error/next-error nil
        "Create a hydra with a \"M-g\" body and the heads:

\"h\":    `first-error',
\"j\":    `next-error',
\"k\":    `previous-error',
\"SPC\":    `hydra-repeat'

The body can be accessed via `hydra-error/body'.

Call the head: `next-error'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (progn
              (setq this-command
                    (quote next-error))
              (call-interactively
               (function next-error)))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-error/hint))
            (message
             (eval hydra-error/hint))))
        (hydra-set-transient-map
         hydra-error/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil))
      (defun hydra-error/previous-error nil
        "Create a hydra with a \"M-g\" body and the heads:

\"h\":    `first-error',
\"j\":    `next-error',
\"k\":    `previous-error',
\"SPC\":    `hydra-repeat'

The body can be accessed via `hydra-error/body'.

Call the head: `previous-error'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (progn
              (setq this-command
                    (quote previous-error))
              (call-interactively
               (function previous-error)))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-error/hint))
            (message
             (eval hydra-error/hint))))
        (hydra-set-transient-map
         hydra-error/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil))
      (unless (keymapp
               (lookup-key
                global-map
                (kbd "M-g")))
        (define-key global-map (kbd "M-g")
          nil))
      (define-key global-map [134217831 104]
       (function
        hydra-error/first-error))
      (define-key global-map [134217831 106]
       (function
        hydra-error/next-error))
      (define-key global-map [134217831 107]
       (function
        hydra-error/previous-error))
      (set
       (defvar hydra-error/hint nil
         "Dynamic hint for hydra-error.")
       (quote
        (format
         #("error: [h]: first, [j]: next, [k]: prev, [SPC]: rep."
           8 9 (face hydra-face-red)
           20 21 (face hydra-face-red)
           31 32 (face hydra-face-red)
           42 45 (face hydra-face-red)))))
      (defun hydra-error/body nil
        "Create a hydra with a \"M-g\" body and the heads:

\"h\":    `first-error',
\"j\":    `next-error',
\"k\":    `previous-error',
\"SPC\":    `hydra-repeat'

The body can be accessed via `hydra-error/body'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore nil))
          (hydra-keyboard-quit))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-error/hint))
            (message
             (eval hydra-error/hint))))
        (hydra-set-transient-map
         hydra-error/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil)
        (setq prefix-arg
              current-prefix-arg))))))

(ert-deftest hydra-blue-toggle ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-toggle (:color blue)
       "toggle"
       ("t" toggle-truncate-lines "truncate")
       ("f" auto-fill-mode "fill")
       ("a" abbrev-mode "abbrev")
       ("q" nil "cancel")))
    '(progn
      (set
       (defvar hydra-toggle/keymap nil
         "Keymap for hydra-toggle.")
       (quote
        (keymap
         (113 . hydra-toggle/nil)
         (97 . hydra-toggle/abbrev-mode-and-exit)
         (102 . hydra-toggle/auto-fill-mode-and-exit)
         (116 . hydra-toggle/toggle-truncate-lines-and-exit)
         (kp-subtract . hydra--negative-argument)
         (kp-9 . hydra--digit-argument)
         (kp-8 . hydra--digit-argument)
         (kp-7 . hydra--digit-argument)
         (kp-6 . hydra--digit-argument)
         (kp-5 . hydra--digit-argument)
         (kp-4 . hydra--digit-argument)
         (kp-3 . hydra--digit-argument)
         (kp-2 . hydra--digit-argument)
         (kp-1 . hydra--digit-argument)
         (kp-0 . hydra--digit-argument)
         (57 . hydra--digit-argument)
         (56 . hydra--digit-argument)
         (55 . hydra--digit-argument)
         (54 . hydra--digit-argument)
         (53 . hydra--digit-argument)
         (52 . hydra--digit-argument)
         (51 . hydra--digit-argument)
         (50 . hydra--digit-argument)
         (49 . hydra--digit-argument)
         (48 . hydra--digit-argument)
         (45 . hydra--negative-argument)
         (21 . hydra--universal-argument))))
      (set
       (defvar hydra-toggle/heads nil
         "Heads for hydra-toggle.")
       (quote
        (("t"
          toggle-truncate-lines
          "truncate"
          :exit t)
         ("f"
          auto-fill-mode
          "fill"
          :exit t)
         ("a"
          abbrev-mode
          "abbrev"
          :exit t)
         ("q" nil "cancel" :exit t))))
      (defun hydra-toggle/toggle-truncate-lines-and-exit nil
        "Create a hydra with no body and the heads:

\"t\":    `toggle-truncate-lines',
\"f\":    `auto-fill-mode',
\"a\":    `abbrev-mode',
\"q\":    `nil'

The body can be accessed via `hydra-toggle/body'.

Call the head: `toggle-truncate-lines'."
        (interactive)
        (hydra-default-pre)
        (hydra-keyboard-quit)
        (progn
          (setq this-command
                (quote toggle-truncate-lines))
          (call-interactively
           (function
            toggle-truncate-lines))))
      (defun hydra-toggle/auto-fill-mode-and-exit nil
        "Create a hydra with no body and the heads:

\"t\":    `toggle-truncate-lines',
\"f\":    `auto-fill-mode',
\"a\":    `abbrev-mode',
\"q\":    `nil'

The body can be accessed via `hydra-toggle/body'.

Call the head: `auto-fill-mode'."
        (interactive)
        (hydra-default-pre)
        (hydra-keyboard-quit)
        (progn
          (setq this-command
                (quote auto-fill-mode))
          (call-interactively
           (function auto-fill-mode))))
      (defun hydra-toggle/abbrev-mode-and-exit nil
        "Create a hydra with no body and the heads:

\"t\":    `toggle-truncate-lines',
\"f\":    `auto-fill-mode',
\"a\":    `abbrev-mode',
\"q\":    `nil'

The body can be accessed via `hydra-toggle/body'.

Call the head: `abbrev-mode'."
        (interactive)
        (hydra-default-pre)
        (hydra-keyboard-quit)
        (progn
          (setq this-command
                (quote abbrev-mode))
          (call-interactively
           (function abbrev-mode))))
      (defun hydra-toggle/nil nil
        "Create a hydra with no body and the heads:

\"t\":    `toggle-truncate-lines',
\"f\":    `auto-fill-mode',
\"a\":    `abbrev-mode',
\"q\":    `nil'

The body can be accessed via `hydra-toggle/body'.

Call the head: `nil'."
        (interactive)
        (hydra-default-pre)
        (hydra-keyboard-quit))
      (set
       (defvar hydra-toggle/hint nil
         "Dynamic hint for hydra-toggle.")
       (quote
        (format
         #("toggle: [t]: truncate, [f]: fill, [a]: abbrev, [q]: cancel."
           9 10 (face hydra-face-blue)
           24 25 (face hydra-face-blue)
           35 36 (face hydra-face-blue)
           48 49 (face hydra-face-blue)))))
      (defun hydra-toggle/body nil
        "Create a hydra with no body and the heads:

\"t\":    `toggle-truncate-lines',
\"f\":    `auto-fill-mode',
\"a\":    `abbrev-mode',
\"q\":    `nil'

The body can be accessed via `hydra-toggle/body'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore nil))
          (hydra-keyboard-quit))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-toggle/hint))
            (message
             (eval hydra-toggle/hint))))
        (hydra-set-transient-map
         hydra-toggle/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil)
        (setq prefix-arg
              current-prefix-arg))))))

(ert-deftest hydra-amaranth-vi ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-vi
       (:pre
        (set-cursor-color "#e52b50")
        :post
        (set-cursor-color "#ffffff")
        :color amaranth)
       "vi"
       ("j" next-line)
       ("k" previous-line)
       ("q" nil "quit")))
    '(progn
      (set
       (defvar hydra-vi/keymap nil
         "Keymap for hydra-vi.")
       (quote
        (keymap
         (113 . hydra-vi/nil)
         (107 . hydra-vi/previous-line)
         (106 . hydra-vi/next-line)
         (kp-subtract . hydra--negative-argument)
         (kp-9 . hydra--digit-argument)
         (kp-8 . hydra--digit-argument)
         (kp-7 . hydra--digit-argument)
         (kp-6 . hydra--digit-argument)
         (kp-5 . hydra--digit-argument)
         (kp-4 . hydra--digit-argument)
         (kp-3 . hydra--digit-argument)
         (kp-2 . hydra--digit-argument)
         (kp-1 . hydra--digit-argument)
         (kp-0 . hydra--digit-argument)
         (57 . hydra--digit-argument)
         (56 . hydra--digit-argument)
         (55 . hydra--digit-argument)
         (54 . hydra--digit-argument)
         (53 . hydra--digit-argument)
         (52 . hydra--digit-argument)
         (51 . hydra--digit-argument)
         (50 . hydra--digit-argument)
         (49 . hydra--digit-argument)
         (48 . hydra--digit-argument)
         (45 . hydra--negative-argument)
         (21 . hydra--universal-argument))))
      (set
       (defvar hydra-vi/heads nil
         "Heads for hydra-vi.")
       (quote
        (("j" next-line "" :exit nil)
         ("k"
          previous-line
          ""
          :exit nil)
         ("q" nil "quit" :exit t))))
      (defun hydra-vi/next-line nil
        "Create a hydra with no body and the heads:

\"j\":    `next-line',
\"k\":    `previous-line',
\"q\":    `nil'

The body can be accessed via `hydra-vi/body'.

Call the head: `next-line'."
        (interactive)
        (hydra-default-pre)
        (set-cursor-color "#e52b50")
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (progn
              (setq this-command
                    (quote next-line))
              (call-interactively
               (function next-line)))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-vi/hint))
            (message (eval hydra-vi/hint))))
        (hydra-set-transient-map
         hydra-vi/keymap
         (lambda nil
           (hydra-keyboard-quit)
           (set-cursor-color "#ffffff"))
         (quote warn)))
      (defun hydra-vi/previous-line nil
        "Create a hydra with no body and the heads:

\"j\":    `next-line',
\"k\":    `previous-line',
\"q\":    `nil'

The body can be accessed via `hydra-vi/body'.

Call the head: `previous-line'."
        (interactive)
        (hydra-default-pre)
        (set-cursor-color "#e52b50")
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (progn
              (setq this-command
                    (quote previous-line))
              (call-interactively
               (function previous-line)))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-vi/hint))
            (message (eval hydra-vi/hint))))
        (hydra-set-transient-map
         hydra-vi/keymap
         (lambda nil
           (hydra-keyboard-quit)
           (set-cursor-color "#ffffff"))
         (quote warn)))
      (defun hydra-vi/nil nil
        "Create a hydra with no body and the heads:

\"j\":    `next-line',
\"k\":    `previous-line',
\"q\":    `nil'

The body can be accessed via `hydra-vi/body'.

Call the head: `nil'."
        (interactive)
        (hydra-default-pre)
        (set-cursor-color "#e52b50")
        (hydra-keyboard-quit))
      (set
       (defvar hydra-vi/hint nil
         "Dynamic hint for hydra-vi.")
       (quote
        (format
         #("vi: j, k, [q]: quit."
           4 5 (face hydra-face-amaranth)
           7 8 (face hydra-face-amaranth)
           11 12 (face hydra-face-teal)))))
      (defun hydra-vi/body nil
        "Create a hydra with no body and the heads:

\"j\":    `next-line',
\"k\":    `previous-line',
\"q\":    `nil'

The body can be accessed via `hydra-vi/body'."
        (interactive)
        (hydra-default-pre)
        (set-cursor-color "#e52b50")
        (let ((hydra--ignore nil))
          (hydra-keyboard-quit))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-vi/hint))
            (message (eval hydra-vi/hint))))
        (hydra-set-transient-map
         hydra-vi/keymap
         (lambda nil
           (hydra-keyboard-quit)
           (set-cursor-color "#ffffff"))
         (quote warn))
        (setq prefix-arg
              current-prefix-arg))))))

(ert-deftest hydra-zoom-duplicate-1 ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-zoom ()
       "zoom"
       ("r" (text-scale-set 0) "reset")
       ("0" (text-scale-set 0) :bind nil :exit t)
       ("1" (text-scale-set 0) nil :bind nil :exit t)))
    '(progn
      (set
       (defvar hydra-zoom/keymap nil
         "Keymap for hydra-zoom.")
       (quote
        (keymap
         (114 . hydra-zoom/lambda-r)
         (kp-subtract . hydra--negative-argument)
         (kp-9 . hydra--digit-argument)
         (kp-8 . hydra--digit-argument)
         (kp-7 . hydra--digit-argument)
         (kp-6 . hydra--digit-argument)
         (kp-5 . hydra--digit-argument)
         (kp-4 . hydra--digit-argument)
         (kp-3 . hydra--digit-argument)
         (kp-2 . hydra--digit-argument)
         (kp-1 . hydra--digit-argument)
         (kp-0 . hydra--digit-argument)
         (57 . hydra--digit-argument)
         (56 . hydra--digit-argument)
         (55 . hydra--digit-argument)
         (54 . hydra--digit-argument)
         (53 . hydra--digit-argument)
         (52 . hydra--digit-argument)
         (51 . hydra--digit-argument)
         (50 . hydra--digit-argument)
         (49 . hydra-zoom/lambda-0-and-exit)
         (48 . hydra-zoom/lambda-0-and-exit)
         (45 . hydra--negative-argument)
         (21 . hydra--universal-argument))))
      (set
       (defvar hydra-zoom/heads nil
         "Heads for hydra-zoom.")
       (quote
        (("r"
          (text-scale-set 0)
          "reset"
          :exit nil)
         ("0"
          (text-scale-set 0)
          ""
          :bind nil
          :exit t)
         ("1"
          (text-scale-set 0)
          nil
          :bind nil
          :exit t))))
      (defun hydra-zoom/lambda-r nil
        "Create a hydra with no body and the heads:

\"r\":    `(text-scale-set 0)',
\"0\":    `(text-scale-set 0)',
\"1\":    `(text-scale-set 0)'

The body can be accessed via `hydra-zoom/body'.

Call the head: `(text-scale-set 0)'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (call-interactively
             (function
              (lambda nil
               (interactive)
               (text-scale-set 0))))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-zoom/hint))
            (message
             (eval hydra-zoom/hint))))
        (hydra-set-transient-map
         hydra-zoom/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil))
      (defun hydra-zoom/lambda-0-and-exit nil
        "Create a hydra with no body and the heads:

\"r\":    `(text-scale-set 0)',
\"0\":    `(text-scale-set 0)',
\"1\":    `(text-scale-set 0)'

The body can be accessed via `hydra-zoom/body'.

Call the head: `(text-scale-set 0)'."
        (interactive)
        (hydra-default-pre)
        (hydra-keyboard-quit)
        (call-interactively
         (function
          (lambda nil
           (interactive)
           (text-scale-set 0)))))
      (set
       (defvar hydra-zoom/hint nil
         "Dynamic hint for hydra-zoom.")
       (quote
        (format
         #("zoom: [r 0]: reset."
           7 8 (face hydra-face-red)
           9 10 (face hydra-face-blue)))))
      (defun hydra-zoom/body nil
        "Create a hydra with no body and the heads:

\"r\":    `(text-scale-set 0)',
\"0\":    `(text-scale-set 0)',
\"1\":    `(text-scale-set 0)'

The body can be accessed via `hydra-zoom/body'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore nil))
          (hydra-keyboard-quit))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-zoom/hint))
            (message
             (eval hydra-zoom/hint))))
        (hydra-set-transient-map
         hydra-zoom/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil)
        (setq prefix-arg
              current-prefix-arg))))))

(ert-deftest hydra-zoom-duplicate-2 ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-zoom ()
       "zoom"
       ("r" (text-scale-set 0) "reset")
       ("0" (text-scale-set 0) :bind nil :exit t)
       ("1" (text-scale-set 0) nil :bind nil)))
    '(progn
      (set
       (defvar hydra-zoom/keymap nil
         "Keymap for hydra-zoom.")
       (quote
        (keymap
         (114 . hydra-zoom/lambda-r)
         (kp-subtract . hydra--negative-argument)
         (kp-9 . hydra--digit-argument)
         (kp-8 . hydra--digit-argument)
         (kp-7 . hydra--digit-argument)
         (kp-6 . hydra--digit-argument)
         (kp-5 . hydra--digit-argument)
         (kp-4 . hydra--digit-argument)
         (kp-3 . hydra--digit-argument)
         (kp-2 . hydra--digit-argument)
         (kp-1 . hydra--digit-argument)
         (kp-0 . hydra--digit-argument)
         (57 . hydra--digit-argument)
         (56 . hydra--digit-argument)
         (55 . hydra--digit-argument)
         (54 . hydra--digit-argument)
         (53 . hydra--digit-argument)
         (52 . hydra--digit-argument)
         (51 . hydra--digit-argument)
         (50 . hydra--digit-argument)
         (49 . hydra-zoom/lambda-r)
         (48 . hydra-zoom/lambda-0-and-exit)
         (45 . hydra--negative-argument)
         (21 . hydra--universal-argument))))
      (set
       (defvar hydra-zoom/heads nil
         "Heads for hydra-zoom.")
       (quote
        (("r"
          (text-scale-set 0)
          "reset"
          :exit nil)
         ("0"
          (text-scale-set 0)
          ""
          :bind nil
          :exit t)
         ("1"
          (text-scale-set 0)
          nil
          :bind nil
          :exit nil))))
      (defun hydra-zoom/lambda-r nil
        "Create a hydra with no body and the heads:

\"r\":    `(text-scale-set 0)',
\"0\":    `(text-scale-set 0)',
\"1\":    `(text-scale-set 0)'

The body can be accessed via `hydra-zoom/body'.

Call the head: `(text-scale-set 0)'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore t))
          (hydra-keyboard-quit))
        (condition-case err
            (call-interactively
             (function
              (lambda nil
               (interactive)
               (text-scale-set 0))))
          ((quit error)
           (message "%S" err)
           (unless hydra-lv (sit-for 0.8))))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-zoom/hint))
            (message
             (eval hydra-zoom/hint))))
        (hydra-set-transient-map
         hydra-zoom/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil))
      (defun hydra-zoom/lambda-0-and-exit nil
        "Create a hydra with no body and the heads:

\"r\":    `(text-scale-set 0)',
\"0\":    `(text-scale-set 0)',
\"1\":    `(text-scale-set 0)'

The body can be accessed via `hydra-zoom/body'.

Call the head: `(text-scale-set 0)'."
        (interactive)
        (hydra-default-pre)
        (hydra-keyboard-quit)
        (call-interactively
         (function
          (lambda nil
           (interactive)
           (text-scale-set 0)))))
      (set
       (defvar hydra-zoom/hint nil
         "Dynamic hint for hydra-zoom.")
       (quote
        (format
         #("zoom: [r 0]: reset."
           7 8 (face hydra-face-red)
           9 10 (face hydra-face-blue)))))
      (defun hydra-zoom/body nil
        "Create a hydra with no body and the heads:

\"r\":    `(text-scale-set 0)',
\"0\":    `(text-scale-set 0)',
\"1\":    `(text-scale-set 0)'

The body can be accessed via `hydra-zoom/body'."
        (interactive)
        (hydra-default-pre)
        (let ((hydra--ignore nil))
          (hydra-keyboard-quit))
        (when hydra-is-helpful
          (if hydra-lv
              (lv-message
               (eval hydra-zoom/hint))
            (message
             (eval hydra-zoom/hint))))
        (hydra-set-transient-map
         hydra-zoom/keymap
         (lambda nil
           (hydra-keyboard-quit)
           nil)
         nil)
        (setq prefix-arg
              current-prefix-arg))))))

(ert-deftest defhydradio ()
  (should (equal
           (macroexpand
            '(defhydradio hydra-test ()
              (num "Num" [0 1 2 3 4 5 6 7 8 9 10])
              (str "Str" ["foo" "bar" "baz"])))
           '(progn
             (defvar hydra-test/num 0
               "Num")
             (put 'hydra-test/num 'range [0 1 2 3 4 5 6 7 8 9 10])
             (defun hydra-test/num ()
               (hydra--cycle-radio 'hydra-test/num))
             (defvar hydra-test/str "foo"
               "Str")
             (put 'hydra-test/str 'range ["foo" "bar" "baz"])
             (defun hydra-test/str ()
               (hydra--cycle-radio 'hydra-test/str))
             (defvar hydra-test/names '(hydra-test/num hydra-test/str))))))

(ert-deftest hydra-blue-compat ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-toggle (:color blue)
       "toggle"
       ("t" toggle-truncate-lines "truncate")
       ("f" auto-fill-mode "fill")
       ("a" abbrev-mode "abbrev")
       ("q" nil "cancel")))
    (macroexpand
     '(defhydra hydra-toggle (:exit t)
       "toggle"
       ("t" toggle-truncate-lines "truncate")
       ("f" auto-fill-mode "fill")
       ("a" abbrev-mode "abbrev")
       ("q" nil "cancel"))))))

(ert-deftest hydra-amaranth-compat ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-vi
       (:pre
        (set-cursor-color "#e52b50")
        :post
        (set-cursor-color "#ffffff")
        :color amaranth)
       "vi"
       ("j" next-line)
       ("k" previous-line)
       ("q" nil "quit")))
    (macroexpand
     '(defhydra hydra-vi
       (:pre
        (set-cursor-color "#e52b50")
        :post
        (set-cursor-color "#ffffff")
        :foreign-keys warn)
       "vi"
       ("j" next-line)
       ("k" previous-line)
       ("q" nil "quit"))))))

(ert-deftest hydra-pink-compat ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-zoom (global-map "<f2>"
                            :color pink)
       "zoom"
       ("g" text-scale-increase "in")
       ("l" text-scale-decrease "out")
       ("q" nil "quit")))
    (macroexpand
     '(defhydra hydra-zoom (global-map "<f2>"
                            :foreign-keys run)
       "zoom"
       ("g" text-scale-increase "in")
       ("l" text-scale-decrease "out")
       ("q" nil "quit"))))))

(ert-deftest hydra-teal-compat ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-zoom (global-map "<f2>"
                            :color teal)
       "zoom"
       ("g" text-scale-increase "in")
       ("l" text-scale-decrease "out")
       ("q" nil "quit")))
    (macroexpand
     '(defhydra hydra-zoom (global-map "<f2>"
                            :foreign-keys warn
                            :exit t)
       "zoom"
       ("g" text-scale-increase "in")
       ("l" text-scale-decrease "out")
       ("q" nil "quit"))))))

(ert-deftest hydra-format-1 ()
  (should (equal
           (let ((hydra-fontify-head-function
                  'hydra-fontify-head-greyscale))
             (hydra--format
              'hydra-toggle
              nil
              "
_a_ abbrev-mode:       %`abbrev-mode
_d_ debug-on-error:    %`debug-on-error
_f_ auto-fill-mode:    %`auto-fill-function
" '(("a" abbrev-mode nil)
    ("d" toggle-debug-on-error nil)
    ("f" auto-fill-mode nil)
    ("g" golden-ratio-mode nil)
    ("t" toggle-truncate-lines nil)
    ("w" whitespace-mode nil)
    ("q" nil "quit"))))
           '(concat (format "%s abbrev-mode:       %S
%s debug-on-error:    %S
%s auto-fill-mode:    %S
" "{a}" abbrev-mode "{d}" debug-on-error "{f}" auto-fill-function) "[{q}]: quit"))))

(ert-deftest hydra-format-2 ()
  (should (equal
           (let ((hydra-fontify-head-function
                  'hydra-fontify-head-greyscale))
             (hydra--format
              'bar
              nil
              "\n  bar %s`foo\n"
              '(("a" (quote t) "" :cmd-name bar/lambda-a :exit nil)
                ("q" nil "" :cmd-name bar/nil :exit t))))
           '(concat (format "  bar %s\n" foo) "{a}, [q]"))))

(ert-deftest hydra-format-3 ()
  (should (equal
           (let ((hydra-fontify-head-function
                  'hydra-fontify-head-greyscale))
             (hydra--format
              'bar
              nil
              "\n_<SPC>_   ^^ace jump\n"
              '(("<SPC>" ace-jump-char-mode nil :cmd-name bar/ace-jump-char-mode))))
           '(concat (format "%s   ace jump\n" "{<SPC>}") ""))))

(ert-deftest hydra-format-4 ()
  (should
   (equal (hydra--format
           nil
           '(nil nil :hint nil)
           "\n_j_,_k_"
           '(("j" nil) ("k" nil)))
          '(concat (format "%s,%s"
                    #("j" 0 1 (face hydra-face-blue))
                    #("k" 0 1 (face hydra-face-blue))) ""))))

(ert-deftest hydra-format-with-sexp-1 ()
  (should (equal
           (let ((hydra-fontify-head-function
                  'hydra-fontify-head-greyscale))
             (hydra--format
              'hydra-toggle nil
              "\n_n_ narrow-or-widen-dwim %(progn (message \"checking\")(buffer-narrowed-p))asdf\n"
              '(("n" narrow-to-region nil) ("q" nil "cancel" :exit t))))
           '(concat (format "%s narrow-or-widen-dwim %Sasdf\n"
                     "{n}"
                     (progn
                       (message "checking")
                       (buffer-narrowed-p)))
             "[[q]]: cancel"))))

(ert-deftest hydra-format-with-sexp-2 ()
  (should (equal
           (let ((hydra-fontify-head-function
                  'hydra-fontify-head-greyscale))
             (hydra--format
              'hydra-toggle nil
              "\n_n_ narrow-or-widen-dwim %s(progn (message \"checking\")(buffer-narrowed-p))asdf\n"
              '(("n" narrow-to-region nil) ("q" nil "cancel" :exit t))))
           '(concat (format "%s narrow-or-widen-dwim %sasdf\n"
                     "{n}"
                     (progn
                       (message "checking")
                       (buffer-narrowed-p)))
             "[[q]]: cancel"))))

(ert-deftest hydra-compat-colors-2 ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-test (:color amaranth)
       ("a" fun-a)
       ("b" fun-b :color blue)
       ("c" fun-c :color blue)
       ("d" fun-d :color blue)
       ("e" fun-e :color blue)
       ("f" fun-f :color blue)))
    (macroexpand
     '(defhydra hydra-test (:color teal)
       ("a" fun-a :color red)
       ("b" fun-b)
       ("c" fun-c)
       ("d" fun-d)
       ("e" fun-e)
       ("f" fun-f))))))

(ert-deftest hydra-compat-colors-3 ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-test ()
       ("a" fun-a)
       ("b" fun-b :color blue)
       ("c" fun-c :color blue)
       ("d" fun-d :color blue)
       ("e" fun-e :color blue)
       ("f" fun-f :color blue)))
    (macroexpand
     '(defhydra hydra-test (:color blue)
       ("a" fun-a :color red)
       ("b" fun-b)
       ("c" fun-c)
       ("d" fun-d)
       ("e" fun-e)
       ("f" fun-f))))))

(ert-deftest hydra-compat-colors-4 ()
  (should
   (equal
    (macroexpand
     '(defhydra hydra-test ()
       ("a" fun-a)
       ("b" fun-b :exit t)
       ("c" fun-c :exit t)
       ("d" fun-d :exit t)
       ("e" fun-e :exit t)
       ("f" fun-f :exit t)))
    (macroexpand
     '(defhydra hydra-test (:exit t)
       ("a" fun-a :exit nil)
       ("b" fun-b)
       ("c" fun-c)
       ("d" fun-d)
       ("e" fun-e)
       ("f" fun-f))))))

(ert-deftest hydra--pad ()
  (should (equal (hydra--pad '(a b c) 3)
                 '(a b c)))
  (should (equal (hydra--pad '(a) 3)
                 '(a nil nil))))

(ert-deftest hydra--matrix ()
  (should (equal (hydra--matrix '(a b c) 2 2)
                 '((a b) (c nil))))
  (should (equal (hydra--matrix '(a b c d e f g h i) 4 3)
                 '((a b c d) (e f g h) (i nil nil nil)))))

(ert-deftest hydra--cell ()
  (should (equal (hydra--cell "% -75s %%`%s" '(hydra-lv hydra-verbose))
                 "When non-nil, `lv-message' (not `message') will be used to display hints.   %`hydra-lv^^^^^
When non-nil, hydra will issue some non essential style warnings.           %`hydra-verbose")))

(ert-deftest hydra--vconcat ()
  (should (equal (hydra--vconcat '("abc\ndef" "012\n34" "def\nabc"))
                 "abc012def\ndef34abc")))

(defhydradio hydra-tng ()
  (picard "_p_ Captain Jean Luc Picard:")
  (riker "_r_ Commander William Riker:")
  (data "_d_ Lieutenant Commander Data:")
  (worf "_w_ Worf:")
  (la-forge "_f_ Geordi La Forge:")
  (troi "_t_ Deanna Troi:")
  (dr-crusher "_c_ Doctor Beverly Crusher:")
  (phaser "_h_ Set phasers to " [stun kill]))

(ert-deftest hydra--table ()
  (let ((hydra-cell-format "% -30s %% -8`%s"))
    (should (equal (hydra--table hydra-tng/names 5 2)
                   (substring "
_p_ Captain Jean Luc Picard:   % -8`hydra-tng/picard^^    _t_ Deanna Troi:               % -8`hydra-tng/troi^^^^^^
_r_ Commander William Riker:   % -8`hydra-tng/riker^^^    _c_ Doctor Beverly Crusher:    % -8`hydra-tng/dr-crusher
_d_ Lieutenant Commander Data: % -8`hydra-tng/data^^^^    _h_ Set phasers to             % -8`hydra-tng/phaser^^^^
_w_ Worf:                      % -8`hydra-tng/worf^^^^
_f_ Geordi La Forge:           % -8`hydra-tng/la-forge" 1)))
    (should (equal (hydra--table hydra-tng/names 4 3)
                   (substring "
_p_ Captain Jean Luc Picard:   % -8`hydra-tng/picard    _f_ Geordi La Forge:           % -8`hydra-tng/la-forge^^
_r_ Commander William Riker:   % -8`hydra-tng/riker^    _t_ Deanna Troi:               % -8`hydra-tng/troi^^^^^^
_d_ Lieutenant Commander Data: % -8`hydra-tng/data^^    _c_ Doctor Beverly Crusher:    % -8`hydra-tng/dr-crusher
_w_ Worf:                      % -8`hydra-tng/worf^^    _h_ Set phasers to             % -8`hydra-tng/phaser^^^^" 1)))))

(ert-deftest hydra--make-funcall ()
  (should (equal (let ((body-pre 'foo))
                   (hydra--make-funcall body-pre)
                   body-pre)
                 '(funcall (function foo)))))

(defhydra hydra-simple-1 (global-map "C-c")
  ("a" (insert "j"))
  ("b" (insert "k"))
  ("q" nil))

(defhydra hydra-simple-2 (global-map "C-c" :color amaranth)
  ("c" self-insert-command)
  ("d" self-insert-command)
  ("q" nil))

(defhydra hydra-simple-3 (global-map "C-c")
  ("g" goto-line)
  ("1" find-file)
  ("q" nil))

(defmacro hydra-with (in &rest body)
  `(let ((temp-buffer (generate-new-buffer " *temp*")))
     (save-window-excursion
       (unwind-protect
            (progn
              (switch-to-buffer temp-buffer)
              (transient-mark-mode 1)
              (insert ,in)
              (goto-char (point-min))
              (when (search-forward "~" nil t)
                (backward-delete-char 1)
                (set-mark (point)))
              (goto-char (point-max))
              (search-backward "|")
              (delete-char 1)
              (setq current-prefix-arg)
              ,@body
              (insert "|")
              (when (region-active-p)
                (exchange-point-and-mark)
                (insert "~"))
              (buffer-substring-no-properties
               (point-min)
               (point-max)))
         (and (buffer-name temp-buffer)
              (kill-buffer temp-buffer))))))

(ert-deftest hydra-integration-1 ()
  (should (string= (hydra-with "|"
                               (execute-kbd-macro
                                (kbd "C-c aabbaaqaabbaa")))
                   "jjkkjjaabbaa|"))
  (should (string= (hydra-with "|"
                               (condition-case nil
                                   (execute-kbd-macro
                                    (kbd "C-c aabb C-g"))
                                 (quit nil))
                               (execute-kbd-macro "aaqaabbaa"))
                   "jjkkaaqaabbaa|")))

(ert-deftest hydra-integration-2 ()
  (should (string= (hydra-with "|"
                               (execute-kbd-macro
                                (kbd "C-c c 1 c 2 d 4 c q")))
                   "ccddcccc|"))
  (should (string= (hydra-with "|"
                               (execute-kbd-macro
                                (kbd "C-c c 1 c C-u d C-u 10 c q")))
                   "ccddddcccccccccc|")))

(ert-deftest hydra-integration-3 ()
  (should (string= (hydra-with "foo\nbar|"
                               (execute-kbd-macro
                                (kbd "C-c g 1 RET q")))
                   "|foo\nbar")))

(provide 'hydra-test)

;;; hydra-test.el ends here
