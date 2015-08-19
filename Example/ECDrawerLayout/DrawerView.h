//
//  DrawerView.h
//  ECDrawerLayout
//
//  Created by Eleven Chen on 15/8/19.
//  Copyright (c) 2015年 Eleven Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidMenuClickedCallback)(NSInteger index, NSString* title);

@interface DrawerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) DidMenuClickedCallback menuCallback;

@end
