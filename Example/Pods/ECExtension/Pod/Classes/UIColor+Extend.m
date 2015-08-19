//
//  UIColor+Extend.m
//  Pods
//
//  Created by Eleven Chen on 15/7/31.
//
//

#import "UIColor+Extend.h"

@implementation UIColor (Extend)

+ (UIColor*) colorWithString: (NSString*) colorString
{
    NSString *string  = colorString;
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    NSScanner *scanner = [NSScanner scannerWithString:string];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *) colorWithRGBHex: (uint32_t)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

- (NSUInteger) colorCode
{
    CGFloat r, g, b;
    if ([self getRed:&r green:&g blue:&b alpha:NULL]) {
        NSUInteger redInt = (NSUInteger)(r*255 + 0.5);
        NSUInteger greenInt = (NSUInteger)(g*255 + 0.5);
        NSUInteger blueInt = (NSUInteger)(b*255 + 0.5);
        
        return (redInt << 16) | (greenInt << 8) | (blueInt);
    }
    return 0;
}

@end
