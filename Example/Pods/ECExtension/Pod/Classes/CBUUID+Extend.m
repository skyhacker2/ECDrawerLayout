//
//  CBUUID+Extend.m
//  Pods
//
//  Created by Eleven Chen on 15/8/6.
//
//

#import "CBUUID+Extend.h"

@implementation CBUUID (Extend)

- (NSString *)stringRepresentative;
{
    NSData *data = [self data];
    
    NSUInteger bytesToConvert = [data length];
    const unsigned char *uuidBytes = (unsigned char *)[data bytes];
    NSMutableString *outputString = [NSMutableString stringWithCapacity:16];
    
    for (NSUInteger currentByteIndex = 0; currentByteIndex < bytesToConvert; currentByteIndex++)
    {
        switch (currentByteIndex)
        {
            case 3:
            case 5:
            case 7:
            case 9:[outputString appendFormat:@"%02x-", uuidBytes[currentByteIndex]]; break;
            default:[outputString appendFormat:@"%02x", uuidBytes[currentByteIndex]];
        }
        
    }
    
    return outputString;
}

@end
