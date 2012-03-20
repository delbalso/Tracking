//
//  SysTracker.h
//  Tracking
//
//  Created by Michael Del Balso on 12-03-15.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralTracker.h"
#import "SysNotifications.h"

extern NSString * const inactiveEvent;
extern NSString * const sleepEvent;
extern NSString * const activeEvent;
extern NSString * const shutdownEvent;

@interface SysTracker : GeneralTracker {
@private
}


- (void) saveData;
- (void)wakeNotification:(NSNotification *)note;
- (void)sleepNotification:(NSNotification *)note;
- (void)idleNotification:(NSNotification *)note;
- (void)backFromIdleNotification:(NSNotification *)note;
@end
