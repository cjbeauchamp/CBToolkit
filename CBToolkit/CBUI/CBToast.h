//
//  CBToast.h
//  CBToolkit
//
//    Copyright (c) 2012 Chris Beauchamp
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//    2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//    The views and conclusions contained in the software and documentation are those
//    of the authors and should not be interpreted as representing official policies,
//    either expressed or implied, of the FreeBSD Project.

#import "CBToast.h"

#import <QuartzCore/QuartzCore.h>

/*
 Set some pre-defined constants
 */
#define kCBToastPadding         20
#define kCBToastMaxWidth        220
#define kCBToastCornerRadius    8.0
#define kCBToastFadeDuration    0.5
#define kCBToastTextColor       [UIColor whiteColor]
#define kCBToastBottomPadding   30

@implementation CBToast

/*
 The only method - static - and shows a toast with a given message at either
 a constant (found above) or at a user-defined time (in milliseconds)
 */
+ (void) showToast:(NSString*)msg withDuration:(NSUInteger)durationInMillis isPersistent:(BOOL)persistent {
    
    [CBToast hideToast];
    
    // build the toast label
    CBToast *toast = [[CBToast alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    toast.text = msg;
    toast.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    toast.textColor = [UIColor whiteColor];
    toast.numberOfLines = 1000;
    toast.textAlignment = UITextAlignmentCenter;
    toast.lineBreakMode = UILineBreakModeWordWrap;
    toast.font = [UIFont systemFontOfSize:14.0f];
    //    toast.alpha = 0.0f;
    toast.layer.cornerRadius = kCBToastCornerRadius;
    
    // resize based on message
    CGSize maximumLabelSize = CGSizeMake(kCBToastMaxWidth, 9999);
    CGSize expectedLabelSize = [toast.text sizeWithFont:toast.font
                                      constrainedToSize:maximumLabelSize
                                          lineBreakMode:toast.lineBreakMode];
    
    //adjust the label to the new height
    CGRect newFrame = toast.frame;
    newFrame.size = CGSizeMake(expectedLabelSize.width + kCBToastPadding, expectedLabelSize.height + kCBToastPadding);
    toast.frame = newFrame;
    
    // add the toast to the root window (so it overlays everything)
    [[[UIApplication sharedApplication] keyWindow] addSubview:toast];
    
    // get the window frame to determine placement
    CGRect windowFrame = [[UIApplication sharedApplication] keyWindow].frame;
    
    // set the Y-position so the base is 30 pixels off the bottom of the screen
    NSUInteger yOffset = windowFrame.size.height - (toast.frame.size.height / 2) - kCBToastBottomPadding;
    
    // align the toast properly
    toast.center = CGPointMake(160, yOffset);
    
    // round the x/y coords so they aren't 'split' between values (would appear blurry)
    toast.frame = CGRectMake(round(toast.frame.origin.x), round(toast.frame.origin.y), toast.frame.size.width, toast.frame.size.height);
    
    // set up the fade-in
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kCBToastFadeDuration];
    
    // values being aninmated
    toast.alpha = 1.0f;
    
    // perform the animation
    [UIView commitAnimations];
    
    
    
    // calculate the delay based on fade-in time + display duration
    NSTimeInterval delay = durationInMillis/1000 + kCBToastFadeDuration;
    
    // set up the fade out (to be performed at a later time)
    if(!persistent) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:delay];
        [UIView setAnimationDuration:kCBToastFadeDuration];
        [UIView setAnimationDelegate:toast];
        [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
        
        // values being animated
        toast.alpha = 0.0f;
        
        // commit the animation for being performed when the timer fires
        [UIView commitAnimations];
    }
    
}

+ (void) showToast:(NSString*)msg withDuration:(NSUInteger)durationInMillis {
    [CBToast showToast:msg withDuration:durationInMillis isPersistent:FALSE];
}

+ (void) showPersistentToast:(NSString *)msg {
    [CBToast showToast:msg withDuration:0 isPersistent:TRUE];
}

+ (void) hideToast {
    
    for(UIView *v in [[[UIApplication sharedApplication] keyWindow] subviews]) {
        if([v isKindOfClass:[CBToast class]]) {
            [v removeFromSuperview];
        }
    }
    
}

@end
