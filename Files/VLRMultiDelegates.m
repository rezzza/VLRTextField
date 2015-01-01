//
//  VLRMultiDelegates.m
//  VLRTextField
//
//  Created by Marian Paul on 2015-01-01.
//  Copyright (c) 2015 RezZza. All rights reserved.
//

#import "VLRMultiDelegates.h"

@interface VLRMultiDelegates ()

@property (nonatomic, strong) NSMutableSet *delegates;

@end

// From http://www.scottlogic.com/blog/2012/11/19/a-multicast-delegate-pattern-for-ios-controls.html
// Added behavior for adding delegates as weak and not strong references (which is the default on collections)

@implementation VLRMultiDelegates

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self->_delegates = [NSMutableSet set];
    }
    
    return self;
}

- (void)addDelegate:(id)delegate {
    NSParameterAssert(delegate);
    NSValue *weakDelegate = [NSValue valueWithNonretainedObject:delegate];
    [self.delegates addObject:weakDelegate];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    // If any of the delegates respond to this selector, return YES
    for (NSValue *delegateAsValue in self.delegates) {
        id delegate = [delegateAsValue nonretainedObjectValue];
        
        if ([delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // Can this class create the signature?
    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
    
    // If not, try our delegates
    if (!signature) {
        for (NSValue *delegateAsValue in self.delegates) {
            id delegate = [delegateAsValue nonretainedObjectValue];

            if ([delegate respondsToSelector:aSelector]) {
                return [delegate methodSignatureForSelector:aSelector];
            }
        }
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // Forward the invocation to every delegate
    for (NSValue *delegateAsValue in self.delegates) {
        id delegate = [delegateAsValue nonretainedObjectValue];

        if ([delegate respondsToSelector:[anInvocation selector]]) {
            [anInvocation invokeWithTarget:delegate];
        }
    }
}

@end
