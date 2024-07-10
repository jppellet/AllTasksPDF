# Local Usage

The main script for this usage is directly the `toPDF.sh` script (`create-all-tasks.sh` can also be used locally but is typically used for GitHub Actions and calls `toPDF.sh` anyway).

`toPDF.sh` has to be run in a folder which contain tasks folders, goes through all of them, and produces a PDF file `all-tasks[-lang].pdf` in the containing folder.

## Details

First, install the requirements according to [Installation](#installation). Then, `cd` to the directory containing the tasks folders and run `toPDF.sh`:

    cd /path/to/tasks
    /path/to/AllTasksPDF/toPDF.sh

Alternatively, the containing folder of `toPDF.sh` can be added to the PATH in `.zprofile` or `.bash_profile`:

    export PATH=$PATH:/path/to/AllTasksPDF

Then, the script can be run from any directory without providing the full path:

    cd /path/to/tasks
    toPDF.sh

The script has the following options:

| Option                        | Description |
| ----------------------------- | ----------- |
|`-v` or `--verbose`            | Turns on verbose mode, which prints more information about the conversion process. |
|`-l <lang>` or `--lang <lang>` | Only converts task files with the language `<lang>` instead of everything that looks like a task file. They are identified based on their name, which must follow the pattern `0000-AA-00-<lang>.[odt\|html\|task.md]`. For instance, `2024-CH-01-deu.task.md` will be included when the script is run with the `--lang deu` options. Moreover, in that case, the produced output file also contains the language suffix, so will be in that case `all-tasks-deu.pdf`. |

If the conversion takes too long, `Ctrl-C` can be used to stop the script. The script will still produce a concatenated PDF with all the converted tasks up to that point.


## Installation

### MacOS

First, install Homebrew (command-line tool to install software). Homebrew per se is not strictly necessary to convert to PDF with this script, but it makes the installation of the other tools easier.

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

This may take some time, especially if it has to (automatically, as needed) install the Xcode command-line tools like gcc or clang to locally compile binaries).

At the end of the installation, you may be asked to run some additional commands to complete the installation of Homebrew and add it to the PATH. At time of writing, these commands were these, but please copy-paste them from the end of the installation log:

    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"


With Homebrew, install Node, which is a JavaScript execution environment for which the Bebras toolset was developed.

    brew install node

Node comes with a tool called `npx`, which can be used to run Node-based tools. It will download the dependencies as needed. Try this:

    npx bebras 

The first time, it will download the Bebras toolset used for Markdown files and show some info. All following times, it should be much quicker because no download will be needed. This will be used to convert the Markdown files.

Then, install LibreOffice, which will be used to convert the ODT files:

    brew install libreoffice

Even if you have it already, this may be needed to make sure the command-line tools that ship with it are on the PATH. And, it will update it to the latest version, which is always good. Do `sudo rm -rf /Applications/LibreOffice.app` if you need to remove the currently installed version prior to the brew installation.

Then, install `wkhtmltopdf`, used to convert HTML files:

    brew install wkhtmltopdf

Finally, install pdftk, which is used to concatenate PDFs:

    brew install pdftk-java

You should now be all set to use the main script.


### Other platforms

Not tested (by jpp at least) yet. Feel free to complete this section.
 