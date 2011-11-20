//
//  Utilities.m
//  Debate Timer for Mac
//
//  Created by micheal stroud on 11/20/11.
//  Copyright 2011 UTSA. All rights reserved.
//

#import "Utilities.h"


@implementation Utilities

- (id)init
{
    self = [super init];
    if (self) {
        [GrowlApplicationBridge setGrowlDelegate:self];
        [self registrationDictionaryForGrowl];
    }


    return self;
}

+(NSString *)convertTimeString:(double)speechTime{
    NSTimeInterval interval = speechTime;
    
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
    return [NSString stringWithFormat:@"%02ld:%02ld", [conversionInfo minute],[conversionInfo second]];
}


+(void)tossGrowlMessage:(NSString *)speechTimeDisplayValue{
    [GrowlApplicationBridge notifyWithTitle:speechTimeDisplayValue description:@"Debate Timer!" notificationName:@"timerNotification" iconData:nil priority:1 isSticky:NO clickContext:nil];
}
+(void)timesUpGrowlMessage{
    [GrowlApplicationBridge notifyWithTitle:@"Times UP!" description:@"Debate Timer!" notificationName:@"timerNotification" iconData:nil priority:1 isSticky:NO clickContext:nil];
}


-(NSDictionary *)registrationDictionaryForGrowl{
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Growl Registration Ticket" ofType: @"growlRegDict"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    return dictionary;
}

+(void)timesUpNoise{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Glass" ofType:@"aiff"];
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:
                            [NSURL fileURLWithPath:path] error:NULL];
    [audio play];
    [audio autorelease];
    
}



-(void)dealloc{

    
    [super dealloc];
}



@end
