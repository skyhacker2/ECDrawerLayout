//
//  CBUUID+Extend.h
//  Pods
//
//  Created by Eleven Chen on 15/8/6.
//
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBUUID (Extend)

/*! This method is used to replace UUIDString since which is only available since iOS 7.1
 */
- (NSString *)stringRepresentative;

@end
