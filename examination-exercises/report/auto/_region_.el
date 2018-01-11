(TeX-add-style-hook
 "_region_"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "onecolumn")))
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
    "bm"
    "diagbox"
    "biblatex"
    "listings"
    "color")
   (TeX-add-symbols
    '("corr" 2)
    '("cov" 2)
    "tr"
    "listingsfont"
    "listingsfontinline")
   (LaTeX-add-labels
    "sec:exercise-10"
    "sec:a-6"
    "sec:b-9")
   (LaTeX-add-bibliographies
    "ref")))

