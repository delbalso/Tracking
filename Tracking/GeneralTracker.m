//
//  GeneralTracker.m
//  Tracking
//
//  Created by Michael Del Balso on 12-03-14.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import "GeneralTracker.h"

static FMDatabase * database;
@implementation GeneralTracker
@synthesize startTime,endTime,eventName;
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        [GeneralTracker open];
    }
    
}
+ (void) systemIdleNotify
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"systemIdleStart" object:nil];
}
+ (BOOL) open
{
    NSString *path = [[NSFileManager defaultManager] applicationSupportDirectory:@"db"];
    path = [path stringByAppendingPathComponent:@"testing-db.sqlite"];
    //[[GeneralTracker getDatabase] setDatabase:[FMDatabase databaseWithPath:path]];
    database = [[FMDatabase databaseWithPath:path] retain];
    [database open];
    return [GeneralTracker  dbErrorCheck];
}
+ (FMDatabase*) getDatabase
{
    return database;
}
- (BOOL)acceptsFirstResponder 
{
    return YES;
}
+ (BOOL) dbErrorCheck
{
    FMDatabase * database = [GeneralTracker getDatabase];
    BOOL hadError = [database hadError];
    if (hadError) {
        NSLog(@"DB Error %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
    return hadError;
}
- (BOOL)becomeFirstResponder
{ return YES; }
- (void)dealloc
{
    [super dealloc];
}

@end
