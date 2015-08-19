//
//  ECDrawerLayout.m
//  Pods
//
//  Created by Eleven Chen on 15/8/18.
//
//

#import "ECDrawerLayout.h"

@interface ECDrawerLayout() <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIView* backgroundView;
@property (strong, nonatomic) UIView* containerView;
@property (strong, nonatomic) UITapGestureRecognizer *backgroundTapRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (assign, nonatomic) BOOL enableTapClose;
@property (nonatomic, assign) CGPoint draggingPoint;
@property (nonatomic, assign) UIViewAnimationOptions openAnimationOptions;
@property (nonatomic, assign) UIViewAnimationOptions closeAnimationOptions;
@property (nonatomic, assign) CGFloat panGestureSideOffset;
@property (nonatomic, readwrite) BOOL opened;
@property (nonatomic, assign) BOOL enableShadow;
@end


#define SHADOW_RADIUS 5
#define SHADOW_OPACITY 1
#define BACKGROUND_ALPHA 0.5f
#define FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION 800
#define ANIMATION_DURATION 0.2f
@implementation ECDrawerLayout

#pragma mark - init

- (instancetype) initWithParentView:(UIView*) parent
{
    self = [self initWithFrame:CGRectZero];
    self.parent = parent;
    return self;
}

- (instancetype) init
{
    self = [self initWithFrame:CGRectZero];
    return self;
}


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView.frame = frame;
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0;
        [self addSubview:self.backgroundView];
        
        self.containerView.frame = CGRectZero;
        [self addSubview:self.containerView];
        self.containerView.backgroundColor = [UIColor whiteColor];
        
        self.enableShadow = NO;
        self.enableTapClose = NO;
        self.panGestureSideOffset = 10;
        self.width = 220;
        self.enableSwipeGesture = YES;
        self.openAnimationOptions = UIViewAnimationCurveEaseOut;
        self.closeAnimationOptions = UIViewAnimationCurveEaseIn;
    }
    return self;
}


#pragma mark - getter/setter

- (UIView*) containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIView*) backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}

- (void) setWidth:(CGFloat)width
{
    _width = width;
    CGRect frame = self.containerView.frame;
    frame.size.width = width;
    frame.origin.x = -width;
    self.containerView.frame = frame;
}

- (void) setEnableShadow:(BOOL)enableShadow
{
    _enableShadow = enableShadow;
    if (enableShadow) {
        self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.containerView.layer.shadowRadius = SHADOW_RADIUS;
        self.containerView.layer.shadowOpacity = SHADOW_OPACITY;
        self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.containerView.bounds].CGPath;
        self.containerView.layer.shouldRasterize = YES;
        self.containerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    } else {
        self.containerView.layer.shadowOpacity = 0;
        self.containerView.layer.shadowRadius = 0;
    }
}

- (void) setEnableTapClose:(BOOL)enableTapClose
{
    _enableTapClose = enableTapClose;
    if (enableTapClose) {
        [self.backgroundView addGestureRecognizer:self.backgroundTapRecognizer];
    } else {
        [self.backgroundView removeGestureRecognizer:self.backgroundTapRecognizer];
    }
}

- (UIPanGestureRecognizer*) panRecognizer
{
    if (!_panRecognizer) {
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
        _panRecognizer.delegate = self;
    }
    return _panRecognizer;
}

- (UITapGestureRecognizer*) backgroundTapRecognizer
{
    if (!_backgroundTapRecognizer) {
        _backgroundTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    }
    return _backgroundTapRecognizer;
}

- (void) setEnableSwipeGesture:(BOOL)enableSwipeGesture
{
    _enableSwipeGesture = enableSwipeGesture;
    if (_enableSwipeGesture) {
        [self.parent addGestureRecognizer:self.panRecognizer];
    } else {
        [self.parent removeGestureRecognizer:self.panRecognizer];
    }
}

- (void) setParent:(UIView *)parent
{
    _parent = parent;
    if (self.enableSwipeGesture) {
        [parent addGestureRecognizer:self.panRecognizer];
    } else {
        [parent removeGestureRecognizer:self.panRecognizer];
    }
}

- (void) setContentView:(UIView *)contentView
{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    contentView.frame = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    [self.containerView addSubview:contentView];
    _contentView = contentView;
}

#pragma mark - public method
- (void) openDrawer
{
    [self prepareToShow];
    [self openWithDuration:ANIMATION_DURATION];
}

- (void) closeDrawer
{
    [self closeWithDuration:ANIMATION_DURATION];
}

- (void) toggle
{
    if (!self.opened) {
        [self openDrawer];
    } else {
        [self closeDrawer];
    }
}


#pragma mark - primary method

- (void) openWithDuration: (CGFloat)duration
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:self.openAnimationOptions
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.x = 0;
                         self.containerView.frame = frame;
                         self.backgroundView.alpha = BACKGROUND_ALPHA;
                         self.enableShadow = YES;
                     } completion:^(BOOL finished) {
                         [self finishOpen];
                     }];
}

- (void) closeWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:self.closeAnimationOptions
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.x = -self.width;
                         self.containerView.frame = frame;
                         self.backgroundView.alpha = 0;
                         self.enableShadow = NO;
                     } completion:^(BOOL finished) {
                         [self finishHide];
                     }];
}

- (void) prepareToShow
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    self.backgroundView.frame = frame;
    self.containerView.frame = CGRectMake(-self.width, 0, self.width, frame.size.height);
    self.contentView.frame = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
}

- (void) finishHide
{
    self.frame = CGRectZero;
    self.backgroundView.frame = CGRectZero;
    self.enableTapClose = NO;
    self.opened = NO;
    if ([self.delegate respondsToSelector:@selector(drawerLayoutDidClose)]) {
        [self.delegate drawerLayoutDidClose];
    }
}

- (void) finishOpen
{
    self.enableTapClose = YES;
    self.opened = YES;
    if ([self.delegate respondsToSelector:@selector(drawerLayoutDidOpen)]) {
        [self.delegate drawerLayoutDidOpen];
    }
}

- (void) tapDetected:(UITapGestureRecognizer*) sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self closeDrawer];
    }
}

- (void) panDetected: (UIPanGestureRecognizer*) sender
{
    CGPoint translation = [sender translationInView:self.superview];
    CGPoint velocity = [sender velocityInView:self.superview];
    NSInteger movement = translation.x - self.draggingPoint.x;

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.draggingPoint = translation;
        if (!self.opened) {
            [self prepareToShow];
        }
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        static CGFloat lastLocation = 0;
        CGFloat newLocation = self.containerView.frame.origin.x;
        lastLocation = newLocation;
        newLocation += movement;
        
        if (newLocation >= [self minXForDragging] && newLocation <= [self maxXForDragging]) {
            [self moveToLocation:newLocation];
        }
        self.draggingPoint = translation;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        CGFloat currentX = self.containerView.frame.origin.x;
        CGFloat currentXOffset = currentX > 0? currentX : currentX*-1;
        CGFloat positiveVelocity = velocity.x > 0 ? velocity.x : velocity.x*-1;
        CGFloat duration = ANIMATION_DURATION;
        if (positiveVelocity >= FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION) {
            if (velocity.x < 0) {
                duration = (self.width - currentXOffset) / positiveVelocity;
                [self closeWithDuration:duration];
            } else {
                duration = currentXOffset / positiveVelocity;
                [self openWithDuration:duration];
            }
        } else {
            if (currentXOffset < self.width/2) {
                [self openWithDuration:ANIMATION_DURATION];
            } else {
                [self closeWithDuration:ANIMATION_DURATION];
            }
        }
        self.draggingPoint = CGPointZero;
    }
    
}

- (NSInteger) minXForDragging
{
    return -self.width;
}

- (NSInteger) maxXForDragging
{
    return 0;
}

- (CGFloat) animationDuration: (CGFloat) location
{
    float ratio = ((location+self.width) / self.width);
    return ANIMATION_DURATION * ratio;
}

- (void) moveToLocation:(CGFloat) location
{
    CGRect frame = self.containerView.frame;
    frame.origin.x = location;
    self.containerView.frame = frame;
    
    float ratio = ((location+self.width) / self.width);
    float alpha = BACKGROUND_ALPHA * ratio;
    self.backgroundView.alpha = alpha;
    
    float shadowRadius = SHADOW_RADIUS * ratio;
    float opacity = SHADOW_OPACITY * ratio;
    self.containerView.layer.shadowOpacity = opacity;
    self.containerView.layer.shadowRadius = shadowRadius;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.superview];
    if (self.opened) {
        if (point.x <= self.superview.bounds.size.width) {
            return YES;
        }
    } else {
        if (point.x < self.panGestureSideOffset) {
            return YES;
        }
    }
    return NO;
}


@end
