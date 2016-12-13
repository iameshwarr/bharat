//
//  NewsFeedCell.h
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIButton *feedBtnLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnWidthConstraint;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
