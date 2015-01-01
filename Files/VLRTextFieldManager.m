//
//  VLRTextFieldManager.m
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

#import "VLRTextFieldManager.h"
#import "VLRMultiDelegates.h"
#import "VLRTextField.h"

#import "VLRTextFieldMacros.h"

@interface VLRTextFieldManager () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray    *textFields;
@property (nonatomic, strong) VLRMultiDelegates *delegates;
@property (nonatomic, weak  ) VLRTextField      *activeField;

@end

@implementation VLRTextFieldManager

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self->_delegates = [VLRMultiDelegates new];
        [self->_delegates addDelegate:self];
    }
    
    return self;
}

#pragma mark - Public methods

- (void)addTextField:(VLRTextField *)textField {
    NSParameterAssert([textField isKindOfClass:[VLRTextField class]]);
    
    [self.textFields addObject:textField];
    textField.delegate = (id<UITextFieldDelegate>)self.delegates;
    textField.textFieldManager = self;
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
            json[tf.formKeyPath] = OBJ_OR_NULL(tf.text);
        }
    }
    return json;
}

#pragma mark - Multi delegates handling

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    [self.delegates addDelegate:delegate];
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
        NSUInteger nextIndex = textFieldIndex + 1;
        if (nextIndex < [self.textFields count]) {
            UITextField *nextTextField = self.textFields[nextIndex];
            [nextTextField becomeFirstResponder];
        }
    }
}

#pragma mark Protocol implementation

- (void)textFieldDidBeginEditing:(VLRTextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.activeField]) {
        self.activeField = nil;
    }
}

- (BOOL)textFieldShouldReturn:(VLRTextField *)textField {
    [self goToNextTextField];
    
    return YES;
}

@end
