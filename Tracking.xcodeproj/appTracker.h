//
//  appTracker.h
//  Tracking
//
//  Created by Michael Del Balso on 12-03-13.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GeneralTracker.h"
#import "SysNotifications.h"

extern NSString * const at_idleEvent;

@interface appTracker : GeneralTracker  {
}

/*@property (retain, nonatomic) NSDate   *startTime;
@property (retain, nonatomic) NSDate   *endTime;
@property (retain, nonatomic) NSString *appName;
*/

- (void) saveData;
- (void) addEvent:(NSString*)newAppName;
- (id) init;
- (void)windowChangeNotification:(NSNotification *)note;
- (void)wakeNotification:(NSNotification *)note;
- (void)sleepNotification:(NSNotification *)note;
- (void)idleNotification:(NSNotification *)note;
- (void)backFromIdleNotification:(NSNotification *)note;
@end
