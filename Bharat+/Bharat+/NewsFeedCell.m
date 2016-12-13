//
//  NewsFeedCell.m
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "NewsFeedCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation NewsFeedCell

- (void)awakeFromNib {
    // Initialization code
    self.messageLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    self.messageLabel.layer.borderWidth = 1.0;
    self.messageLabel.layer.cornerRadius=4;
    
    self.feedBtnLabel.layer.borderColor = [UIColor colorWithRed:94.0f/255 green:128.0f/255 blue:206.0f/255 alpha:1].CGColor;
    self.feedBtnLabel.layer.borderWidth = 1.0;
    self.feedBtnLabel.layer.cornerRadius=4;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
