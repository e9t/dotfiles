# Unicode printing
ucat() {
  [[ -n "$1" ]] || { echo "Usage: ucat [file]"; return; }
  native2ascii -encoding UTF-8 -reverse $1
}

uhead() {
  [[ -n "$1" ]] || { echo "Usage: uhead [file]"; return; }
  head $1 | native2ascii -encoding UTF-8 -reverse
}

# File conversion

rmd2html() {
    [[ -n "$1" ]] || { echo "Usage: rmd2html [file]"; return; }

    tmp=`mktemp /tmp/XXXXXX.md`
    rscript -e "library(knitr); knit('$1', '$tmp');" > /tmp/null

    #TODO: Get optional parameter for css file
    html="${1%.*}.html"
    echo "create $html"
    if [ ! -d "css" ]; then
        echo "include custom-bootstrap.css"
        ln -s ~/dev/pkgs/css/custom-bootstrap/ css
        pandoc $tmp -o $html -c css/bootstrap.css
    else
        pandoc $tmp -o $html
    fi

    echo "cleaning up..."
    rm -f $tmp
    echo "done"
}
