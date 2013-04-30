//
//  CBLoader.m
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

#import "CBLoader.h"

@implementation CBLoader

/*
 The only method - static - and shows a toast with a given message at either
 a constant (found above) or at a user-defined time (in milliseconds)
 */
+ (void) showLoader:(NSString*)msg {
    
    // hide any pre-existing loaders
    [CBLoader hideLoader];
    
    // generate the new loader
    CBLoader *loader = [[CBLoader alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    loader.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.9f];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 30)];
    message.textAlignment = UITextAlignmentCenter;
    message.font = [UIFont boldSystemFontOfSize:14.0f];
    message.textColor = [UIColor whiteColor];
    message.text = msg;
    message.backgroundColor = [UIColor clearColor];
    [loader addSubview:message];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.center = CGPointMake(160, 256);
    [loader addSubview:activity];
    [activity startAnimating];
    
    // add the toast to the root window (so it overlays everything)
    [[[UIApplication sharedApplication] keyWindow] addSubview:loader];
    
}

/*
 This can be called at any time. If any view is found that matches this
 class, it will be removed from its superview
 */
+ (void) hideLoader {
    
    for(UIView *v in [[[UIApplication sharedApplication] keyWindow] subviews]) {
        if([v isKindOfClass:[CBLoader class]]) {
            [v removeFromSuperview];
        }
    }
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
