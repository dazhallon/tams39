(TeX-add-style-hook
 "examination"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "onecolumn")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "ex1"
    "ex2"
    "ex3"
    "ex4"
    "ex5"
    "ex6"
    "ex7"
    "ex8"
    "ex9"
    "ex10"
    "ex11"
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
   (LaTeX-add-bibliographies
    "ref")))

