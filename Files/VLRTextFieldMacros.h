//
//  VLRTextFieldMacros.h
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 REZZZA. All rights reserved.
//

#ifndef VLRTextField_VLRTextFieldMacros_h
#define VLRTextField_VLRTextFieldMacros_h

#ifdef DEBUG
#   define VLRTextFieldLog(fmt, ...) NSLog((@"[VLRTextField] %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define VLRTextFieldLog(...)
#endif

#define VLR_WALLET_OBJ_OR_NULL_IF_NIL(obj) (obj ? : [NSNull null])

#endif
