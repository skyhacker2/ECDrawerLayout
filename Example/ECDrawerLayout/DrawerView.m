//
//  DrawerView.m
//  ECDrawerLayout
//
//  Created by Eleven Chen on 15/8/19.
//  Copyright (c) 2015年 Eleven Chen. All rights reserved.
//

#import "DrawerView.h"
#import "ECExtension.h"

@interface DrawerView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation DrawerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib
{
    self.logoImageView.layer.cornerRadius = [self.logoImageView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height/2;
    self.logoImageView.layer.masksToBounds = YES;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Menu"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Menu"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Menu"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithString:@"#e6e6e9"];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.selectedBackgroundView = [[UIView alloc] init];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"PAYMENT";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"HISTORY";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"HELP";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"FREE RIDES";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"PROMOTIONS";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"NOTIFICATIONS";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"SETTINGS";
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithString:@"#2dc8df"];
}

- (void) tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithString:@"#e6e6e9"];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.menuCallback) {
        self.menuCallback(indexPath.row, cell.textLabel.text);
    }
}
@end
