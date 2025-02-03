Use `correct_textgrids_directory.praat` to correct multiple Praat textgrids within a directory.

This script works best with a directory containing many shorter, utterance-length files, but works well anytime you plan to correct multiple files in a directory within one sitting.
This script saves/overwrites TextGrid files within the same directory and eliminates manually saving files and the associated errors (saving in the wrong location, etc).

When "Exit and save progress" is clicked during correction, the script records the current file in a `lastFile.txt` document within the directory and uses this file to resume progress.

`correct_textgrids_long_file.praat` - The primary purpose of this script is to encourage frequent saving when working on long speech files by providing a `Save file` button that is continuously available as long as the file is open. `Exit and save file` saves and closes the file.
