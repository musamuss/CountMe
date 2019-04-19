#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CommonCrypto.h"
#import "CommonHMAC.h"
#import "SwiftyInsta.h"

FOUNDATION_EXPORT double SwiftyInstaVersionNumber;
FOUNDATION_EXPORT const unsigned char SwiftyInstaVersionString[];

