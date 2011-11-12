//
//  DebateTimer.m
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import "DebateTimer.h"


@implementation DebateTimer

@synthesize delegate=_delegate, speechTime=_speechTime;

- (id)initWithDelegate:(id<DebateTimerDelegate>)delegate{
    
    if (self = [super init]){
        _delegate = delegate;
    }
    
    return self;
}

-(void)startTimer{
    [_timer invalidate];
    _timer=nil;
    
    _timer = [[NSTimer scheduledTimerWithTimeInterval:.1 
                                               target:self 
                                             selector:@selector(advanceTimer:) 
                                             userInfo:Nil 
                                              repeats:YES] retain];
    _isRunning = YES;

}


- (void)stopTimer{
	[_timer invalidate];
	_timer = nil;
    
    _isRunning = NO;
}


-(BOOL)isRunning{

    return _isRunning;
}

-(void)advanceTimer{
    _speechTime = (_speechTime-.1);
    
    if (_delegate && [_delegate respondsToSelector:@selector(timerDidUpdate:)])
		[_delegate timerDidUpdate:self];

    if (_speechTime > .1) {
        _isRunning = NO;
        [_timer invalidate];
    }
    
}


-(void)dealloc{
    _delegate = nil;
    [_timer invalidate];

    [super dealloc];
    
    
}




@end
