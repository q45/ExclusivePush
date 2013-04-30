--
--  EPAppDelegate.applescript
--  ExclusivePush
--
--  Created by Quintin Smith on 4/30/13.
--  Copyright (c) 2013 Quintin Smith. All rights reserved.
--

script EPAppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script