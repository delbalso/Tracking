//
//  SysNotifications.m
//  Tracking
//
//  Created by Michael Del Balso on 12-03-18.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import "SysNotifications.h"

int const timeAwayUntilIdle = 10;
static BOOL userActive = TRUE;
@implementation SysNotifications

+ (BOOL) getUserActive {return userActive;}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self performSelector:@selector(systemIdleNotify) withObject:nil afterSystemIdleTime:timeAwayUntilIdle];
    }
    
    return self;
}

- (void) systemIdleNotify
{
    userActive = FALSE;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"systemIdleStart" object:nil];
    keyAndMouseMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask |NSMouseMovedMask | NSLeftMouseDownMask | NSRightMouseDownMask) handler:^(NSEvent *event){[self systemActiveNotify];}];
}
- (void) systemActiveNotify
{
    userActive = TRUE; 
    [NSEvent removeMonitor:keyAndMouseMonitor];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"systemIdleEnd" object:nil];
    [self performSelector:@selector(systemIdleNotify) withObject:nil afterSystemIdleTime:timeAwayUntilIdle];
}
- (BOOL)acceptsFirstResponder 
{
    return YES;
}
- (BOOL)becomeFirstResponder
{ return YES; }
- (void)dealloc
{
    [super dealloc];
}

@end
