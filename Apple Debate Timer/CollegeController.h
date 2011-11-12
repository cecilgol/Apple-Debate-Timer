//
//  CollegeController.h
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//


#import <Cocoa/Cocoa.h>

#import "DebateTimer.h"

@interface CollegeController : NSViewController <NSWindowDelegate, DebateTimerDelegate>{
    IBOutlet NSTextField *debateTimerField;
    IBOutlet NSButton *toggleButton;

@private
    DebateTimer *_timer;
}

@property (nonatomic, retain)NSString *timeString;

-(IBAction)toggleSpeech:(id)sender;
-(IBAction):(id)sender



@end
