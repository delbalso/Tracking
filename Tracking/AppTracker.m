//
//  AppTracker.m
//  Tracking
//
//  Created by Michael Del Balso on 12-03-19.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import "AppTracker.h"

NSString * const at_idleEvent = @"idle";

@implementation AppTracker

- (id)init
{
    self = [super init];
    if (self) {
        //Set up notifications
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(windowChangeNotification:) name:NSWorkspaceDidActivateApplicationNotification object:nil];
        //Sleep notifications
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(sleepNotification:) name:NSWorkspaceWillSleepNotification object:nil];
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(wakeNotification:) name:NSWorkspaceDidWakeNotification object:nil];
        
        //Idle Notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(idleNotification:) name:@"systemIdleStart" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFromIdleNotification:) name:@"systemIdleEnd" object:nil];
        
        //Setting up Database
        //Setu up Database
        [[GeneralTracker getDatabase] executeUpdate:@"create table IF NOT EXISTS activeAppEvents (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, START_TIME TEXT NOT NULL, END_TIME TEXT NOT NULL, INTERVAL_TIME TEXT NOT NULL, EVENT_NAME TEXT NOT NULL)"];
        [GeneralTracker dbErrorCheck];
        [self setStartTime:[self endTime]];
        [self setEventName:(NSString*)[NSObject activeProcessName]];
        [self setEndTime:nil];
        return self;
        
    }
    
    return self;
}

- (void) saveData
{
    NSString *endTimeText = [NSString stringWithFormat:@"%f", [endTime timeIntervalSince1970]];
    NSString *startTimeText = [NSString stringWithFormat:@"%f", [startTime timeIntervalSince1970]];
    NSString *intervalTimeText = [NSString stringWithFormat:@"%f", [endTime timeIntervalSinceDate:startTime]];
    [[GeneralTracker getDatabase] executeUpdate:@"insert into activeAppEvents (EVENT_NAME, START_TIME, END_TIME, INTERVAL_TIME) values(?,?,?,?)", eventName, startTimeText, endTimeText, intervalTimeText, nil];
    [GeneralTracker dbErrorCheck];
}

//switching to a new app
- (void) addEvent:(NSString*)newEventName
{
    if ([SysNotifications getUserActive]==TRUE || 
        ([newEventName isEqualToString:at_idleEvent] && ![eventName isEqualToString:at_idleEvent] ))
    {
        //above if statement skips adding the event if the user is idle.
        NSLog(@"App Focus: %@",newEventName);
        [self setEndTime:[NSDate date]];//set end_time to right now
        [self saveData];
        
        [self setStartTime:[self endTime]];
        [self setEventName:newEventName];
        [self setEndTime:nil];
    }
}

- (void)windowChangeNotification:(NSNotification *)note
{
    [self addEvent:[NSObject activeProcessName]];
}
- (void)sleepNotification:(NSNotification *)note
{
    [self addEvent:@"SystemSleep"];
}
- (void)wakeNotification:(NSNotification *)note
{
    [self addEvent:[NSObject activeProcessName]];
}
- (void)idleNotification:(NSNotification *)note
{
    [self addEvent:at_idleEvent];
}
- (void)backFromIdleNotification:(NSNotification *)note
{
    [self addEvent:[NSObject activeProcessName]];
}
        
- (void)dealloc
{
    [super dealloc];
}

@end
