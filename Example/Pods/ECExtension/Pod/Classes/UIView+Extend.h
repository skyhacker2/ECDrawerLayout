//
//  UIView+Extend.h
//  Pods
//
//  Created by Eleven Chen on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

+ (id) loadFromNibWithName: (NSString*) name;

+ (id) loadFromNibWithName:(NSString *)name ower:(id)ower;

#pragma mark - Position
- (void) centerYInSuperView;

- (void) centerXInSuperView;

- (void) centerInSuperView;

- (void) centerXTo: (UIView*) view;

- (void) centerYTo: (UIView*) view;

- (void) centerTo: (UIView*) view;

- (void) constraintWidth: (CGFloat) width;

- (void) constraintHeight: (CGFloat) height;

- (void) constraintSize: (CGSize) size;

#pragma mark - Margin
- (void) layoutWidthMatchSuperView;

- (void) layoutHeightMatchSuperView;

- (void) layoutMatchSuperView;

- (void) layoutMarginTopSuperView:(CGFloat) dis;

- (void) layoutMarginBottomSuperView:(CGFloat) dis;

- (void) layoutMarginLeftSuperView:(CGFloat) dis;

- (void) layoutMarginRightSuperView:(CGFloat) dis;

- (void) layoutMarginSuperView: (CGFloat ) dis;

#pragma mark - Align

- (void) alignLeftTo: (UIView*) view;

- (void) alignRightTo: (UIView*) view;

- (void) alignTopTo: (UIView*) view;

- (void) alignBottomTo: (UIView*) view;

#pragma mark - Position relative to other view

- (void) leftTo: (UIView*) view distance:(CGFloat) dis;

- (void) rightTo: (UIView*) view distance:(CGFloat) dis;

- (void) topTo: (UIView*) view distance:(CGFloat) dis;

- (void) bottomTo: (UIView*) view distance:(CGFloat) dis;

@end
