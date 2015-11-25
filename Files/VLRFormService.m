//
//  VLRFormService.m
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

#import "VLRFormService.h"
#import "VLRTextField.h"

#import "VLRTextFieldMacros.h"

@interface VLRFormService () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray    *textFields;
@property (nonatomic, weak  ) VLRTextField      *activeField;

@end

@implementation VLRFormService

#pragma mark - Public methods

- (void)addTextField:(VLRTextField *)textField {
    NSParameterAssert([textField isKindOfClass:[VLRTextField class]]);
    
    [self.textFields addObject:textField];
    textField.delegate = self;
}

- (BOOL)checkForm {
    return [self checkFormAndShowErrors:YES];
}

- (BOOL)checkFormAndShowErrors:(BOOL)showErrors {
    BOOL formValid = YES;
    NSError *error = nil;
    
    NSMutableArray *allFields = self.textFields;
    
    for (VLRTextField *tf in allFields) {
        if (![tf isContentValid:&error]) {
            if (showErrors) {
                [tf addErrorViewFromError:error];
            }
            VLRTextFieldLog(@"Error: %@", error.localizedDescription);

            formValid &= NO;
        } else {
            [tf removeErrorView];
        }
    }
    
    for (VLRTextField *tf in allFields) {
        if (showErrors) {
            [tf animateErrorViewApparition];
        }
    }
    
    return formValid;
}

- (NSDictionary *)extractFieldsAsJson {
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    for (VLRTextField *tf in self.textFields) {
        if ([[tf formKeyPath] length] == 0) {
            VLRTextFieldLog(@"Value '%@' ignored because you did not specified a formKeyPath", tf.text);
        }
        else {
            json[tf.formKeyPath] = VLR_WALLET_OBJ_OR_NULL_IF_NIL(tf.text);
        }
    }
    return json;
}

#pragma mark - Custom getters

- (NSMutableArray *)textFields {
    if (!_textFields) {
        _textFields = [NSMutableArray new];
    }
    
    return _textFields;
}

#pragma mark - UITextField delegate

#pragma mark Fields management

- (void) goToNextTextField {
    NSUInteger textFieldIndex = [self.textFields indexOfObject:self.activeField];
    if (textFieldIndex == NSNotFound) {
        VLRTextFieldLog(@"%@ not found on active fields", self.activeField);
        return;
    }
    
    if (self.activeField.returnKeyType == UIReturnKeyNext) {
        UITextField *nextTextField = nil;
        NSUInteger nextIndex = textFieldIndex;
        do {
            nextIndex = nextIndex + 1;
            if (nextIndex < [self.textFields count]) {
                nextTextField = self.textFields[nextIndex];
            }
            else {
                nextTextField = nil;
            }
        } while (![nextTextField canBecomeFirstResponder] && nextTextField);
        
        [nextTextField becomeFirstResponder];
    }
}

- (void)goToPreviousTextField {
    NSUInteger textFieldIndex = [self.textFields indexOfObject:self.activeField];
    if (textFieldIndex == NSNotFound) {
        VLRTextFieldLog(@"%@ not found on active fields", self.activeField);
        return;
    }
    
    UITextField *previousTextField = nil;
    NSInteger previousIndex = textFieldIndex;
    do {
        previousIndex = previousIndex - 1;
        if (previousIndex >= 0) {
            previousTextField = self.textFields[previousIndex];
        }
        else {
            previousTextField = nil;
        }
    } while (![previousTextField canBecomeFirstResponder] && previousIndex >= 0);
    
    [previousTextField becomeFirstResponder];
}

#pragma mark Protocol implementation

- (void)textFieldDidBeginEditing:(VLRTextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField layoutIfNeeded];
    if ([textField isEqual:self.activeField]) {
        self.activeField = nil;
    }
}

- (BOOL)textFieldShouldReturn:(VLRTextField *)textField {
    [self goToNextTextField];
    
    return YES;
}

@end
