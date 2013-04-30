//
//  main.m
//  ExclusivePush
//
//  Created by Quintin Smith on 4/30/13.
//  Copyright (c) 2013 Quintin Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
	return NSApplicationMain(argc, (const char **)argv);
}
