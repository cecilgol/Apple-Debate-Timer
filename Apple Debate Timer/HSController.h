//
//  HSController.h
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/13/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DebateTimer.h"
#import "Utilities.h"

@interface HSController : NSWindowController <NSWindowDelegate, DebateTimerDelegate>{
    IBOutlet NSTextField *debateTimerField;
    IBOutlet NSButton *toggleButton, *affPrepRemaining, *negPrepRemaining, *setCXButton, *setConstructiveButton, *setRebuttalButton;
    
    
    
@private
    DebateTimer *_timer;
    
    double _speechTime, _affPrep, _negPrep;
    
    NSArray *_hijackableButtons;
}

@property (nonatomic, retain) IBOutlet NSArray *hijackableButtons;

@property double speechTime, affPrep, negPrep;




-(IBAction)toggleSpeech:(id)sender;

-(IBAction)setConstructive:(id)sender;
-(IBAction)setRebuttal:(id)sender;
-(IBAction)setCX:(id)sender;

-(IBAction)startAffPrep:(id)sender;
-(IBAction)startNegPrep:(id)sender;

-(void)updateTimerField;

-(void)hijackButtons;
-(void)releaseButtons;

@end
