;;; rrepl.el --- Remote REPL for Emacs LISP

;; Copyright (C) 2012 Takafumi Arakaki

;; Author: Takafumi Arakaki <aka.tkf at gmail.com>

;; This file is NOT part of GNU Emacs.

;; rrepl.el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; rrepl.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with rrepl.el.
;; If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'cl)
(require 'epcs)

(defun rrepl-eval-string (string)
  (eval (read string)))

(defvar rrepl-process nil)

;;;###autoload
(defun rrepl-server-start (port)
  (interactive
   (list (string-to-number
          (read-string "Start remote REPL server at port: "))))
  (unless rrepl-process
    (setq rrepl-process
          (epcs:server-start
           (lambda (mngr)
             (lexical-let ((mngr mngr))
               (epc:define-method mngr 'eval 'rrepl-eval-string)))
           port))
    (set-process-query-on-exit-flag rrepl-process nil)))

(provide 'rrepl)

;;; rrepl.el ends here
