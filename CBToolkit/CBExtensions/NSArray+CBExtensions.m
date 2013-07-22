//
//  NSArray+CBExtensions.m
//  OpenFeed
//
//  Created by Chris on 7/21/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "NSArray+CBExtensions.h"

@implementation NSArray (CBExtensions)

- (BOOL) inArray:(id)value
{
    BOOL exists = FALSE;
    for(id obj in self) {
        if([obj isEqual:value]) {
            exists = TRUE;
            break;
        }
    }
    return exists;
}

@end
