;/**
; * st-ces.scm
; *
; *  Copyright 2020 by Christian Egon Sørensen <ces@meber.fsf.org>
; *
; * This file is part of st-ces.
; *
; * st-ces is free software: you can redistribute
; * it and/or modify it under the terms of the GNU General Public
; * License as published by the Free Software Foundation, either
; * version 3 of the License, or (at your option) any later version.
; *
; * st-ces is distributed in the hope that it will
; * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
; * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; * GNU General Public License for more details.
; *
; * You should have received a copy of the GNU General Public License
; * along with st-ces.  If not, see <http://www.gnu.org/licenses/>.
; *
; * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
; */

(define-module (st-ces)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gtk))

(define-public st-ces
	(package
	  (name "st-ces")
	  (version "0.1")
	  (source
	    (origin
	      (method git-fetch)
	      (uri (git-reference
		     (url "https://github.com/chregon2001/st")
		     (commit "d3a8355f09d05b12f48c42f1ed8acaa8729a1d6e")))
	      (file-name (git-file-name "st-ces" version))
	      (sha256
		(base32
		  "0rwsnkfpa716kfr0jaafay8dhjm3jkn53ijd7sr8l93hixh04ymf"))))
	  (build-system glib-or-gtk-build-system)
	  (outputs '("out"))
	  (arguments
       		`(#:tests? #f                      ; no tests

		  #:make-flags (list (string-append "PREFIX=" (assoc-ref %outputs "out"))
                   "CC=gcc")
		  #:phases (modify-phases %standard-phases
                               (add-after 'unpack 'sethome
                                          (lambda _ (setenv "HOME" "/tmp") #t))
                               
					  (delete 'configure)
                      (delete 'build)
					  (delete 'check)
					  )))
	  (inputs 
	    `(
	      ("pkg-config" ,pkg-config)
	      ("ncurses" ,ncurses)
	      ("libxext" ,libxext)
	      ("dmenu" ,dmenu)
	      ("harfbuzz" ,harfbuzz)
	      ("freetype" ,freetype)
	      ("fontconfig" ,fontconfig)
	      ("gtk+" ,gtk+)
     ("libx11" ,libx11)
       ("libxft" ,libxft)

	      ))
	  ;;(inputs
	  ;;  `(("ghc-x11" ,ghc-x11) ("ghc-random" ,ghc-random)))
	  (home-page
	    "https://github.com/chregon2001/st")
	  (synopsis "A less sucky terminal")
	  (description "A less sucky temrinal, st, forked from luke's fork of st.")
	  (license license:gpl3))) 
