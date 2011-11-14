//
//  Apple_Debate_TimerAppDelegate.m
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import "Apple_Debate_TimerAppDelegate.h"
#import "CollegeController.h"
#import "HSController.h"

@interface Apple_Debate_TimerAppDelegate (FirstResponderMethods)
-(void)newCollegeDocument:(id)sender;
-(void)newHSDocument:(id)sender;
@end


@implementation Apple_Debate_TimerAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self newCollegeDocument:self];
}

@end

@implementation Apple_Debate_TimerAppDelegate (FirstResponderMethods)

- (void)newCollegeDocument:(id)sender
{
	CollegeController *timerWindowController = [[CollegeController alloc] initWithWindowNibName:@"CollegeControllerWindow"];
	
	[timerWindowController.window makeKeyAndOrderFront:self];


}
-(void)newHSDocument:(id)sender{
    HSController *hsTimerWindowController = [[HSController alloc] initWithWindowNibName:@"HSControllerWindow"];
    
    [hsTimerWindowController.window makeKeyAndOrderFront:self];
}


@end