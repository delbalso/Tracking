//
//  GeneralTracker.h
//  Tracking
//
//  Created by Michael Del Balso on 12-03-14.
//  Copyright 2012 University of Toronto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+DirectoryLocations.h"
#import "NSObject+Extras.h"
#import "FMDatabase.h"
#import "NSObject-PerformWhenIdle.h"


@interface GeneralTracker : NSObject {
    NSDate * startTime;
    NSDate * endTime;
    NSString * eventName;
}

@property (retain, nonatomic) NSDate   *startTime;
@property (retain, nonatomic) NSDate   *endTime;
@property (retain, nonatomic) NSString *eventName;

+ (void)initialize;
+ (FMDatabase*) getDatabase;
+ (BOOL) open;
+ (void) systemIdleNotify;
- (id) init;
- (BOOL)acceptsFirstResponder;
- (BOOL)becomeFirstResponder;
+ (BOOL) dbErrorCheck;
@end
