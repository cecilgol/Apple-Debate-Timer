//
//  LDController.h
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/18/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DebateTimer.h"
#import "Growl/Growl.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface LDController : NSWindowController <NSWindowDelegate, DebateTimerDelegate, GrowlApplicationBridgeDelegate, AVAudioPlayerDelegate>{
    IBOutlet NSTextField *debateTimerField;
    IBOutlet NSButton *toggleButton, *affPrepRemaining, *negPrepRemaining, *setCXButton, *setACButton, *setNCButton, *set1ARButton, *setNRButton, *set2ARButton;
    
    
@private
    DebateTimer *_timer;
    
    NSString *convertedTimeString;
    
    double _speechTime, _affPrep, _negPrep;
    
    NSArray *_hijackableButtons;
    
}

@property (nonatomic, retain) NSString *convertedTimeString;

@property (nonatomic, retain) IBOutlet NSArray *hijackableButtons;

@property double speechTime, affPrep, negPrep;


-(IBAction)toggleSpeech:(id)sender;

-(IBAction)setAC:(id)sender;
-(IBAction)setNC:(id)sender;
-(IBAction)setCX:(id)sender;
-(IBAction)set1AR:(id)sender;
-(IBAction)setNR:(id)sender;
-(IBAction)set2AR:(id)sender;


-(IBAction)startAffPrep:(id)sender;
-(IBAction)startNegPrep:(id)sender;

-(NSString *)convertTimeString:(double)speechTime;
-(void)updateTimerField;

-(NSDictionary *)registrationDictionaryForGrowl;
-(void)tossGrowlMessage;
-(void)timesUpGrowlMessage;
-(void)timesUpNoise;

-(void)hijackButtons;
-(void)releaseButtons;


@end
