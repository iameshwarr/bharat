//
//  ViewController.m
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "ViewController.h"
#import "BharatQueryController.h"
#import <Parse/Parse.h>
#import "PostViewController.h"

@interface ViewController ()
@property(nonatomic,weak)IBOutlet UITextField *mNameTF;
@property(nonatomic,weak)IBOutlet UITextField *mAgeTF;
@property(nonatomic,weak)IBOutlet UITextField *mGenderTF;
@property(nonatomic,weak)IBOutlet UITextField *mProfessionTF;
@property(nonatomic,weak)IBOutlet UILabel *mPointsLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(testCode) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

//-(void)testCode
//{
//    BharatQueryController *controller=[BharatQueryController new];
//
//    RequestDTO *test=[RequestDTO new];
//    test.name=@"Eshwar";
//    test.requestType=@"Appreciation";
//    test.message=@"Toilet cleaned properly, congo!";
//    test.imageData=[NSData new];
//    [controller sendQueryToServer:test];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"] isEqualToString:@""])
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonSelected)]];
    else
    {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postButtonClicked)]];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonSelected)]];
    }
    [self.navigationItem setTitle:@"Profile"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)postButtonClicked
{
    UIStoryboard *mMS=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PostViewController *mPVC=[mMS instantiateViewControllerWithIdentifier:@"PostViewController"];
    [self.navigationController pushViewController:mPVC animated:YES];
}
-(void)saveButtonSelected
{
    if(_mNameTF.text.length>0 && _mGenderTF.text.length>0 && _mAgeTF.text.length>0 && _mProfessionTF.text.length>0)
    {
        [self.view endEditing:YES];
        PFObject *postRequest = [PFObject objectWithClassName:@"Register"];
        [postRequest setObject:_mNameTF.text forKey:@"personName"];
        [postRequest setObject:_mGenderTF.text forKey:@"gender"];
        [postRequest setObject:_mAgeTF.text forKey:@"age"];
        [postRequest setObject:_mProfessionTF.text forKey:@"profession"];
        [postRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded){
                [[NSUserDefaults standardUserDefaults] setObject:_mNameTF.text forKey:@"Name"];
                [self.view setUserInteractionEnabled:NO];
                [self postButtonClicked];
            }
            else{
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error: %@", errorString);
            }
            
        }];    }
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
@end
