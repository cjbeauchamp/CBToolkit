//
//  NSString+CBExtensions.m
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

#import "NSString+CBExtensions.h"

#import <CommonCrypto/CommonDigest.h>

#define UPPERCASE   @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define LOWERCASE   [UPPERCASE lowercaseString]
#define NUMERIC     @"1234567890"

@implementation NSString (CBExtensions)

- (NSString*) md5
{
    
    unsigned char result[16];
    const char *cStr = [self UTF8String];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
    
}

+ (NSString*) charactersForSet:(CBCharacterSet)set
{
    NSString *string = @"";
    
    if (set & CBCharacterSetLowercase) {
        string = [string stringByAppendingString:LOWERCASE];
    }
    
    if(set & CBCharacterSetUppercase) {
        string = [string stringByAppendingString:UPPERCASE];
    }
    
    if(set & CBCharacterSetNumeric) {
        string = [string stringByAppendingString:NUMERIC];
    }
    
    return string;
}

+ (NSString*) randomString:(int)len withCharacterSet:(CBCharacterSet)charSet
{
    
    NSString *selection = [NSString charactersForSet:charSet];
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat:@"%c", [selection characterAtIndex:arc4random()%selection.length]];
    }
    
    return randomString;
}

+ (NSString*) randomString:(int)len
{
    return [NSString randomString:len withCharacterSet:CBCharacterSetAlphanumeric];
}

- (BOOL) containsString:(NSString*)needle
{
    return [self rangeOfString:needle].location != NSNotFound;
}

- (BOOL) containsCharacter:(char)needle
{
    return [self containsString:[NSString stringWithFormat:@"%c", needle]];
}

@end
