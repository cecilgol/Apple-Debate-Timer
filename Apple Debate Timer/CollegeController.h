//
//  CollegeController.h
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//


#import <Cocoa/Cocoa.h>

#import "DebateTimer.h"

@interface CollegeController : NSWindowController <NSWindowDelegate, DebateTimerDelegate>{
    IBOutlet NSTextField *debateTimerField;
    IBOutlet NSButton *toggleButton;
    IBOutlet NSButton *affPrepRemaining;
    IBOutlet NSButton *negPrepRemaining;

@private
    DebateTimer *_timer;
    
    NSString *convertedTimeString;
    
    double _speechTime, _affPrep, _negPrep;
    
    
}

@property (nonatomic, retain) NSString *convertedTimeString;
@property double speechTime, affPrep, negPrep;


-(IBAction)toggleSpeech:(id)sender;

-(IBAction)setConstructive:(id)sender;
-(IBAction)setRebuttal:(id)sender;
-(IBAction)setCX:(id)sender;

-(IBAction)startAffPrep:(id)sender;
-(IBAction)startNegPrep:(id)sender;

-(NSString *)convertTimeString:(double)speechTime;

-(void)updateTimerField;

@end
