//
//  NDTouchID.h
//
//  Created by Nelson on 22/02/16.
//  Copyright © 2016 Nelson Domínguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef void(^TouchIDCallback)(BOOL success, NSError *error);

@interface NDTouchID : NSObject

/**
 *  check if we can use the library
 */
+(BOOL)canUseTouchID;

/**
 *  fingerprint validation
 *
 *  @param callback TouchIDCallback
 */
+(void)validateTouchIDWithFallbackTitle:(NSString *)fallbackTitle localizedReason:(NSString*)localizedReason callback:(TouchIDCallback)callback;

@end
