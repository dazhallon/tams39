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
    "sec:exercise-2"
    "sec:a-1"
    "fig:ex2-scatter"
    "sec:b-1"
    "eq:boxcorrection"
    "sec:c-1"
    "sec:e"
    "eq:ex2-conf-region"
    "fig:ex2fig"
    "fig:ex2_sim_intervals"
    "sec:f")
   (LaTeX-add-bibliographies
    "ref")))

