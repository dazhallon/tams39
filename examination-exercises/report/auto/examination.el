(TeX-add-style-hook
 "examination"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "twocolumn")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "ex1"
    "ex2"
    "ex3"
    "ex4"
    "report"
    "rep10"
    "inputenc"
    "amsmath"
    "amsthm"
    "amssymb"
    "subcaption"
    "graphicx"
    "diagbox"
    "biblatex"
    "listings"
    "color")
   (TeX-add-symbols
    "listingsfont"
    "listingsfontinline")
   (LaTeX-add-bibliographies
    "ref")))

