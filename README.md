Renv-rbundler-R-version
=======================

Plugin for [Renv](https://github.com/viking/Renv) to use a R version in DESCRIPTION file for the standard R packages and [rbundler](https://github.com/yoni/rbundler). If a custom R version is not already set locally per-directory (like in `.R-version`), this looks for a R version in the current tree's DESCRIPTION and uses that version.

Requirements: Renv 0.3.1 or higher

[![Build Status](https://travis-ci.org/shka/Renv-rbundler-R-version.png?branch=master)](https://travis-ci.org/shka/Renv-rbundler-R-version)

Installation
------------
* Check the plugin out into your Renv plugins directory:

  ```sh
  git clone https://github.com/shka/Renv-rbundler-R-version.git \
      "$(Renv root)"/plugins/Renv-rbundler-R-version
  ```

* That's it! Now `R` and your other Renv shims should automatically find the correct R version.

Caveats
-------
The logic currently used to find the version is simplistic; Renv-rbundler-R-version supports:
* simple `R (>= 3.5.1)`
* comments at the end of line (just strips them)

The parsing is done with regular expressions, i.e. no R evaluation is done.  So expressions and conditionals are NOT handled and anything else is not handled.
