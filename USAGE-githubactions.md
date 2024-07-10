# Usage with Github Actions

## Details

The main script for this usage, `create-all-tasks.sh`, processes *all top level folders* in this repository independently.

Each top level folder is assumed to contain a set of task (sub)folders with names that conform to a
strict pattern (see below). The script then produces a PDF file `all-tasks.pdf` in that top level folder.
(Top level folders that already contain a file `all-tasks.pdf` are not processed.)

Task folders must follow the Bebras task folder naming conventions: 'year dash country dash number dash underscore title',
(i.e., 'Bebras-id underscore title'),
e.g. `2024-BE-01a_Castles`, `2025-UK-17_Vote_later`. Within that task folder the script
will process all files whose names start with the Bebras ID of that
folder and end in `.odt` or `.html`, e.g., `2024-BE-01a-eng.html` 
but also `2024-UK-17_version1.odt`.

The tasks in the resulting file will be sorted by task folder name.

## First time setup

(**Important** You need an account on *github.com*. See [Creating an account on Github](https://docs.github.com/en/get-started/start-your-journey/creating-an-account-on-github). )

Make a (private) fork of this repository on *github.com*: 
* Go to `https://github.com/kcoolsae/AllTasksPDF`
* Click on *Fork* in the top right corner
* Sign in if necessary
* Fill in the required fields
* Click on *Create fork*

Use the forked repository in what follows.

Ensure *Github Actions* have write access to the forked repository:
* Go to the forked repository on *github.com*
* Click on *Settings* in the top menu
* Open *Actions* on the left and select *general*
* On the right, under the heading *Workflow permissions*, select *Read and write permissions*
* Press the *Save* button at the bottom of that section
* (Verify that at the top of the page 'Disable actions' is *not* checked. Use the top option if in doubt.)

## Usage

Commit and push the tasks to a new top level folder in your repository.

Run the action
* Go to your (forked) repository on *github.com*
* Click on *Actions* in the top menu (should be next to *Pull requests* )
* Click on *Create all-tasks.pdf* in the left column
* Open the *Run workflow* dropdown (on the right hand side of a notice with blue background)
* Click the *Run workflow* button
* Wait and be patient, a row will appear in the list of workflows that indicates that the script is running
* Hopefully after some time you get a green checkmark. If not, error messages can be found by clicking on that row

If all went well, the top level folder will now contain the file `all-tasks.pdf` which you can view on *github.com* or pull into your local
clone of the repository.

To rerun the action on the same folder, e.g., when some tasks were changed or added, first remove
the file `all-tasks.pdf` from that folder and run the action again as described above.

## Notes
The script probably does not handle exceptional situations very well. Hence
* Do not use folder or file names that contain spaces
* Avoid folders without task folders
* Use only one ODT and/or HTML file per task folder
