//
//  TrackingAppDelegate.m
//  Tracking
//
//  Created by Michael Del Balso on 12-03-13.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import "TrackingAppDelegate.h"

@implementation TrackingAppDelegate

@synthesize window,sysTracker,appTracker;

- (id) init
{
    [super init];
    sysNotifications = [[SysNotifications alloc] init];
    appTracker = [[AppTracker alloc] init];
    sysTracker = [[SysTracker alloc] init];
    return self;
}
- (void) dealloc
{
    [appTracker dealloc];
    [super dealloc];
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    // Insert code here to initialize your application
}

-(void)awakeFromNib{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    //[statusItem setTitle:@"Status"];
    [statusItem setImage:[NSImage imageNamed:@"3Dg16.png"]];
    [statusItem setAlternateImage:[NSImage imageNamed:@"3Dg16.png"]];
    [statusItem setHighlightMode:YES];
}
@end
