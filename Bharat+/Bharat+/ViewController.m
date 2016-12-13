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
{
    UIPickerView *mPickerView;
    UIToolbar *mToolbar;
    NSArray *mPickerViewData;
    int selectedIndex;
}
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
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]==nil)
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonSelected)]];
    else
    {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postButtonClicked)]];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"View Posts" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonSelected)]];
        [self.view setUserInteractionEnabled:NO];
        [self retrieveNewsFeedFromServer];

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
-(void)viewPostsSelected
{
    
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
-(void)retrieveNewsFeedFromServer
{
    PFQuery *query = [PFQuery queryWithClassName:@"Register"];
    [query whereKey:@"personName" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                _mNameTF.text=[object valueForKey:@"personName"];
                _mGenderTF.text=[object valueForKey:@"gender"];
                _mAgeTF.text=[object valueForKey:@"age"];
                _mProfessionTF.text=[object valueForKey:@"profession"];
//                [object fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//                    
//                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark picker view delegates
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [mPickerViewData count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _mGenderTF.text=[mPickerViewData objectAtIndex:row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mPickerViewData objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat componentWidth = 0.0;
    componentWidth = self.view.bounds.size.width;
    return componentWidth;
}
-(void)initializeToolbar
{
    CGRect theToolRect = CGRectZero;
    theToolRect = CGRectMake(0, (self.view.frame.size.height-150 - 44), self.view.frame.size.width, 44);
    mToolbar = [[UIToolbar alloc] initWithFrame: theToolRect];
    mToolbar.barStyle = UIBarStyleBlackOpaque;
    mToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    mToolbar.barTintColor = [UIColor colorWithRed:108/255.0f green:108/255.0f blue:108/255.0f alpha:1.0f];
    UIButton *theDoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [theDoneButton setFrame:CGRectMake(0, 0, 50, 20)];
    [theDoneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [theDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [theDoneButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [theDoneButton addTarget:self action:@selector(donePressedFromPicker) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithCustomView: theDoneButton];
    
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    mToolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    [self.view addSubview: mToolbar];
    
}
-(void)donePressedFromPicker
{
    [self removePickerView];
}
-(IBAction)initializePicker
{
    [self.view endEditing:YES];
    mPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, self.view.bounds.size.width, 150)];
    [mPickerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [mPickerView setBackgroundColor:[UIColor lightGrayColor]];
    mPickerView.delegate = self;
    mPickerView.showsSelectionIndicator = YES;
    [self initializeToolbar];
    [self.view addSubview:mPickerView];
}
-(void)removePickerView
{
    if(mPickerView!=nil)
    {
        [mPickerView removeFromSuperview];
        mPickerView=nil;
    }
    if(mToolbar!=nil)
    {
        [mToolbar removeFromSuperview];
        mToolbar=nil;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self removePickerView];
    if(textField.tag==1)
    {
        mPickerViewData=[[NSArray alloc]initWithObjects:@"Name",@"Anonymous", nil];
        [self initializePicker];
        mPickerView.tag=textField.tag;
    }
    return YES;
}

@end
