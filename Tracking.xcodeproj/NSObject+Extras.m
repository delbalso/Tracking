//
//  Utilities.m
//  Tracking
//
//  Created by Michael Del Balso on 12-03-15.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import "NSObject+Extras.h"


@implementation NSObject (Extras)
- (NSString *)activeProcessName
{
    /*Get Process Name*/
    ProcessSerialNumber psn = { 0L, 0L };
    OSStatus err = GetFrontProcess(&psn);
    CFStringRef processName = NULL;
    err = CopyProcessName(&psn, &processName);
    return (NSString*)processName;
}
- (NSString *)activeFrontChromeTabName
{
    //NSURL* scriptPath = [NSURL URLWithString:];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ChromeActiveTab" ofType:@"scpt"];
    NSURL* url = [NSURL fileURLWithPath:path];NSDictionary* errors = [NSDictionary dictionary];
    NSAppleScript* appleScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
    NSString * activeURL = [[appleScript executeAndReturnError:nil] stringValue];
    NSLog(@"NEW VALUE IS %@", activeURL);
    [appleScript release];
    return activeURL;
}
@end
