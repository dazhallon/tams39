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
    "comment"
    "bm"
    "diagbox"
    "biblatex"
    "listings"
    "color")
   (TeX-add-symbols
    '("rank" 1)
    '("abs" 1)
    '("mean" 1)
    '("corr" 2)
    '("cov" 2)
    "tr"
    "diag"
    "listingsfont"
    "listingsfontinline")
   (LaTeX-add-labels
    "sec:exercise-4"
    "sec:a-3"
    "sec:b-3"
    "sec:c-3")
   (LaTeX-add-bibliographies
    "ref")))

