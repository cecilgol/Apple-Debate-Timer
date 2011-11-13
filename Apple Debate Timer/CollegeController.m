//
//  CollegeController.m
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import "CollegeController.h"

@implementation CollegeController

@dynamic convertedTimeString;

@synthesize speechTime=_speechTime, affPrep=_affPrep, negPrep=_negPrep;


- (void)windowDidLoad{
    [super windowDidLoad];
    if (!_timer) {
        _timer=[[DebateTimer alloc]initWithDelegate:self];
        _affPrep = 600;
        _negPrep = 600;
    }
}

-(IBAction)setCX:(id)sender{
    _timer.speechTime = 180;
    [debateTimerField setTextColor:[NSColor blackColor]];

    [_timer startTimer];
}

-(IBAction)setRebuttal:(id)sender{
    _timer.speechTime = 360;
    [debateTimerField setTextColor:[NSColor blackColor]];

    [_timer startTimer];
}

-(IBAction)setConstructive:(id)sender{
    _timer.speechTime = 540;
    [debateTimerField setTextColor:[NSColor blackColor]];

    [_timer startTimer];
}


- (void)timerDidUpdate:(DebateTimer *)timer{
    _speechTime = _timer.speechTime;
    [self convertTimeString:_timer.speechTime];
    [self updateTimerField];
}

-(IBAction)startAffPrep:(id)sender{

    if([_timer isRunning]){
        [_timer stopTimer];
        
        [affPrepRemaining setTitle:[NSString stringWithFormat:@"Aff Prep: %@",[self convertTimeString:_affPrep]]];
        self.affPrep = _speechTime;
    
    }else{
        _timer.speechTime = self.affPrep;
        [_timer startTimer];
        
        [affPrepRemaining setTitle:@"Stop Prep"];
    }
}

-(IBAction)startNegPrep:(id)sender{
    if([_timer isRunning]){
        [_timer stopTimer];
        
        [negPrepRemaining setTitle:[NSString stringWithFormat:@"Neg Prep: %@",[self convertTimeString:_negPrep]]];
        self.negPrep = _speechTime;
        
    }else{
        _timer.speechTime = self.negPrep;
        [_timer startTimer];
        
        [negPrepRemaining setTitle:@"Stop Prep"];
    }
}






-(void)updateTimerField{

    [debateTimerField setStringValue:convertedTimeString];
    [toggleButton setTitle:@"Stop Speech"];

    
    if (_speechTime < 30) {
        [debateTimerField setTextColor:[NSColor redColor]];
    }
    if (_speechTime > 30 && _speechTime < 60){
        [debateTimerField setTextColor:[NSColor blueColor]];
    }

}

-(void)toggleSpeech:(id)sender{
    if ([_timer isRunning]) {
        [_timer stopTimer];
        
        [toggleButton setTitle:@"Start Speech"];
    }else{
        [_timer startTimer];
        
        [toggleButton setTitle:@"Stop Speech"];
    }
}

-(NSString *)convertTimeString:(double)speechTime{
    NSTimeInterval interval = _speechTime;
        
    //the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date1]; 
    [date1 autorelease];
    [date2 autorelease];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSSecondCalendarUnit | NSMinuteCalendarUnit;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    return convertedTimeString = [NSString stringWithFormat:@"%02ld:%02ld", [conversionInfo minute],[conversionInfo second]];
}





@end
