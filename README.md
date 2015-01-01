VLRTextField
============

VeryLastRoom iOS textField

![alt tag](http://i.imgur.com/SJHDV28.png)
![alt tag](http://i.imgur.com/uV12PCn.png)

# Purpose

This class intention is to provide an extension to the power of two great libraries on `UITextField`:

  - [`JVFloatLabeledTextField`](https://github.com/jverdi/JVFloatLabeledTextField) which purpose is to nicely display the place holder on top on the textfield when inserting text
  - [`HTAutocompleteTextField`](https://github.com/hoteltonight/HTAutocompleteTextField) which purpose is to provide autocompletion (for example: emails, company names, ...)

`VLRTextfield` adds a new layer: **validation** (for example, it is great on forms). You can then specify several check behaviors like:

  - check content with regex (@see `regex`) AND/OR
  - fill optional or not (@see `fillRequired`) AND/OR
  - minimum number of characters to enter (for example: 8 characters for password) (@see `minimumNumberOfCharacters`) AND/OR
  - custom validation block (@see `validateBlock`).

All of these tests can be run on demand or while editing.
#Examples

## Classic text field 

    VLRTextField *name          = [VLRTextField myAppCustomizedTextFieldWithPlaceholder:@"Enter your first name"];
    name.autocapitalizationType = UITextAutocapitalizationTypeWords;
    name.formKeyPath            = @"name";
    name.messageRequired        = @"Your first name is required";
    
## Regex text field

    static NSString *REGULAR_EXPRESSION_EMAIL = @"[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@([a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}";

    VLRTextField *email          = [VLRTextField myAppCustomizedTextFieldWithPlaceholder:@"Enter an email to reach you"];
    email.keyboardType           = UIKeyboardTypeEmailAddress;
    email.regex                  = REGULAR_EXPRESSION_EMAIL;
    email.messageInvalid         = @"Your email address is invalid";
    email.messageRequired        = @"Please enter an email adress";
    email.formKeyPath            = @"email_address";
    email.autocompleteDataSource = [VLRAutoCompleteManager sharedManager];
    email.autocompleteType       = VLRAutocompleteTypeEmail;
    
Notice `VLRAutoCompleteManager`. See [`HTAutocompleteTextField`](https://github.com/hoteltonight/HTAutocompleteTextField).

## Minimum characters text field

    VLRTextField *password             = [VLRTextField myAppCustomizedTextFieldWithPlaceholder:@"Enter a password"];
    password.minimumNumberOfCharacters = 8;
    password.messageRequired           = @"The password should be 8 characters long";
    password.formKeyPath               = @"password_1";
    password.secureTextEntry           = YES;

## Custom validation block text field

We use the block to check if the two passwords are the same:

    VLRTextField *passwordConfirmation             = [VLRTextField formTextFieldWithFrame:CGRectMake(kXOffset, kYOffset + CGRectGetMaxY(password.frame), width, kTextFieldHeight) placeholder:@"Re enter your password"];
    passwordConfirmation.messageInvalid            = @"The two passwords should match";
    passwordConfirmation.messageRequired           = @"Please re enter your password";
    passwordConfirmation.minimumNumberOfCharacters = password.minimumNumberOfCharacters;
    passwordConfirmation.formKeyPath               = @"password_2";
    passwordConfirmation.secureTextEntry           = YES;
    passwordConfirmation.validateBlock             = ^BOOL(VLRTextField *textField) {
        return [[password text] isEqualToString:textField.text];
    };

## Not required text field

    VLRTextField *company          = [VLRTextField formTextFieldWithFrame:CGRectMake(kXOffset, kYOffset + CGRectGetMaxY(passwordConfirmation.frame), width, kTextFieldHeight) placeholder:@"Enter the company you work for"];
    company.fillRequired           = NO;
    company.formKeyPath            = @"company_name";
    company.autocompleteDataSource = [VLRAutoCompleteManager sharedManager];
    company.autocompleteType       = VLRAutoCompleteCompany;
    company.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    company.returnKeyType          = UIReturnKeyDone;
    
Notice `VLRAutoCompleteManager`. See [`HTAutocompleteTextField`](https://github.com/hoteltonight/HTAutocompleteTextField).

##The one more thing

Along with validating the content the user enters, you can also use `VLRFormService` to:

- handle automatic next if `returnKeyType` is equal to `UIReturnKeyNext`
- check form and show errors (or not)
- extract a JSON as `NSDictionary` from registered textFields.

Do not hesitate to subclass `VLRFormService` to add new behaviors fitting your need.

### How to use `VLRFormService`

    self.registerTextFieldManager          = [VLRFormService new];
    self.registerTextFieldManager.delegate = self;
    
    // The order does matter (for next behavior)
    [self.registerTextFieldManager addTextField:name];
    [self.registerTextFieldManager addTextField:email];
    [self.registerTextFieldManager addTextField:password];
    [self.registerTextFieldManager addTextField:passwordConfirmation];
    [self.registerTextFieldManager addTextField:company];

### Check form
Check and display errors:

    - (void) send {
        BOOL formValid = [self.registerTextFieldManager checkForm]; // Will check and display errors
        if (formValid) {
            [self.registerTextFieldManager.activeField resignFirstResponder];
            [self safelySend];
        }
    }

Check without displaying errors

    BOOL formValid = [self.registerTextFieldManager checkFormAndShowErrors:NO];

### Extract JSON

This will use `formKeyPath` property on `VLRTextField`

    NSDictionary *json = [self.registerTextFieldManager extractFieldsAsJson];

### Delegate consideration

Because `VLRFormService` handles some behaviors for you, each text field will have at least one delegate : `VLRFormService` instance.
By setting `VLRFormService` `delegate` property to your controller for example, it is exactly the same as setting `delegate` to the controller for every text fields. See the sample to have a better view.
