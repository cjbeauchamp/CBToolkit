//
//  NSDate+CBExtensions.m
//  OpenFeed
//
//  Created by Chris on 6/30/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "NSDate+CBExtensions.h"

@implementation NSDate (CBExtensions)

- (NSString*) timeAgo:(BOOL)shortened
{
    NSString *retString = @"";
    double changeSeconds = [[NSDate date] timeIntervalSinceDate:self];
    int changeMinutes = floor(changeSeconds / 60);
    int changeHours = floor(changeMinutes / 60);
    int changeDays = floor(changeHours / 24);
    int changeWeeks = floor(changeDays / 7);
    int changeMonths = floor(changeWeeks / 4);
    int changeYears = floor(changeMonths / 12);
    
    if(changeSeconds < 60) {
        retString = @"Just Now";
    } else if(changeMinutes < 60) {
        retString = [NSString stringWithFormat:@"%d%@%@ ago", changeMinutes, (shortened?@"m":@" minute"), (changeMinutes==1||shortened)?@"":@"s"];
    } else if(changeHours < 24) {
        retString = [NSString stringWithFormat:@"%d%@%@ ago", changeHours, (shortened?@"h":@" hour"), (changeHours==1||shortened)?@"":@"s"];
    } else if(changeDays < 7) {
        retString = [NSString stringWithFormat:@"%d%@%@ ago", changeDays, (shortened?@"d":@" day"), (changeDays==1||shortened)?@"":@"s"];
    } else if(changeWeeks < 4) {
        retString = [NSString stringWithFormat:@"%d%@%@ ago", changeWeeks, (shortened?@"w":@" week"), (changeWeeks==1||shortened)?@"":@"s"];
    } else if(changeMonths < 12) {
        retString = [NSString stringWithFormat:@"%d%@%@ ago", changeMonths, (shortened?@"mo":@" month"), (changeMonths==1||shortened)?@"":@"s"];
    } else {
        retString = [NSString stringWithFormat:@"%d%@%@ ago", changeYears, (shortened?@"y":@" year"), (changeYears==1||shortened)?@"":@"s"];
    }

    return retString;
}

@end
