//
//  VLRAutoCompleteManager.m
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

#import "VLRAutoCompleteManager.h"

@implementation VLRAutoCompleteManager

#pragma mark - Singleton

+ (VLRAutoCompleteManager *)sharedManager {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark - HTAutocompleteTextFieldDelegate

- (NSString *)textField:(HTAutocompleteTextField *)textField
    completionForPrefix:(NSString *)prefix
             ignoreCase:(BOOL)ignoreCase
{
    switch (textField.autocompleteType) {
        case VLRAutocompleteTypeEmail:
        {
            static dispatch_once_t onceToken;
            static NSArray *autocompleteEmailArray;
            dispatch_once(&onceToken, ^
                          {
                              // often used mail domains @verylastroom
                              autocompleteEmailArray = @[
                                                         @"gmail.com",
                                                         @"hotmail.fr",
                                                         @"hotmail.com",
                                                         @"yahoo.fr",
                                                         @"live.fr",
                                                         @"orange.fr",
                                                         @"free.fr",
                                                         @"yahoo.com",
                                                         @"wanadoo.fr",
                                                         @"laposte.net",
                                                         @"msn.com",
                                                         @"me.com",
                                                         @"sfr.fr",
                                                         @"aol.com",
                                                         @"hotmail.es",
                                                         @"icloud.com",
                                                         @"yahoo.es",
                                                         @"neuf.fr",
                                                         @"voila.fr",
                                                         @"ymail.com",
                                                         @"bbox.fr",
                                                         @"live.com",
                                                         @"outlook.com",
                                                         @"outlook.fr",
                                                         @"mac.com",
                                                         @"club-internet.fr",
                                                         @"hotmail.co.uk",
                                                         @"aliceadsl.fr",
                                                         @"noos.fr",
                                                         @"yahoo.co.uk",
                                                         @"numericable.fr",
                                                         @"gmx.fr",
                                                         @"hotmail.it",
                                                         @"skynet.be",
                                                         @"mail.ru",
                                                         @"live.be",
                                                         @"hotmail.be",
                                                         @"cegetel.net",
                                                         @"aol.fr",
                                                         @"googlemail.com",
                                                         @"yahoo.it",
                                                         @"pt.lu",
                                                         @"rocketmail.com",
                                                         @"bluewin.ch",
                                                         @"yahoo.de",
                                                         @"comcast.net",
                                                         @"telefonica.net",
                                                         @"gmail.fr",
                                                         @"telenet.be",
                                                         @"libero.it",
                                                         @"gmx.com",
                                                         @"libertysurf.fr",
                                                         @"web.de",
                                                         @"sbcglobal.net",
                                                         @"hotmail.de",
                                                         @"netcourrier.com",
                                                         @"hotmail.con",
                                                         @"aim.com",
                                                         @"live.co.uk",
                                                         @"skema.edu",
                                                         @"edhec.com",
                                                         @"cox.net",
                                                         @"ono.com",
                                                         @"yandex.ru",
                                                         @"naver.com",
                                                         @"9online.fr",
                                                         @"orange.com",
                                                         @"ebuyclub.com",
                                                         @"gmx.net",
                                                         @"verizon.net",
                                                         @"att.net",
                                                         @"terra.com",
                                                         @"outlook.es",
                                                         @"icloud.fr",
                                                         @"bellsouth.net",
                                                         @"live.it",
                                                         @"francetv.fr",
                                                         @"hotmail.ch",
                                                         @"infonie.fr",
                                                         @"pagesjaunes.fr",
                                                         @"btinternet.com",
                                                         @"numericable.com",
                                                         @"yahoo.com.au",
                                                         @"sncf.fr",
                                                         @"essca.eu",
                                                         @"espeme.com",
                                                         @"sky.com",
                                                         @"inseec-france.com",
                                                         @"caramail.com",
                                                         @"gmaim.com",
                                                         @"gmx.es",
                                                         @"essec.edu"
                                                         ];
                          });
            
            // Check that text field contains an @
            NSRange atSignRange = [prefix rangeOfString:@"@"];
            if (atSignRange.location == NSNotFound)
            {
                return @"";
            }
            
            // Stop autocomplete if user types dot after domain
            NSString *domainAndTLD = [prefix substringFromIndex:atSignRange.location];
            NSRange rangeOfDot = [domainAndTLD rangeOfString:@"."];
            if (rangeOfDot.location != NSNotFound)
            {
                return @"";
            }
            
            // Check that there aren't two @-signs
            NSArray *textComponents = [prefix componentsSeparatedByString:@"@"];
            if ([textComponents count] > 2)
            {
                return @"";
            }
            
            if ([textComponents count] > 1)
            {
                // If no domain is entered, use the first domain in the list
                if ([(NSString *)textComponents[1] length] == 0)
                {
                    return autocompleteEmailArray[0];
                }
                
                NSString *textAfterAtSign = textComponents[1];
                
                NSString *stringToLookFor;
                if (ignoreCase)
                {
                    stringToLookFor = [textAfterAtSign lowercaseString];
                }
                else
                {
                    stringToLookFor = textAfterAtSign;
                }
                
                for (NSString *stringFromReference in autocompleteEmailArray)
                {
                    NSString *stringToCompare;
                    if (ignoreCase)
                    {
                        stringToCompare = [stringFromReference lowercaseString];
                    }
                    else
                    {
                        stringToCompare = stringFromReference;
                    }
                    
                    if ([stringToCompare hasPrefix:stringToLookFor])
                    {
                        return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
                    }
                    
                }
            }
        }
            break;
        case VLRAutoCompleteCompany:
        {
            static dispatch_once_t onceToken;
            static NSArray *autocompleteCompanyArray;
            dispatch_once(&onceToken, ^
                          {
                              autocompleteCompanyArray = @[
                                                           @"RezZza",
                                                           @"Wasappli",
                                                           @"Google",
                                                           @"Apple",
                                                           @"Microsoft"
                                                           ];
                          });
            // If nothing is entered, return nothing
            if ([prefix length] == 0)
            {
                return @"";
            }
            
            NSString *stringToLookFor = prefix;
            if (ignoreCase)
            {
                stringToLookFor = [stringToLookFor lowercaseString];
            }
            
            for (NSString *stringFromReference in autocompleteCompanyArray)
            {
                NSString *stringToCompare;
                if (ignoreCase)
                {
                    stringToCompare = [stringFromReference lowercaseString];
                }
                else
                {
                    stringToCompare = stringFromReference;
                }
                
                if ([stringToCompare hasPrefix:stringToLookFor])
                {
                    return [stringFromReference stringByReplacingCharactersInRange:[stringToCompare rangeOfString:stringToLookFor] withString:@""];
                }
                
            }
        }
        default:
            break;
    }
    
    return @"";
}

@end
