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
    self.messageLabel.layer.borderWidth = 3.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
