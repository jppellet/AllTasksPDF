#!/bin/bash
#
# Converts tasks to PDFS and concatenates them into one single file
# all-tasks.pdf
#
# Software needed on PATH:
# - LibreOffice  for ODT files (lowriter or soffice command)
# - wkhtmltopdf  for HTML files
# - bebras       for Markdown files (npm install -g bebras)
# - pdftk        for concatenating PDF files

# create temporary directory
OUTDIR="/tmp/out$$"
RESULT="all-tasks.pdf"
mkdir $OUTDIR
shopt -s nullglob  # allows for loops to run 0 times if no files match the pattern

if command -v bebras >/dev/null 2>&1
then
  BEBRAS=bebras
else
  BEBRAS="npx bebras"
fi


# convert individual files
for dir in 20??-*/
do
    BEBRAS_ID=${dir%%_*}
    # convert ALL odt files satisfying the correct pattern
    for ODTNAME in $dir$BEBRAS_ID*.odt
    do
	    echo converting $ODTNAME

      # check if lowriter exists as a command
      if command -v lowriter >/dev/null 2>&1
      then
	      lowriter --headless --convert-to pdf --outdir "$OUTDIR" "$ODTNAME" >/dev/null  2>&1
      else
        # else, use soffice, according to https://stackoverflow.com/questions/30349542/command-libreoffice-headless-convert-to-pdf-test-docx-outdir-pdf-is-not
        soffice --headless --convert-to pdf:writer_pdf_Export \
          "-env:UserInstallation=file:///tmp/LibreOffice_Conversion_${USER}" \
          --outdir "$OUTDIR" "$ODTNAME" >/dev/null 2>&1
      fi
		done

		# convert ALL html files satisfying the correct pattern
		for HTMLNAME in $dir$BEBRAS_ID*.html
		do
	    echo converting $HTMLNAME
	    wkhtmltopdf --enable-local-file-access "$HTMLNAME" "$OUTDIR/${HTMLNAME##*/}.pdf" >/dev/null 2>&1
    done

		# convert ALL md files satisfying the correct pattern
		for MDNAME in $dir$BEBRAS_ID*.md
		do
	    echo converting $MDNAME
      $BEBRAS convert -o "$OUTDIR/${MDNAME##*/}.pdf" pdf "$MDNAME" >/dev/null 2>&1
    done

done
shopt -u nullglob # turn off the nullglob option

# concatenate all pdfs into one
if [ -z "$(ls -A "$OUTDIR")" ]; then
  echo "**WARNING** No ODT or HTML task files found in folder ${PWD##*/} - creating empty PDF"
  touch "$RESULT"
else
  (cd $OUTDIR; pdftk *.pdf cat output $RESULT)
  rm -f "$RESULT"
  mv "$OUTDIR/$RESULT" .
  rm $OUTDIR/*.pdf
fi
rmdir "$OUTDIR"
