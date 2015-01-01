//
//  VLRTextField+Form.m
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

#import "VLRTextField+Form.h"
#import <PPHelpMe/PPHelpMe.h>

@implementation VLRTextField (Form)

+ (VLRTextField*)formTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder
{
    VLRTextField *tf                       = [VLRTextField newWithFrame:frame];
    tf.backgroundColor                     = [UIColor whiteColor];
    tf.floatingLabelYPadding               = @(2.0f);
    tf.returnKeyType                       = UIReturnKeyNext;
    tf.placeholder                         = placeholder;
    tf.font                                = [UIFont systemFontOfSize:16.0f];
    tf.floatingLabel.font                  = [UIFont systemFontOfSize:11.0f];
    tf.floatingLabelTextColor              = [UIColor lightGrayColor];
    tf.floatingLabelActiveTextColor        = [UIColor blueColor];
    tf.placeholderColor                    = [UIColor lightGrayColor];
    tf.floatingLabelActiveValidTextColor   = [UIColor blueColor];
    tf.floatingLabelActiveUnvalidTextColor = [UIColor redColor];
    tf.xOffsetForClearButton               = 2.0f;
    tf.clearButtonMode                     = UITextFieldViewModeWhileEditing;
    tf.autocapitalizationType              = UITextAutocapitalizationTypeNone;
    tf.autocorrectionType                  = UITextAutocorrectionTypeNo;
    tf.shouldCheckWhileEditing             = YES;
    
    return tf;
}

@end
