//
//  NewsFeedViewController.h
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *newsFeedTableView;
@property (strong, nonatomic) IBOutlet UIButton *mYourButton;
@property (strong, nonatomic) IBOutlet UIButton *mAllButton;

@end
