# Installation

## MacOS

Install Homebrew (command-line tool to install software):

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

This may take some time, especially if it has to (automatically, as needed) install the Xcode command-line tools like gcc or clang to locally compile binaries).

At the end of the installation, you may be asked to run some additional commands to complete the installation of Homebrew and add it to the PATH. At time of writing, these commands were these, but please copy-paste them from the end of the installation log:

    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"


With Homebrew, install Node, which is a JavaScript execution environment in which the Bebras toolset was developed.

    brew install node

Node comes with a tool called npx, which can be used to run Node-based tools. It will download the dependencies as needed. Try this:

    npx bebras 

The first time, it will download the Bebras toolset used for Markdown files and show some info. All following times, it should be much quicker because no download will be needed. This will be used to convert the Markdown files.

Then, install LibreOffice, which will be used to convert the ODT files:

    brew install libreoffice

Even if you have it already, this may be needed to make sure the command-line tools that ship with it are on the PATH. And, it will update it to the latest version, which is always good. Do `sudo rm -rf /Applications/LibreOffice.app` if you need to remove the currently installed version prior to the brew installation.

Then, install wkhtmltopdf, to convert HTML files:

    brew install wkhtmltopdf

Finally, install pdftk, which is used to concatenate PDFs:

    brew install pdftk-java

You should now be all set to use the main script.

Warning: the main script should be called from the terminal in the folder which contains folders which contains tasks folders, which themselves contain task files. For instance, if some path to a task file is `/Users/userid/bebras/tasks/2024/2024-BE-01_Name/2024-BE-01-eng.md`, then the script has to be run from the folder `/Users/userid/bebras/tasks`.


## Other platforms

Not tested (by jpp at least) yet. Feel free to complete this section.
 