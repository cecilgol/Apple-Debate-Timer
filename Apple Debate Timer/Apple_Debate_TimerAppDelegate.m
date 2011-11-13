//
//  Apple_Debate_TimerAppDelegate.m
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import "Apple_Debate_TimerAppDelegate.h"
#import "CollegeController.h"

@interface Apple_Debate_TimerAppDelegate (FirstResponderMethods)
- (void)newDocument:(id)sender;
@end


@implementation Apple_Debate_TimerAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self newDocument:self];
}

@end

@implementation Apple_Debate_TimerAppDelegate (FirstResponderMethods)

- (void)newDocument:(id)sender
{
	CollegeController *timerWindowController = [[CollegeController alloc] initWithWindowNibName:@"CollegeControllerWindow"];
	
	[timerWindowController.window makeKeyAndOrderFront:self];
}



@end