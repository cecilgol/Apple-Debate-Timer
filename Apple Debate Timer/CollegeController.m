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
    
    [GrowlApplicationBridge setGrowlDelegate:self];
    [self registrationDictionaryForGrowl];
    
    [toggleButton setEnabled:NO];
    
}
-(void)toggleSpeech:(id)sender{
    if ([_timer isRunning]) {
        [_timer stopTimer];
        
        [toggleButton setTitle:@"Start Speech"];
        
        [setConstructiveButton setEnabled:YES];
        [setRebuttalButton setEnabled:YES];
        [setCXButton setEnabled:YES];
        
        [affPrepRemaining setEnabled:YES];
        [negPrepRemaining setEnabled:YES];

    }else{
        [_timer startTimer];
        
        [toggleButton setTitle:@"Stop Speech"];

        [setConstructiveButton setEnabled:NO];
        [setRebuttalButton setEnabled:NO];
        [setCXButton setEnabled:NO];
        
        [affPrepRemaining setEnabled:NO];
        [negPrepRemaining setEnabled:NO];

    }
}

-(IBAction)setCX:(id)sender{
    if ([_timer isRunning] == NO) {
        _timer.speechTime = 3;
        [debateTimerField setTextColor:[NSColor blackColor]];
        
        [_timer startTimer];
        
        [toggleButton setEnabled:YES];
        
        [setConstructiveButton setEnabled:NO];
        [setRebuttalButton setEnabled:NO];

        
        [affPrepRemaining setEnabled:NO];
        [negPrepRemaining setEnabled:NO];
        
    }
 
}

-(IBAction)setRebuttal:(id)sender{
    if ([_timer isRunning] == NO) {
        _timer.speechTime = 360;
        [debateTimerField setTextColor:[NSColor blackColor]];

        [_timer startTimer];
        
        [toggleButton setEnabled:YES];
        
        [setConstructiveButton setEnabled:NO];
        [setCXButton setEnabled:NO];
        
        [affPrepRemaining setEnabled:NO];
        [negPrepRemaining setEnabled:NO];

    }
}

-(IBAction)setConstructive:(id)sender{
    if ([_timer isRunning] == NO) {
        _timer.speechTime = 540;
        [debateTimerField setTextColor:[NSColor blackColor]];
        
        [_timer startTimer];
        
        [toggleButton setEnabled:YES];
        
        [setCXButton setEnabled:NO];
        [setRebuttalButton setEnabled:NO];
        
        [affPrepRemaining setEnabled:NO];
        [negPrepRemaining setEnabled:NO];
        
    }
}



-(IBAction)startAffPrep:(id)sender{

    if([_timer isRunning]){
        [_timer stopTimer];
                
        [affPrepRemaining setTitle:[NSString stringWithFormat:@"Aff Prep: %@",[self convertTimeString:_affPrep]]];
        self.affPrep = _speechTime;
        
        [setCXButton setEnabled:YES];
        [setConstructiveButton setEnabled:YES];
        [setRebuttalButton setEnabled:YES];
        [toggleButton setEnabled:YES];
        
        [negPrepRemaining setEnabled:YES];
    
    }else{
        _timer.speechTime = self.affPrep;
        [_timer startTimer];
                
        [toggleButton setEnabled:NO];
        
        [setCXButton setEnabled:NO];
        [setConstructiveButton setEnabled:NO];
        [setRebuttalButton setEnabled:NO];
        [toggleButton setEnabled:NO];
        
        [negPrepRemaining setEnabled:NO];
        
        [affPrepRemaining setTitle:@"Stop Prep"];
    }
}

-(IBAction)startNegPrep:(id)sender{
    if([_timer isRunning]){
        [_timer stopTimer];
        
        [negPrepRemaining setTitle:[NSString stringWithFormat:@"Neg Prep: %@",[self convertTimeString:_negPrep]]];
        self.negPrep = _speechTime;
        
        [setCXButton setEnabled:YES];
        [setConstructiveButton setEnabled:YES];
        [setRebuttalButton setEnabled:YES];
        [toggleButton setEnabled:YES];
        
        [affPrepRemaining setEnabled:YES];
        
    }else{
        _timer.speechTime = self.negPrep;
        [_timer startTimer];
        
        [setCXButton setEnabled:NO];
        [setConstructiveButton setEnabled:NO];
        [setRebuttalButton setEnabled:NO];
        [toggleButton setEnabled:NO];
        
        [affPrepRemaining setEnabled:NO];
        
        
        [negPrepRemaining setTitle:@"Stop Prep"];
    }
}



- (void)timerDidUpdate:(DebateTimer *)timer{
    _speechTime = _timer.speechTime;
    [self convertTimeString:_timer.speechTime];
    [self updateTimerField];
}


-(void)updateTimerField{

    [debateTimerField setStringValue:convertedTimeString];
    [toggleButton setTitle:@"Stop Speech"];
    
    
    int mod = _speechTime * 10;
    if (mod % 300 == 0){
        if (mod != 0) {
            [self tossGrowlMessage];
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
        [setCXButton setEnabled:YES];
        [setConstructiveButton setEnabled:YES];
        [setRebuttalButton setEnabled:YES];
        [affPrepRemaining setEnabled:YES];
        [negPrepRemaining setEnabled:YES];
        
        [debateTimerField setTextColor:[NSColor blackColor]];
             
        if (mod < 1){
            [self timesUpGrowlMessage];
            for (int i = 0; i < 10; i++) {
                [self timesUpNoise];
            }
        }
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
-(void)tossGrowlMessage{
        [GrowlApplicationBridge notifyWithTitle:convertedTimeString description:@"Debate Timer!" notificationName:@"timerNotification" iconData:nil priority:1 isSticky:NO clickContext:nil];
}
-(void)timesUpGrowlMessage{
    [GrowlApplicationBridge notifyWithTitle:@"Times UP!" description:@"Debate Timer!" notificationName:@"timerNotification" iconData:nil priority:1 isSticky:NO clickContext:nil];
}


-(NSDictionary *)registrationDictionaryForGrowl{
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Growl Registration Ticket" ofType: @"growlRegDict"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    return dictionary;
}

-(void)timesUpNoise{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Glass" ofType:@"aiff"];
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:
                            [NSURL fileURLWithPath:path] error:NULL];
    audio.delegate = self;
    [audio play];
    
}



-(void)dealloc{
    [_timer release];
//    [hijackableButtons dealloc];
    [AVAudioPlayer release];
    
    [super dealloc];
}


@end
