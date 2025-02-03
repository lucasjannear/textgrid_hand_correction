# Author: Lucas Annear
# This script facilitates working with a long speech file by
# keeping a save button visible to quickly save a file to the same file
# location.

# The script takes the path containing the textgrid/wav file pair as input
# and then allows the user to adjust boundaries as needed and save progress
# as desired while keeping the file open.

## Directions:
# 	click "run" in this script window and then copy
# 	the complete file path for the textgrid you want to correct
#	into the file path field and delete any quotation marks
#	around the file path. Then click "OK" to open the file
#	and work on it.

call start

procedure start

	#get the path
	form Correct Textgrids
		comment paste file path:
		sentence file_path 
	endform

	call open_file

endproc

	
procedure open_file

	
	textGridName$ = "'file_path$'"

	# file name minus extension
	fileName$ = "'file_path$'" - ".TextGrid"

	# open file
	if fileReadable (textGridName$)
		Read from file... 'fileName$'.wav
		Read from file... 'fileName$'.TextGrid

		objName$ = selected$ ("TextGrid")
		plus Sound 'objName$'
		Edit
		editor TextGrid 'objName$'

		repeat

			beginPause: "How do things look?"
				comment: "Adjust boundaries as necessary"
			clicked = endPause: "Save file", "Exit and save file", 1
			if clicked = 2
				call save_TextGrid
				Close
				endeditor
				select TextGrid 'objName$'
				plus Sound 'objName$'
				Remove
				exitScript ()
			else
				call save_TextGrid
			endif
		
		until clicked = 2

	else
	endif

endproc

##########
## Sub Procedures
##########

procedure save_TextGrid

	Save whole TextGrid as text file... 'fileName$'.TextGrid

endproc

##########
