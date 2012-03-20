//
//  SysNotifications.h
//  Tracking
//
//  Created by Michael Del Balso on 12-03-18.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject-PerformWhenIdle.h"

extern int const timeAwayUntilIdle; // In seconds

@interface SysNotifications : NSObject {
@private
    id keyAndMouseMonitor;
}

+ (BOOL) getUserActive;

- (id) init;
- (BOOL)acceptsFirstResponder;
- (BOOL)becomeFirstResponder;
- (void) systemIdleNotify;
- (void) systemActiveNotify;
@end
