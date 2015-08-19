//
//  UIColor+Extend.h
//  Pods
//
//  Created by Eleven Chen on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

+ (UIColor*) colorWithString: (NSString*) colorString;

+ (UIColor *) colorWithRGBHex: (uint32_t)hex;

- (NSUInteger) colorCode;

@end
