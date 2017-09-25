(TeX-add-style-hook
 "_region_"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "twocolumn")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
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

