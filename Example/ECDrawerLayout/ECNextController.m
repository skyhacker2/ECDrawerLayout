//
//  ECNextController.m
//  ECDrawerLayout
//
//  Created by Eleven Chen on 15/8/19.
//  Copyright (c) 2015年 Eleven Chen. All rights reserved.
//

#import "ECNextController.h"


@implementation ECNextController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemTouched:)];
    self.navigationItem.rightBarButtonItem  = rightItem;
}

- (void) loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void) cancelItemTouched: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
