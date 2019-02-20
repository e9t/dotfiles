#! /bin/bash

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
    if [ -z "$1" ]
    then
        $1=".";
    fi
    fn=`ls -t $1 | head -n1`;
    vi "$1$fn";
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

md2tex() {
    [[ -n "$1" ]] || { echo "Usage: md2tex [file]"; return; }

    # TODO: replace {% img %} tags with raw latex

    pdf=${1/.markdown/.pdf}
    pandoc --latex-engine=xelatex --include-in-header=$HOME/.my.tex -t beamer $1 -o $pdf
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

# research notes
re() {
    dir=$RESEARCH_DIR
    fname=$dir/$(date "+%Y-%m-%d").md

    if [ ! -e "$fname" ]
    then
        temp[0]="---"
        temp[1]="layout: docs"
        temp[2]="title: \"$(date '+%Y-%m-%d (%a)')\""
        temp[3]="date: $(date '+%Y-%m-%d %H:%M')"
        temp[4]="comments: false"
        temp[5]="categories: []"
        temp[7]="---"
        printf "%s\n" "${temp[@]}" > $fname
    fi

    echo $fname
    vi $fname
}

mmd2html() {
    [[ -n "$1" ]] || { echo "Usage: mmd2html [input.md] [output.html]"; return; }
    python -c "from lutils import conv; conv.md2html(\"$1\", \"$2\")"
    echo "Done."
}

ipyremote() {
    pkill -f "ssh -N -n -X -L localhost:18888"
    ssh -N -n -X -L localhost:18888:localhost:18888 epark@merci &
}

update_terminal_cwd() {
    # Identify the directory using a "file:" scheme URL,
    # including the host name to disambiguate local vs.
    # remote connections. Percent-escape spaces.
    local SEARCH=' '
    local REPLACE='%20'
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
    printf '\e]7;%s\a' "$PWD_URL"
}

gp() {
    url=`git remote -v | head -n 1 | cut -f 2 | cut -d " " -f 1`
    echo $url
    if [[ $url == git* ]]
    then
        chrome `echo $url | sed -e 's/:/\//g;s/git@/http:\/\//'`
    else
        chrome $url
    fi
}

d() {
    [[ -n "$1" ]] || { echo "Usage: d [some name]"; return; }
    docs=$(find $WIKI_DIR -path "*$1*")
    cnt=$(echo $docs | wc -w)
    if [ $cnt -eq 1 ]; then
        vi $docs
    else
      for d in $docs; do
        echo $d
      done
    fi
}

readlinkf() {
    [[ -n "$1" ]] || { echo "Usage: readlinkf [filename]"; return; }
    echo $PWD/$1
}

zs() {
    [[ -n "$1" ]] || { echo "Usage: zs [words] [limit (default=10)]"; return; }
    zwords="$1"
    zlim=${2:-10}
    dbfile="$HOME/Library/Containers/com.mozkan.flashpdfsearch/Data/Library/Application Support/com.mozkan.flashpdfsearch/idb.sqlite"

    # get wordids
    where="ZWORD=\"${zwords/ /\" or ZWORD=\"}\""
    zwordids=$(sqlite3 "$dbfile" "select ZWORDID from ZWORDS where $where;")

    echo -e "COUNT\tPATH"

    # show filenames
    where=" ZINDEXITEM.ZWORDID=\"${zwordids/$'\n'/\" or ZINDEXITEM.ZWORDID=\"}\""
    sql="select count(*), ZDOCS.ZURL from ZINDEXITEM inner join ZDOCS on ZINDEXITEM.ZDOCNO = ZDOCS.ZDOCNO where $where group by ZINDEXITEM.ZDOCNO order by count(*) desc limit $zlim;"
    sqlite3 "$dbfile" "$sql" | awk -F "|" '{printf("%d\t\"%s\"\n"), $1, $2}'

    # show counts
    where="ZWORDID=\"${zwordids/$'\n'/\" or ZWORDID=\"}\""
    nfiles=`sqlite3 "$dbfile" "select count (distinct ZDOCNO) from ZINDEXITEM where $where;"`
    echo "Showing $zlim files from $nfiles"
}

notes() {
    # Source: https://medium.com/adorableio/simple-note-taking-with-fzf-and-vim-2a647a39cfa
    previous_file="$1"
    file_to_edit=`select_file $previous_file`

    if [ -n "$file_to_edit" ] ; then
        cd $STUDY_DIR
        file=$(echo "$file_to_edit" | cut -d ':' -f1)
        "$EDITOR" $file
        notes "$file_to_edit"
    fi
}

select_file() {
    given_file="$1"
    cd $STUDY_DIR
    grep -In --line-buffered --color=never -r "" --include "*.md" --include "*.markdown" * |\
    fzf --exact --delimiter=":" --preview="cat {1}" --preview-window=right:70%:wrap --height=100% --query="$given_file"
}

# sed -i '' 's/foo/bar/' file
# mkvirtualenv myenv --system-site-packages
