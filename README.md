Use `correct_textgrids_directory.praat` to correct multiple Praat textgrids within a directory.

This script works best with a directory containing many shorter, utterance-length files, but works well anytime you plan to correct multiple files in a directory within one sitting.
This script saves/overwrites TextGrid files within the same directory and eliminates manually saving files and the associated errors (saving in the wrong location, etc).

When "Exit and save progress" is clicked during correction, the script records the current file in a `lastFile.txt` document within the directory and uses this file to resume progress.
