//
//  DebateTimer.h
//  Apple Debate Timer
//
//  Created by micheal stroud on 11/12/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DebateTimer;

@protocol DebateTimerDelegate <NSObject>

@optional   
-(void)timerDidUpdate:(DebateTimer *)timer;

@end

@interface DebateTimer : NSObject {
@private 
    BOOL _isRunning;
    double _speechTime;
    IBOutlet NSTextField * debateTimerField;
    id <DebateTimerDelegate> _delegate;
    
    NSTimer * _timer;

}
@property (nonatomic, assign) id <DebateTimerDelegate> delegate;

@property double speechTime;

-(id)initWithDelegate:(id <DebateTimerDelegate>)delegate;

-(BOOL)isRunning;

-(void)startTimer;
-(void)stopTimer;



@end
