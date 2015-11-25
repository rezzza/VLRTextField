//
//  VLRTextField.h
//  VeryLastRoom
//
//  Created by Marian Paul on 18/03/14.
//  Copyright (c) 2014 RezZza. All rights reserved.
//

#import <VLRJVFloatLabeledTextField/JVFloatLabeledTextField.h>

typedef NS_ENUM(NSInteger, VLRTextFieldErrorCode)
{
    VLRTextFieldNotFilled,
    VLRTextFieldNotValid,
    VLRTextFieldErrorFromServer
};

@class VLRTextField;
@class VLRFormService;

typedef BOOL (^VLRValidateContentBlock)(VLRTextField* textField);

/**
 *  This class intention is to provide an extension to the power of two great libraries on `UITextField`:
 *  
 *    - `JVFloatLabeledTextField` which purpose is to nicely display the place holder on top on the textfield when inserting text
 *    - `HTAutocompleteTextField` which purpose is to provide autocompletion (for example: emails, company names, ...)
 *
 *  `VLRTextfield` adds a new layer: validation (for example, it is great on forms). You can specify several check behaviors like:
 *
 *    - check content with regex (@see `regex`) AND/OR
 *    - fill optional or not (@see `fillRequired`) AND/OR
 *    - minimum number of characters to enter (for example: 8 characters for password) (@see `minimumNumberOfCharacters`) AND/OR
 *    - custom validation block (@see `validateBlock`).
 *
 *  All of these tests can be run on demand or while editing.
 */
@interface VLRTextField : JVFloatLabeledTextField

@property (nonatomic, strong) NSString *messageRequired; // Default is some message. Please change it for your own
@property (nonatomic, strong) NSString *messageInvalid; // Default is nil
@property (nonatomic, strong) NSString *regex; // Default is nil
@property (nonatomic, strong) NSString *formKeyPath; // The key path for your web service
@property (nonatomic, copy  ) VLRValidateContentBlock validateBlock;

@property (nonatomic, assign) NSInteger minimumNumberOfCharacters; // Default is 0

@property (nonatomic, assign) BOOL fillRequired; // Default is YES
@property (nonatomic, assign) BOOL shouldCheckWhileEditing; // Default is NO
@property (nonatomic, assign) BOOL shouldCleanSpacesBeforeRegex; // Default is NO
@property (nonatomic, assign) BOOL shouldTrimWhitespacesBeforeRegex; // Default is YES
@property (nonatomic, assign) BOOL applyTextOffsetOnEditing; // Default is YES

@property (nonatomic, strong) UIColor *floatingLabelActiveValidTextColor UI_APPEARANCE_SELECTOR; // Default is blue
@property (nonatomic, strong) UIColor *floatingLabelActiveUnvalidTextColor UI_APPEARANCE_SELECTOR; // Default is red

/**
 *  Go through all the validation things you could have set up with properties
 *
 *  @param error any error on text field
 *
 *  @return `YES` if valid, `NO` if not
 */
- (BOOL) isContentValid:(NSError **)error;

/**
 *  Test for a specific regex other than the one on property
 *
 *  @param regex a regex as `NSString`
 *
 *  @return `YES` if valid, `NO` if not
 */
- (BOOL) isContentValidWithRegex:(NSString*)regex;

/**
 *  Create error views from specified error. This will display `error.localizedDescription` and do nothing if an error view is already present.
 *  Basically, the error should be the one on `isContentValid:` method.
 *
 *  @param error the error to display.
 */
- (void) addErrorViewFromError:(NSError *)error;

/**
 *  Will replace the placeholder with the error label
 */
- (void) animateErrorViewApparition;

/**
 *  Will remove the error label and replace the placeholder label
 */
- (void) removeErrorView;

@end

FOUNDATION_EXTERN NSString * const VLRTextFieldErrorDomain;
