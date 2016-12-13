//
//  PostViewController.m
//  Bharat+
//
//  Created by Eshwar M R on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "PostViewController.h"
#import <Parse/Parse.h>
#import "NewsFeedViewController.h"

@interface PostViewController ()
@property(nonatomic,weak)IBOutlet UITextField *mRequestTypeTF;
@property(nonatomic,weak)IBOutlet UITextField *mNameTF;
@property(nonatomic,weak)IBOutlet UITextView *mDataTV;


@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(Back)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonSelected)]];
    [self.navigationItem setTitle:@"Post"];
    self.mDataTV.layer.borderColor=[[UIColor lightTextColor] CGColor];
    self.mDataTV.layer.borderWidth=2.0;
    
    
}
-(void)saveButtonSelected
{
    if(![self.mDataTV isEqual:@""]&&![self.mRequestTypeTF isEqual:@""]&&![self.mNameTF isEqual:@""])
    {
        NSString * postId;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"PostNumber"]==nil)
        {
            NSMutableString *num=[[[NSUserDefaults standardUserDefaults] stringForKey:@"Name"]mutableCopy];
            [num appendString:@"0"];
            postId=[num mutableCopy];
            [[NSUserDefaults standardUserDefaults] setObject:postId forKey:@"PostNumber"];
        }
        else
        {
            NSString *ggg=[[NSUserDefaults standardUserDefaults] objectForKey:@"PostNumber"];
            NSString *numbers = [ggg stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
            NSMutableString *alphabets = [[ggg stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]]mutableCopy];

            NSInteger num=[numbers integerValue];
            num+=1;
            NSString *inStr = [@(num) stringValue];
            [alphabets appendString:inStr];
            postId=[alphabets mutableCopy];
        }
        PFObject *postRequest = [PFObject objectWithClassName:@"Posts"];
        [postRequest setObject:self.mRequestTypeTF.text forKey:@"Type"];
        [postRequest setObject:self.mNameTF.text forKey:@"Anonymous"];
        [postRequest setObject:self.mDataTV.text forKey:@"Post"];
        [postRequest setObject:@"0" forKey:@"Likes"];
        [postRequest setObject:@"" forKey:@"LikedPeople"];
        [postRequest setObject:postId  forKey:@"PostId"];
        [postRequest setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]  forKey:@"PostedBy"];
        
        [postRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded){
                NSLog(@"Object Uploaded!");
                UIStoryboard *mMS=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NewsFeedViewController *mPVC=[mMS instantiateViewControllerWithIdentifier:@"NewsFeedViewController"];
                [self.navigationController pushViewController:mPVC animated:YES];
            }
            else{
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error: %@", errorString);
            }
            
        }];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Cannot leave that empty!"
                                      message:@"Please enter all the fields."
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        [alert addAction:ok]; // add action to uialertcontroller
        [self presentViewController:alert animated:YES completion:nil];

    }
}
-(void)Back
{
    [self.navigationController popViewControllerAnimated:YES];
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
