--
--  EPAppDelegate.applescript
--  ExclusivePush
--
--  Created by Quintin Smith on 4/30/13.
--  Copyright (c) 2013 Quintin Smith. All rights reserved.
--

script EPAppDelegate
	property parent : class "NSObject"
	
	property filepath : ""
	property languageversion : 0
	
	on photoshop_(sender)
		log "Hello"
		tell application "Finder"
			set filepath to ((choose folder with prompt "Pick a project folder please.") as string) as alias
			set filepath to file 1 of filepath as alias as text
						
			
			#set filepath (folderpath of( last word of filepath & ".psd")) as string
			
			tell application "Adobe Photoshop CS5.1"
				open file filepath 
			end tell
		end tell
		tell application "Adobe Photoshop CS5.1"
			activate
			open file filepath as string
			close (every document whose name is (last word of filepath & ".psd"))
			open file (filepath & ".psd") as text
			
		end tell
		activate
		set enabled of sender to false
				
	end photoshop_
	
	on indesign_(sender)
		log "Hello"
			tell application "Adobe Photoshop CS5.1"
			
			activate
			set docRef to current document
			log "docRef name"
				set myOptions to {class: Photoshop save options, embed color profile: true, save layers: true}
			save current document in file filepath as Photoshop format with options myOptions appending no extension without copying
				
				#save file docRef as string (last word of filepath & ".psd")
			log "2"
				set myoptions to {class:TIFF save options, embed color profile:true, image compression:none, save layers:false, save spot colors:true}
			save current document in file filepath as TIFF with options myoptions
			close current document #(last word of filepath & ".psd")
			tell application "Finder"
				(*if exists file (filepath & "_1_S.indd") then
					log filepath
					set languageversion to 1
					else if exists file (filepath & "_1_F.indd") then
					set languageversion to 2
					else
					display dialog "Fail to track language version, please contact Zhen Wang at ext 38204"
				end if*)
			end tell
			tell application "Adobe InDesign CS5"
				activate
				set psdname to (last word of filepath & ".tif")
				if languageversion = 1 then
					set currentindesigndoc to open file (filepath & "_1_S.indd")
					tell currentindesigndoc
						set linkname to (name of every link)
						set linklistsize to length of linkname
						set tiflink to null
						repeat with i from 1 to linklistsize
							if (item i of linkname is equal to psdname) then
								set tiflink to i
							end if
						end repeat
						update link tiflink
						unlink link tiflink
					end tell
					else if languageversion = 2 then
					set currentindesigndoc to open file (filepath & "_1_F.indd")
					tell currentindesigndoc
						set linkname to name of every link
						set linklistsize to length of linkname
						set tiflink to null
						repeat with i from 1 to linklistsize
							if (item i of linkname is equal to psdname) then
								set tiflink to i
							end if
						end repeat
						update link tiflink
						unlink link tiflink
					end tell
				end if
				set currentindesigndoc to open file (filepath & "_1_E.indd")
				tell currentindesigndoc
					set linkname to name of every link
					set linklistsize to length of linkname
					set tiflink to null
					repeat with i from 1 to linklistsize
						if (item i of linkname is equal to psdname) then
							set tiflink to i
						end if
					end repeat
					update link tiflink
					unlink link tiflink
				end tell
			end tell
			tell me to activate
		end tell
		set enabled of sender to false

	end indesign_
	
	on pdf_(sender)
		tell application "Adobe InDesign CS5"
			activate
			set PostScript level of EPS export preferences to level 2
			set EPS color of EPS export preferences to CMYK
			set preview of EPS export preferences to TIFF preview
			set font embedding of EPS export preferences to complete
			set data format of EPS export preferences to binary
			set bleed top of EPS export preferences to 0.75
			set bleed bottom of EPS export preferences to 0.75
			set bleed inside of EPS export preferences to 0.75
			set bleed outside of EPS export preferences to 0.75
			set image data of EPS export preferences to all image data
			set OPI image replacement of EPS export preferences to false
			set omit EPS of EPS export preferences to false
			set omit PDF of EPS export preferences to false
			set omit bitmaps of EPS export preferences to false
			set ignore spread overrides of EPS export preferences to false
			set applied flattener preset of EPS export preferences to flattener preset "[High Resolution]"
			set pdfpreset to PDF export preset "[Exclusive]"
			if languageversion = 1 then
				set pdfpath to ("Exclusive:1-Pods:PDF:" & (last word of filepath) & "_1_S.pdf")
				set epspath to ("Exclusive:To_Be_Moved:" & (last word of filepath) & "_1_S.eps")
				tell document (last word of filepath & "_1_S.indd")
					save
					export format PDF type to pdfpath using pdfpreset without showing options
					export format EPS type to epspath without showing options
					close
				end tell
				else if languageversion = 2 then
				set pdfpath to ("Exclusive:1-Pods:PDF:" & (last word of filepath) & "_1_F.pdf")
				set epspath to ("Exclusive:To_Be_Moved:" & (last word of filepath) & "_1_F.eps")
				tell document (last word of filepath & "_1_F.indd")
					save
					export format PDF type to pdfpath using pdfpreset without showing options
					export format EPS type to epspath without showing options
					close
				end tell
			end if
			set pdfpath to ("Exclusive:1-Pods:PDF:" & (last word of filepath) & "_1_E.pdf")
			set epspath to ("Exclusive:To_Be_Moved:" & (last word of filepath) & "_1_E.eps")
			tell document (last word of filepath & "_1_E.indd")
				save
				export format PDF type to pdfpath using pdfpreset without showing options
				export format EPS type to epspath without showing options
				close
			end tell
		end tell
		tell me to quit


	end pdf_

	on quit_(sender)
		tell me to quit
	end quit_
	
		on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
		
		tell application "Adobe Photoshop CS5"
			activate
		end tell --Photoshop Block
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		
		
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script