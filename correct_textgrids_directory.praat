# Author: Lucas Annear
# This script facilitates modifying boundaries to multiple 
# Praat textgrids within a directory.

# Use this script to cycle through textgrid/wav file pairs in a folder.
# The script takes the path containing the file pairs as input upon running
# and then allows the user to adjust boundaries as needed and then hit continue to 
# save changes within the directory and move onto the file.

# Additionally, the script tracks progress through the file list and allows the user
# to "Exit and save progress", which creates a txt file containing the name of the
# last file that was completed. This allows the user to pick up progress at a later
# point by checking the "resuming progress" button.

call start

procedure start

	#get the path
	form Correct Textgrids
		comment paste directory:
		sentence dirName 
		comment Are you resuming progress? Check if yes
		boolean resuming_progress no
	endform

	if resuming_progress = 1
		#Get last file modified from lastFile.txt
		Read Strings from raw text file... 'dirName$'/lastFile.txt
		firstFile$ = Get string... 1
		toc = length(firstFile$)
		#deleteFile: "'dirName$'/lastFile.txt"

		#Now get list of files in directory and loop through them until
		#match with firstFile$ is identified
		Create Strings as file list... fileList 'dirName$'/*.TextGrid
		numberOfFiles = Get number of strings
		select Strings fileList
		fileNumb = 1
		repeat
			filNavn$ = Get string... fileNumb
			navn$ = "'filNavn$'" - ".TextGrid"
			newNumb = fileNumb
			fileNumb = fileNumb + 1
		until right$(navn$, toc) = firstFile$
		Extract part... newNumb numberOfFiles
		select Strings fileList
		plus Strings lastFile
		Remove
		select Strings fileList_part
		Rename... fileList
		call cycleThrough
	else
		Create Strings as file list... fileList 'dirName$'/*.TextGrid
		numberOfFiles = Get number of strings
		
		call cycleThrough
	
	endif

endproc

	
procedure cycleThrough

	#Procedure that allows boundaries to be changed and then saves TextGrid
	for thisFile from 1 to numberOfFiles
		select Strings fileList
		filename$ = Get string... thisFile
		name$ = "'filename$'" - ".TextGrid"
		textGridName$ = "'dirName$'/'name$'.TextGrid"
		if fileReadable (textGridName$)
			Read from file... 'dirName$'/'name$'.wav
			Read from file... 'dirName$'/'name$'.TextGrid

			writeFile: "'dirName$'/lastFile.txt", name$

			objName$ = selected$ ("TextGrid")
			plus Sound 'objName$'
			Edit
			editor TextGrid 'objName$'

			beginPause: "How do things look?"
				comment: "Adjust boundaries as necessary"
			clicked = endPause: "Continue", "Exit and Save Progress", 1
			if clicked = 2
				Close
				endeditor
				call save_TextGrid
				plus Sound 'objName$'
				plus Strings fileList
				Remove
				writeInfoLine: "Progress will resume with: ", name$
				writeFile: "'dirName$'/lastFile.txt", name$
				exitScript ()
			else
			endif

		Close
		endeditor

		call save_TextGrid
		plus Sound 'objName$'
		Remove
		
		else
		endif
	endfor

	#deleteFile: "'dirName$'/lastFile.txt"

	select Strings fileList
	Remove

endproc

##########
## Sub Procedures
##########

procedure save_TextGrid

	select TextGrid 'objName$'
	Save as text file... 'dirName$'/'name$'.TextGrid

endproc

##########
