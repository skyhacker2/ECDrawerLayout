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

@interface ECViewController () <ECDrawerLayoutDelegate>
@property (strong, nonatomic) ECDrawerLayout* drawerLayout;
@property (strong, nonatomic) DrawerView* drawerView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ECViewController";
    self.drawerLayout = [[ECDrawerLayout alloc] initWithParentView:self.navigationController.view];
    self.drawerLayout.contentView = self.drawerView;
    self.drawerLayout.delegate = self;
    [self.navigationController.view addSubview:self.drawerLayout];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onLeftItemTouched:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void) loadView
{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) onLeftItemTouched: (UIBarButtonItem*) sender
{
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
