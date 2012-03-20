//
//  SysTracker.m
//  Tracking
//
//  Created by Michael Del Balso on 12-03-15.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import "SysTracker.h"

NSString * const idleEvent = @"idle";
NSString * const sleepEvent = @"sleep";
NSString * const activeEvent = @"active";
NSString * const shutdownEvent = @"shutdown";

@implementation SysTracker
//@synthesize startTime,endTime,appName;
- (id) init
{
    self = [super init];
    //Set up Notifications
    
    //Sleep/shutdown Notifications
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self selector: @selector(sleepNotification:) name: NSWorkspaceWillSleepNotification object: NULL];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self selector: @selector(wakeNotification:) name: NSWorkspaceDidWakeNotification object: NULL];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self selector: @selector(shutdownNotification:) name: NSWorkspaceWillPowerOffNotification object: NULL];
    
    //Idle Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(idleNotification:) name:@"systemIdleStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFromIdleNotification:) name:@"systemIdleEnd" object:nil];
    
    //Setu up Database
    [[GeneralTracker getDatabase] executeUpdate:@"create table IF NOT EXISTS systemEvents (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, START_TIME TEXT NOT NULL, END_TIME TEXT NOT NULL, INTERVAL_TIME TEXT NOT NULL, EVENT_NAME TEXT NOT NULL)"];
    [GeneralTracker dbErrorCheck];
    [self setStartTime:[self endTime]];
    [self setEventName:activeEvent];
    [self setEndTime:nil];
    return self;
}
//switching to a new app
- (void) addEvent:(NSString*)newEventName
{
    if (![eventName isEqualToString:newEventName] )
    {
        //above if statement skips adding the event if the user is idle.
        NSLog(@"System Status: %@",newEventName);
        [self setEndTime:[NSDate date]];//set end_time to right now
        [self saveData];
        
        [self setStartTime:[self endTime]];
        NSLog(@"start time is now %f",[startTime timeIntervalSince1970]);
        [self setEventName:newEventName];
        [self setEndTime:nil];
    }
}

- (void) saveData
{
    NSString *endTimeText = [NSString stringWithFormat:@"%f", [endTime timeIntervalSince1970]];
    NSString *startTimeText = [NSString stringWithFormat:@"%f", [startTime timeIntervalSince1970]];
    NSString *intervalTimeText = [NSString stringWithFormat:@"%f", [endTime timeIntervalSinceDate:startTime]];
    [[GeneralTracker getDatabase] executeUpdate:@"insert into systemEvents (EVENT_NAME, START_TIME, END_TIME, INTERVAL_TIME) values(?,?,?,?)", eventName, startTimeText, endTimeText, intervalTimeText, nil];
    [GeneralTracker dbErrorCheck];
}
- (void)sleepNotification:(NSNotification *)note
{
    [self addEvent:sleepEvent];
}
- (void)wakeNotification:(NSNotification *)note
{
    [self addEvent:activeEvent];
}
- (void)idleNotification:(NSNotification *)note
{
    [self addEvent:idleEvent];
}
- (void)shutdownNotification:(NSNotification *)note
{
    [self addEvent:shutdownEvent];
}
- (void)backFromIdleNotification:(NSNotification *)note
{
    [self addEvent:activeEvent];
}
- (void)dealloc
{
    [super dealloc];
}

@end
