//
//  UILabel+CBExtensions.m
//  CBCache
//
//  Created by Chris on 4/29/13.
//  Copyright (c) 2013 Chris Beauchamp. All rights reserved.
//

#import "UILabel+CBExtensions.h"

@implementation UILabel (CBExtensions)

-(float) expectedWidth
{
    CGSize maximumLabelSize = CGSizeMake(9999, self.frame.size.height);
    
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font
                                     constrainedToSize:maximumLabelSize
                                         lineBreakMode:self.lineBreakMode];
    return expectedLabelSize.width;
}

@end
