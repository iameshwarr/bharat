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
    [self.mYourButton setAlpha:1];
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
    
    NSDictionary *largeFont=@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16],NSForegroundColorAttributeName:[UIColor colorWithRed:162.0f/255 green:162.0f/255 blue:162.0f/255 alpha:1] };
    NSDictionary *smallFont=@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12] ,NSForegroundColorAttributeName:[UIColor colorWithRed:162.0f/255 green:162.0f/255 blue:162.0f/255 alpha:1]};
    BOOL contains=NO;
    NSString *totalLikedPpl= [obj objectForKey:@"LikedPeople"];
    NSString *yourName=[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
    NSString *totalLikes=[obj objectForKey:@"Likes"];
    
    
    if([totalLikedPpl containsString:yourName])
    {
        contains=YES;
    }
    
    if([type isEqualToString:@"Request"])
    {
        cell.btnWidthConstraint.constant=90;
        [cell.feedBtnLabel setTitle:@"Attending" forState:UIControlStateNormal];
        
   
        NSMutableAttributedString *attStringForrequestInfoBtn= [NSMutableAttributedString new];
        NSString *likesString;
        if([totalLikes integerValue]>1)
        {
            likesString=[NSString stringWithFormat:@"%@ people are attending",totalLikes];
        }
        else if([totalLikes integerValue]==1)
        {
            likesString=[NSString stringWithFormat:@"%@ person is attending",totalLikes];
        }
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:likesString attributes:smallFont]];
        cell.statusLabel.attributedText=attStringForrequestInfoBtn;

        if(contains)
        {
            cell.feedBtnLabel.hidden=YES;
            NSInteger totalLikesInt=[totalLikes integerValue];
            totalLikesInt-=1;
            if(totalLikesInt==0)
            {
                attStringForrequestInfoBtn= [NSMutableAttributedString new];
                [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:@"You are attending" attributes:smallFont]];
                cell.statusLabel.attributedText=attStringForrequestInfoBtn;
            }
            else if (totalLikesInt>0)
            {
                attStringForrequestInfoBtn= [NSMutableAttributedString new];
                [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"You and %d people are attending",(int)totalLikesInt] attributes:smallFont]];
                cell.statusLabel.attributedText=attStringForrequestInfoBtn;
            }
        }
    }
    else if ([type isEqualToString:@"Appreciation"])
    {
        
        [cell.feedBtnLabel setTitle:@"Like" forState:UIControlStateNormal];
        
        NSMutableAttributedString *attStringForrequestInfoBtn= [NSMutableAttributedString new];
        NSString *likesString;
        if([totalLikes integerValue]>1)
        {
            likesString=[NSString stringWithFormat:@"%@ people like this",totalLikes];
        }
        else if([totalLikes integerValue]==1)
        {
            likesString=[NSString stringWithFormat:@"%@ person likes this",totalLikes];
        }
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:likesString attributes:smallFont]];
        cell.statusLabel.attributedText=attStringForrequestInfoBtn;
        
        if(contains)
        {
            cell.feedBtnLabel.hidden=YES;
            NSInteger totalLikesInt=[totalLikes integerValue];
            totalLikesInt-=1;
            if(totalLikesInt==0)
            {
                attStringForrequestInfoBtn= [NSMutableAttributedString new];
                [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:@"You like this" attributes:smallFont]];
                cell.statusLabel.attributedText=attStringForrequestInfoBtn;
            }
            else if (totalLikesInt>0)
            {
                attStringForrequestInfoBtn= [NSMutableAttributedString new];
                [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"You and %d people like this",(int)totalLikesInt] attributes:smallFont]];
                cell.statusLabel.attributedText=attStringForrequestInfoBtn;
            }
        }
    }
    else if ([type isEqualToString:@"Query/Suggestion"])
    {
        NSMutableAttributedString *attStringForrequestInfoBtn= [NSMutableAttributedString new];
        NSString *likesString;
        if([totalLikes integerValue]>1)
        {
            likesString=[NSString stringWithFormat:@"%@ people have this query",totalLikes];
        }
        else if([totalLikes integerValue]==1)
        {
            likesString=[NSString stringWithFormat:@"%@ person has this query",totalLikes];
        }
        [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:likesString attributes:smallFont]];
        cell.statusLabel.attributedText=attStringForrequestInfoBtn;
        
        [cell.feedBtnLabel setTitle:@"+1" forState:UIControlStateNormal];
        if(contains)
        {
            cell.feedBtnLabel.hidden=YES;
            NSInteger totalLikesInt=[totalLikes integerValue];
            totalLikesInt-=1;
            if(totalLikesInt==0)
            {
                attStringForrequestInfoBtn= [NSMutableAttributedString new];
                [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:@"You have this query" attributes:smallFont]];
                cell.statusLabel.attributedText=attStringForrequestInfoBtn;
            }
            else if (totalLikesInt>0)
            {
                attStringForrequestInfoBtn= [NSMutableAttributedString new];
                [attStringForrequestInfoBtn appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"You and %d people have this query",(int)totalLikesInt] attributes:smallFont]];
                cell.statusLabel.attributedText=attStringForrequestInfoBtn;
            }
        }
    }
    
    [cell.feedBtnLabel addTarget:self action:@selector(eventClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.feedBtnLabel.tag=indexPath.row;
    
    NSString *title = [obj objectForKey:@"Anonymous"];
  
   

    
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

-(void)eventClicked:(UIButton *)sender
{
    PFObject *obj=[feedArray objectAtIndex:sender.tag];
    NSString *likes = [obj objectForKey:@"Likes"];
    NSInteger likesInt=[likes integerValue];
    likesInt+=1;
    
    NSMutableString *likedPpl = [[obj objectForKey:@"LikedPeople"]mutableCopy];
    [likedPpl appendString:[[NSUserDefaults standardUserDefaults] stringForKey:@"Name"]];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:obj.objectId
                                 block:^(PFObject *post, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     post[@"Likes"] = [@(likesInt) stringValue];
                                     post[@"LikedPeople"] = likedPpl;
                                     [post saveInBackground];
                                 }];
    
    [obj setObject:likedPpl forKey:@"LikedPeople"];
    [obj setObject:likes forKey:@"Likes"];
    [self.newsFeedTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)youAction:(id)sender {
    feedArray=[NSMutableArray new];
    [self.mYourButton setAlpha:1];
    [self.mAllButton setAlpha:0.5];
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


}

- (IBAction)allAction:(id)sender {
    feedArray=[NSMutableArray new];
    [self.mAllButton setAlpha:1];
    [self.mYourButton setAlpha:0.5];
    PFQuery *query = [PFQuery queryWithClassName:@"Posts"];
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



}
@end
