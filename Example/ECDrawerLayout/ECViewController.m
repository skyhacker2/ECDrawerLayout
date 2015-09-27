//
//  ECViewController.m
//  ECDrawerLayout
//
//  Created by Eleven Chen on 08/18/2015.
//  Copyright (c) 2015 Eleven Chen. All rights reserved.
//

#import "ECViewController.h"
#import <ECDrawerLayout/ECDrawerLayout.h>
#import "DrawerView.h"
#import "ECExtension.h"
#import "ECNextController.h"
#import "DrawerView2.h"

@interface ECViewController () <ECDrawerLayoutDelegate>
@property (strong, nonatomic) ECDrawerLayout* drawerLayout;
@property (strong, nonatomic) DrawerView* drawerView;
@property (strong, nonatomic) DrawerView2* drawerVeiw2;
@end

@implementation ECViewController

- (DrawerView*) drawerView
{
    if (!_drawerView) {
        _drawerView = [UIView loadFromNibWithName:NSStringFromClass([DrawerView class])];
        __weak ECViewController *weekSelf = self;
        _drawerView.menuCallback = ^(NSInteger index, NSString* title) {
            [weekSelf.drawerLayout toggle];
            ECNextController* vc = [[ECNextController alloc] init];
            vc.title = title;
            if (index == 0) {
                [weekSelf.navigationController pushViewController:vc animated:YES];
            } else {
                UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:vc];
                [weekSelf presentViewController:nvc animated:YES completion:nil];
            }
            
        };
    }
    return _drawerView;
}

- (DrawerView2*) drawerVeiw2
{
    if (!_drawerVeiw2) {
        _drawerVeiw2 = [[DrawerView2 alloc] init];
    }
    return _drawerVeiw2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ECViewController";
    self.drawerLayout = [[ECDrawerLayout alloc] initWithParentView:self.navigationController.view];
    self.drawerLayout.contentView = self.drawerView;    // drawerView is a xib
//    self.drawerLayout.contentView = self.drawerVeiw2; // drawerView2 is code implements
    self.drawerLayout.delegate = self;
    [self.navigationController.view addSubview:self.drawerLayout];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftItemTouched:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItemTouched:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void) loadView
{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) onLeftItemTouched: (UIBarButtonItem*) sender
{
    self.drawerLayout.openFromRight = NO;
    [self.drawerLayout openDrawer];
}

- (void) onRightItemTouched:(UIBarButtonItem*) sender
{
    self.drawerLayout.openFromRight = YES;
    [self.drawerLayout openDrawer];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - ECDrawerLayoutDelegate
- (void) drawerLayoutDidOpen
{
    NSLog(@"drawerLayout open");
}
- (void) drawerLayoutDidClose
{
    NSLog(@"drawerLayout close");
}


@end
