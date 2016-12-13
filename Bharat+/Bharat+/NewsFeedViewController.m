//
//  NewsFeedViewController.m
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "NewsFeedViewController.h"
#import <Parse/Parse.h>
#import "NewsFeedCell.h"

@interface NewsFeedViewController ()

@end

@implementation NewsFeedViewController
{
    NSMutableArray *feedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.newsFeedTableView.dataSource=self;
    self.newsFeedTableView.delegate=self;
    feedArray=[NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
    [query whereKey:@"PostedBy" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                [feedArray addObject:object];
            }
            [self.newsFeedTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feedArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseidentifier"];
    PFObject *obj=[feedArray objectAtIndex:indexPath.row];
    NSString *type = [obj objectForKey:@"Type"];
    if([type isEqualToString:@"Request"])
    {
        [cell.feedBtnLabel setTitle:@"Yes" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"Appreciation"])
    {
        [cell.feedBtnLabel setTitle:@"Like" forState:UIControlStateNormal];
    }
    NSString *title = [obj objectForKey:@"Anonymous"];
    
    
    NSDictionary *largeFont=@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16],NSForegroundColorAttributeName:[UIColor colorWithRed:162.0f/255 green:162.0f/255 blue:162.0f/255 alpha:1] };
    NSDictionary *smallFont=@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12] ,NSForegroundColorAttributeName:[UIColor colorWithRed:162.0f/255 green:162.0f/255 blue:162.0f/255 alpha:1]};
   

    
    if([title isEqualToString:@"Y"])
    {
        NSMutableAttributedString *attStringForrequestInfoBtn= [NSMutableAttributedString new];
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:@"Anonymous"    attributes:largeFont]];
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)",type]   attributes:smallFont]];
        cell.usernameLabel.attributedText=attStringForrequestInfoBtn;
    }
    else
    {
        NSMutableAttributedString *attStringForrequestInfoBtn= [NSMutableAttributedString new];
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:[obj objectForKey:@"PostedBy"]    attributes:largeFont]];
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%@)",type]   attributes:smallFont]];
        cell.usernameLabel.attributedText=attStringForrequestInfoBtn;
    }
    cell.messageLabel.text= [obj objectForKey:@"Post"];
    return cell;

//    NSString *title = [obj objectForKey:@"Likes"];
//    NSString *title = [obj objectForKey:@"LikedPeople"];
//    NSString *title = [obj objectForKey:@"PostedBy"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end