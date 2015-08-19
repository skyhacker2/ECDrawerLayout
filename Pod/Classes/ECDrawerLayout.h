//
//  ECDrawerLayout.h
//  Pods
//
//  Created by Eleven Chen on 15/8/18.
//
//  https://github.com/skyhacker2/ECDrawerLayout
//
//  Copyright (c) 2015 Eleven Chen <skyhacker@126.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

@class ECDrawerLayout;
@protocol ECDrawerLayoutDelegate <NSObject>
- (void) drawerLayoutDidOpen;
- (void) drawerLayoutDidClose;
@end

@interface ECDrawerLayout : UIView
/**
 *  Width of drawerlayout
 */
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) BOOL enableShadow;
@property (nonatomic, assign) BOOL enableSwipeGesture;
@property (nonatomic, readonly) BOOL opened;
/** 
 *  Set the drawerlayout's parent view
 *  DrawerLayout will add swipe gesture in parent view
 */
@property (nonatomic, weak) UIView* parent;
/**
 * Content View in drawerlayout.
 */
@property (nonatomic, strong) UIView* contentView;
@property id<ECDrawerLayoutDelegate> delegate;

/**
 * Initialize the drawerlayout with parent view
 */
- (instancetype) initWithParentView:(UIView*) parent;
- (void) openDrawer;
- (void) closeDrawer;
- (void) toggle;

@end
