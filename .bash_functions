#! /bin/bash

. ~/.bash_constants

# Unicode printing
ucat() {
  [[ -n "$1" ]] || { echo "Usage: ucat [file]"; return; }
  native2ascii -encoding UTF-8 -reverse $1
}

uconv() {
  [[ -n "$1" ]] || { echo "Usage: uconv [file]"; return; }
  iconv -f euc-kr -t UTF-8 $1 >> tmp.txt
  mv tmp.txt $1
  echo "Converted $1"
}

uconvs() {
  [[ -n "$1" ]] || { echo "Usage: uconvs [some extension]"; return; }
  for file in *.$1
  do
      iconv -f euckr -t utf8 "$file" | sponge "$file"
      echo "Converted $file"
  done
}

uhead() {
  [[ -n "$1" ]] || { echo "Usage: uhead [file]"; return; }
  head $1 | native2ascii -encoding UTF-8 -reverse
}

uless() {
  [[ -n "$1" ]] || { echo "Usage: umore [file]"; return; }
  cat $1 | native2ascii -encoding UTF-8 -reverse | less
}

recent() {
    fn=`ls -t | head -n1`;
    vi "$fn";
}

# File conversion
rmd2html() {
    [[ -n "$1" ]] || { echo "Usage: rmd2html [file]"; return; }

    tmp=`mktemp /tmp/XXXXXX.md`
    rscript -e "library(knitr); knit('$1', '$tmp');" > /tmp/null

    #TODO: Get optional parameter for css file
    html="${1%.*}.html"
    echo "create $html"
    if [ -f "css/custom-bootstrap.css" ]; then
        echo "include custom-bootstrap.css"
        pandoc $tmp -o $html -c css/custom-bootstrap.css
    else
        pandoc $tmp -o $html
    fi

    echo "cleaning up..."
    rm -f $tmp
    echo "done"
    open $html
}

# Hacker's diary
diary() {
    [[ -n "$1" ]] || { echo "Usage: diary [title]"; return; }

    dir=$DIARY_DIR
    #TODO: filename - transliterate hangul to roman letters
    strip=${1//-/}
    merge=${strip// /-}
    clean=${merge//[^a-zA-Z0-9\-]/}
    lower="$(echo $clean | tr '[:upper:]' '[:lower:]')"
    short="${lower:0:30}"
    final=${short//-./.}
    fname=$dir/$(date "+%Y-%m-%d")-$final.md
    echo $fname

    temp[0]="'''"
    temp[1]="layout: diary"
    temp[2]="title: $1"
    temp[3]="date: $(date '+%Y-%m-%d %H:%M')"
    temp[4]="comments: false"
    temp[5]="categories: []"
    temp[6]="original: null"
    temp[7]="'''"

    printf "%s\n" "${temp[@]}" > $fname
    vi $fname
}

meeting() {
    [[ -n "$1" ]] || { echo "Usage: meeting [title]"; return; }

    dir=$MEETING_DIR
    strip=${1//-/}
    merge=${strip// /-}
    clean=${merge//[^a-zA-Z0-9\-]/}
    lower="$(echo $clean | tr '[:upper:]' '[:lower:]')"
    short="${lower:0:30}"
    final=${short//-./.}
    fname=$dir/$(date "+%Y-%m-%d")-$final.md
    echo $fname

    temp[0]="---"
    temp[1]="layout: meeting"
    temp[2]="title: \"$1\""
    temp[3]="date: $(date '+%Y-%m-%d %H:%M')"
    temp[4]="comments: false"
    temp[5]="categories: []"
    temp[6]="original: null"
    temp[7]="---"

    printf "%s\n" "${temp[@]}" > $fname
    vi $fname
}

# Compile TeX and open pdf
ctex() {
    [[ -n "$1" ]] || { echo "Usage: ctex [somefile].tex"; return; }
    pdflatex -shell-escape $1
    bibtex ${1/.tex}.aux
    pdflatex $1
    pdflatex $1
    open ${1/.tex}.pdf
}

remark() {
    cp -r ~/skel/remark/* .
}

research() {
    dir=$RESEARCH_DIR
    fname=$dir/$(date "+%Y-%m-%d").md
    echo $fname
    vi $fname
}

mmd2html() {
    [[ -n "$1" ]] || { echo "Usage: mmd2html [input.md] [output.html]"; return; }
    python -c "from lutils import conv; conv.md2html(\"$1\", \"$2\")"
    echo "Done."
}
