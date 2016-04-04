//
//  NDTouchID.m
//
//  Created by Nelson on 22/02/16.
//  Copyright © 2016 Nelson Domínguez. All rights reserved.
//

#import "NDTouchID.h"

NSString *const NDTouchIdErrorDomain = @"com.touchid.errordomain";

@implementation NDTouchID

+(BOOL)canUseTouchID
{
    if (NSStringFromClass([LAContext class]) != nil) {
        LAContext *context = [[LAContext alloc] init];
        return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    }
    return NO;
}

+(void)validateTouchIDWithFallbackTitle:(NSString *)fallbackTitle localizedReason:(NSString*)localizedReason callback:(TouchIDCallback)callback
{
    if (![self canUseTouchID]) {
        callback(NO, [NSError errorWithDomain:NDTouchIdErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"Touch ID not available"}]);
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = fallbackTitle;
    
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                callback(YES, nil);
            } else {
                callback(NO, error);
            }
        });
    }];
}

@end
