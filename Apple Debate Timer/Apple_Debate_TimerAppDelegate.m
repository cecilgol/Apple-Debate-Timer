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
#import "LDController.h"

@interface Apple_Debate_TimerAppDelegate (FirstResponderMethods)
-(void)newCollegeDocument:(id)sender;
-(void)newHSDocument:(id)sender;
-(void)newLDDocument:(id)sender;
@end


@implementation Apple_Debate_TimerAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self newCollegeDocument:self];
}

@end

@implementation Apple_Debate_TimerAppDelegate (FirstResponderMethods)

- (void)newCollegeDocument:(id)sender{
	CollegeController *timerWindowController = [[CollegeController alloc] initWithWindowNibName:@"CollegeControllerWindow"];
	
	[timerWindowController.window makeKeyAndOrderFront:self];
}

-(void)newHSDocument:(id)sender{
    HSController *hsTimerWindowController = [[HSController alloc] initWithWindowNibName:@"HSControllerWindow"];
    
    [hsTimerWindowController.window makeKeyAndOrderFront:self];
}

-(void)newLDDocument:(id)sender{
    LDController *ldTimerWindowController = [[LDController alloc] initWithWindowNibName:@"LDControllerWindow"];
    
    [ldTimerWindowController.window makeKeyAndOrderFront:self];
}


-(void)dealloc{
    [CollegeController dealloc];
    [HSController dealloc];
    [LDController dealloc];
    
    [super dealloc];
}
@end