//
//  JoynedMobileSDK.h
//  JoynedMobileSDK
//
//  Created by Arkadi Yoskovitz on 01/12/2023.
//

#import <Foundation/Foundation.h>

//! Project version number for JoynedMobileSDK.
FOUNDATION_EXPORT double JoynedMobileSDKVersionNumber;

//! Project version string for JoynedMobileSDK.
FOUNDATION_EXPORT const unsigned char JoynedMobileSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JoynedMobileSDK/PublicHeader.h>

/**
 Execute Swift code that could generate an Objective-C exception in here to catch and handle it gracefully (ie don't crash)

 @param tryBlock Block/Closure to execute that could thrown an Objective-C exception
 @param catchBlock Block/Closure to use if an exception is thrown in the tryBlock
 @param finallyBlock Block/Closure to execute after the tryBlock (or catchBlock if an exception was thrown)

 @note Loosely based on the code here: https://stackoverflow.com/a/35003095/144857 and here: https://github.com/williamFalcon/SwiftTryCatch
 */
NS_INLINE void j_try_objc(void(^_Nonnull tryBlock)(void), void(^_Nonnull catchBlock)(NSException* _Nonnull exception), void(^_Nonnull finallyBlock)(void)) {
    @try {
        tryBlock();
    }
    @catch (NSException* exception) {
        catchBlock(exception);
    }
    @finally {
        finallyBlock();
    }
}

/**
 Throws an Objective-C exception

 @param exception NSException object to throw

 @note Loosely based on the code here: https://github.com/williamFalcon/SwiftTryCatch
 */
NS_INLINE void j_throw_objc(NSException* _Nonnull exception)
{
    @throw exception;
}
