//
//  ProductsViewController.m
//  Bharat+
//
//  Created by Eshwar M R on 12/13/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "ProductsViewController.h"
#import "NewsFeedCell.h"

@interface ProductsViewController ()

{
    NSArray *ProductsArray;
}
@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ProductsArray=[[NSArray alloc]initWithObjects:@"Redeem at 100 pts",@"Redeem at 150 pts",@"Redeem at 110 pts",@"Redeem at 140 pts", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ProductsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsFeedCell *mCell=[tableView dequeueReusableCellWithIdentifier:@"NewsFeedCell" forIndexPath:indexPath];
    if(mCell==nil)
    {
        mCell=[[NewsFeedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewsFeedCell"];
    }
    mCell.usernameLabel.text=[NSString stringWithFormat:@"%@!!",[ProductsArray objectAtIndex:indexPath.row]];
    return mCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
