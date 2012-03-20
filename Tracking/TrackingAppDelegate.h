//
//  TrackingAppDelegate.h
//  Tracking
//
//  Created by Michael Del Balso on 12-03-13.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppTracker.h"
#import "SysTracker.h"
#import "SysNotifications.h"
@interface TrackingAppDelegate : NSObject <NSApplicationDelegate> {
@private
    SysNotifications * sysNotifications;
    AppTracker *appTracker;
    SysTracker *sysTracker;
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
}

@property (retain) AppTracker *appTracker;
@property (retain) SysTracker *sysTracker;
@property (assign) IBOutlet NSWindow *window;
- (id) init;
- (void) dealloc;
- (void)awakeFromNib;

@end
