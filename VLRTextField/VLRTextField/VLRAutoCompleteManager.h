//
//  VLRAutoCompleteManager.h
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

@import Foundation;
#import <HTAutocompleteTextField/HTAutocompleteTextField.h>

typedef NS_ENUM(NSInteger, VLRAutocompleteType) {
    VLRAutocompleteTypeEmail,
    VLRAutoCompleteCompany
};

@interface VLRAutoCompleteManager : NSObject <HTAutocompleteDataSource>
+ (VLRAutoCompleteManager *)sharedManager;
@end
