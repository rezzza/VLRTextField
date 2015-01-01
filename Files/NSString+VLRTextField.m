//
//  NSString+VLRTextField.m
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

#import "NSString+VLRTextField.h"

@implementation NSString (VLRTextField)

- (NSString *)vlrTextField_cleanSpaces {
    NSMutableString *stringToReturn = [NSMutableString stringWithString:self];
    if (stringToReturn != nil && ![stringToReturn isEqual:@""]) {
        return [stringToReturn stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return @"";
}

@end
