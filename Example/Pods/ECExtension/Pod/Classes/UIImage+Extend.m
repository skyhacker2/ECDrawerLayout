//
//  UIImage+Extend.m
//  Pods
//
//  Created by Eleven Chen on 15/8/12.
//
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

- (UIImage*) scaleImage: (CGFloat) scale
{
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* toImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return toImage;
}

- (UIImage*) changeColor: (UIColor*) color
{
    CGSize size = self.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToMask(ctx, CGRectMake(0, 0, size.width, size.height), self.CGImage);
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage* flippedImage = [UIImage imageWithCGImage:img.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
    return flippedImage;
}

@end
