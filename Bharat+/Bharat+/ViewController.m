//
//  ViewController.m
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "ViewController.h"
#import "BharatQueryController.h"

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
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(testCode) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)testCode
{
    BharatQueryController *controller=[BharatQueryController new];

    RequestDTO *test=[RequestDTO new];
    test.name=@"Eshwar";
    test.requestType=@"Appreciation";
    test.message=@"Toilet cleaned properly, congo!";
    test.imageData=[NSData new];
    [controller sendQueryToServer:test];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonSelected)]];
    [self.navigationItem setTitle:@"Profile"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveButtonSelected
{
    if(_mNameTF.text.length>0 && _mGenderTF.text.length>0 && _mAgeTF.text.length>0 && _mProfessionTF.text.length>0)
    {
        BharatQueryController *controller=[BharatQueryController new];
        RegisterDTO *test=[RegisterDTO new];
        test.personName=_mNameTF.text;
        test.gender=_mGenderTF.text;
        test.age=_mAgeTF.text;
        test.profession=_mProfessionTF.text;
        [controller registerToServer:test];
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
@end
