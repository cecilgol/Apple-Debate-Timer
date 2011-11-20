//
//  CollegeController.m
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import "CollegeController.h"


@implementation CollegeController


@synthesize speechTime=_speechTime, affPrep=_affPrep, negPrep=_negPrep, hijackableButtons=_hijackableButtons;


- (void)windowDidLoad{
    [super windowDidLoad];
    if (!_timer) {
        _timer=[[DebateTimer alloc]initWithDelegate:self];
        _affPrep = 600;
        _negPrep = 600;

    }
    
    self.hijackableButtons = [NSArray arrayWithObjects:setCXButton,setConstructiveButton,setRebuttalButton,affPrepRemaining,negPrepRemaining,nil];    

        
    [toggleButton setEnabled:NO];
    
}
-(void)toggleSpeech:(id)sender{
    if ([_timer isRunning]) {
        [_timer stopTimer];
        
        [toggleButton setTitle:@"Start Speech"];
        
        [self releaseButtons];
    }else{
        [_timer startTimer];
        
        [toggleButton setTitle:@"Stop Speech"];

        [self hijackButtons];
    }
}

-(IBAction)setCX:(id)sender{
    if ([_timer isRunning] == NO) {
        _timer.speechTime = 3;
        [debateTimerField setTextColor:[NSColor blackColor]];
        
        [_timer startTimer];

        [self hijackButtons];        

        [toggleButton setEnabled:YES];
        [sender setEnabled:YES];
    }
 
}

-(IBAction)setRebuttal:(id)sender{
    if ([_timer isRunning] == NO) {
        _timer.speechTime = 360;
        [debateTimerField setTextColor:[NSColor blackColor]];
        
        [_timer startTimer];
                
        [self hijackButtons];      

        [toggleButton setEnabled:YES];
        [sender setEnabled:YES];

    }
}

-(IBAction)setConstructive:(id)sender{
    if ([_timer isRunning] == NO) {
        _timer.speechTime = 540;
        [debateTimerField setTextColor:[NSColor blackColor]];
        
        [_timer startTimer];

        [self hijackButtons];         
        [toggleButton setEnabled:YES];
        [sender setEnabled:YES];
     
        
    }
}



-(IBAction)startAffPrep:(id)sender{

    if([_timer isRunning]){
        [_timer stopTimer];
        
        [self releaseButtons];

        [affPrepRemaining setTitle:[NSString stringWithFormat:@"Aff Prep: %@",[Utilities convertTimeString:_speechTime]]];
        self.affPrep = _speechTime;
        
    
    }else{
        _timer.speechTime = self.affPrep;
        [debateTimerField setTextColor:[NSColor blackColor]];

        [_timer startTimer];
                
        [self hijackButtons];
        
        [sender setTitle:@"Stop Prep"];
        [sender setEnabled:YES];
    }
}

-(IBAction)startNegPrep:(id)sender{
    if([_timer isRunning]){
        [_timer stopTimer];
        
        [self releaseButtons];

        [negPrepRemaining setTitle:[NSString stringWithFormat:@"Neg Prep: %@",[Utilities convertTimeString:_speechTime]]];
        self.negPrep = _speechTime;
        
        
    }else{
        _timer.speechTime = self.negPrep;
        [debateTimerField setTextColor:[NSColor blackColor]];

        [_timer startTimer];

        [self hijackButtons];
        
        [sender setTitle:@"Stop Prep"];
        [sender setEnabled:YES];
    }
}



- (void)timerDidUpdate:(DebateTimer *)timer{
    _speechTime = _timer.speechTime;
    [self updateTimerField];
}


-(void)updateTimerField{

    NSString *speechTimeDisplayValue = [Utilities convertTimeString:_speechTime];
    [debateTimerField setStringValue:speechTimeDisplayValue];
    [toggleButton setTitle:@"Stop Speech"];
    
    
    int mod = _speechTime * 10;
    if (mod % 300 == 0){
        if (mod != 0) {
            [Utilities tossGrowlMessage:speechTimeDisplayValue];
        }
    }
    if (_speechTime < 30) {
        [debateTimerField setTextColor:[NSColor redColor]];
    }
    if (_speechTime > 30 && _speechTime < 60){
        [debateTimerField setTextColor:[NSColor blueColor]];
    }
    if (_speechTime < .1){
        [toggleButton setEnabled:NO];
        
        [self releaseButtons];        
        
        [debateTimerField setTextColor:[NSColor blackColor]];
             
        if (mod < 1){
            [Utilities timesUpGrowlMessage];
            for (int i = 0; i < 10; i++) {
                [Utilities timesUpNoise];
            }
        }
    }
}



-(void)hijackButtons{
    [_hijackableButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setEnabled:NO];
    }];
}


-(void)releaseButtons{
    [_hijackableButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setEnabled:YES];
    }];
}



-(void)dealloc{
    [_timer release];
    [_hijackableButtons dealloc];
    
    [super dealloc];
}


@end
