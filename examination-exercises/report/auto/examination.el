(TeX-add-style-hook
 "examination"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "twocolumn")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "ex1"
    "article"
    "art10"
    "inputenc"
    "amsmath"
    "amsthm"
    "amssymb"
    "subcaption"
    "graphicx"
    "diagbox"
    "listings"
    "color")
   (TeX-add-symbols
    "listingsfont"
    "listingsfontinline")))

