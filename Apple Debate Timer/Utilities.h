//
//  Utilities.h
//  Debate Timer for Mac
//
//  Created by micheal stroud on 11/20/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "DebateTimer.h"
#import "Growl/Growl.h"
#import "AVFoundation/AVAudioPlayer.h"

@interface Utilities : NSObject <GrowlApplicationBridgeDelegate, AVAudioPlayerDelegate>{
    
}

-(NSDictionary *)registrationDictionaryForGrowl;

+(NSString *)convertTimeString:(double)speechTime;

+(void)tossGrowlMessage:(NSString *)speechTimeDisplayValue;
+(void)timesUpGrowlMessage;
+(void)timesUpNoise;


@end
