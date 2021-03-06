//
//  VLRFormService.h
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

@import UIKit;

@class VLRTextField;

/**
 *  Handles some behaviors like checking form and going to next field
 */
@interface VLRFormService : NSObject

@property (nonatomic, readonly      ) NSMutableArray *textFields;// All text fields held by the manager
@property (nonatomic, weak, readonly) VLRTextField   *activeField;// First responder field

/**
 *  Register a new text field to the form
 *
 *  @param textField an instance of `VLRTextField`. Do not forget to use `formKeyPath`
 */
- (void) addTextField:(VLRTextField *)textField;

/**
 *  Check form with registered text fields and show errors
 *
 *  @return `YES` if valid, `NO` if not
 */
- (BOOL) checkForm;

/**
 *  Check form with registered text fields
 *
 *  @param showErrors show errors or not
 *
 *  @return `YES` if valid, `NO` if not
 */
- (BOOL) checkFormAndShowErrors:(BOOL)showErrors;

/**
 *  Extract values from registered text fields and get a dictionary
 *
 *  @return a dictionary with key:`tf.formKeyPath`: value:`tf.text`
 */
- (NSDictionary *)extractFieldsAsJson;

/**
 *  Move to next responder text field in the array
 */
- (void) goToNextTextField;

/**
 *  Move to previous responder text field in the array
 */
- (void) goToPreviousTextField;

@end
