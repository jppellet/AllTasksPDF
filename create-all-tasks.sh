#!/bin/bash
#
# This script creates an all-tasks.pdf file in every top level folder of
# the passed folder (or current folder/repository) unless a file of that
# name already exists.
#

cmd_folder=$(dirname $0)
cmd_folder=$(cd $cmd_folder; pwd) # get absolute path

usage() {
    echo "Usage: $0 [-f|--force] [<target_folder>]"
    exit 1
}

force=false
verbose=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--force)
            force=true
            shift
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        --)
            # stop processing options
            shift
            break
            ;;

        *)
            if [[ $1 == -* ]]; then
                echo "Invalid option: $1"
                usage
            else
                break
            fi
            ;;
    esac
done

# if arg 1 is empty, use fallback value of "."
target_folder="${1:-.}"
target_folder=$(cd $target_folder; pwd)

# if verbose, print all remaining arguments
if [ "$verbose" == "true" ]; then
  echo "$(basename $0)"
  echo "  target_folder: '$target_folder'"
  echo "  force: $force"
  echo "  verbose: $verbose"
fi

cd "$target_folder"
for dir in */
do
  if [ -z "$(ls -A "$dir")" ]; then
    echo "Skipping empty folder $dir"
  elif [ -f ${dir}all-tasks.pdf ] && [ "$force" == "false" ]; then
    echo "${dir}all-tasks.pdf already exists - not created anew"
  else
    echo "Creating ${dir}all-tasks.pdf"
    (cd $dir; echo "Processing $dir"; "$cmd_folder/toPDF.sh")
  fi
done
