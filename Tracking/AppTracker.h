//
//  AppTracker.h
//  Tracking
//
//  Created by Michael Del Balso on 12-03-19.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cocoa/Cocoa.h"
#import "GeneralTracker.h"
#import "SysNotifications.h"

extern NSString * const inactiveEvent;

@interface AppTracker : GeneralTracker {
@private
    
}
- (id) init;
- (void) saveData;
- (void) addEvent:(NSString*)newAppName;
- (void)windowChangeNotification:(NSNotification *)note;
- (void)wakeNotification:(NSNotification *)note;
- (void)sleepNotification:(NSNotification *)note;
- (void)idleNotification:(NSNotification *)note;
- (void)backFromIdleNotification:(NSNotification *)note;

@end
