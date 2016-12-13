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
{
    UIPickerView *mPickerView;
    UIToolbar *mToolbar;
    NSArray *mPickerViewData;
    int selectedIndex;
}
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
}
-(void)saveButtonSelected
{
    [self.view endEditing:YES];
    [self removePickerView];
    if(![self.mDataTV.text isEqualToString:@""]&&![self.mRequestTypeTF.text isEqualToString:@""]&&![self.mNameTF.text isEqualToString:@""])
    {
        PFObject *postRequest = [PFObject objectWithClassName:@"Posts"];
        [postRequest setObject:self.mRequestTypeTF.text forKey:@"Type"];
        
        if([self.mNameTF.text isEqualToString:@"Anonymous"])
            [postRequest setObject:@"Y" forKey:@"Anonymous"];
        else
            [postRequest setObject:@"N" forKey:@"Anonymous"];
        
        [postRequest setObject:self.mDataTV.text forKey:@"Post"];
        [postRequest setObject:@"0" forKey:@"Likes"];
        [postRequest setObject:@"" forKey:@"LikedPeople"];
        [postRequest setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]  forKey:@"PostedBy"];
        
        [postRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded){
                NSLog(@"Object Uploaded!");
                UIStoryboard *mMS=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NewsFeedViewController *mPVC=[mMS instantiateViewControllerWithIdentifier:@"NewsFeedViewController"];
                [self.navigationController pushViewController:mPVC animated:YES];
                _mNameTF.text=@"";
                _mRequestTypeTF.text=@"";
                _mDataTV.text=@"";
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
    if(mPickerView.tag==0)
    {
        if([[mPickerViewData objectAtIndex:row] isEqualToString:@"Name"])
            _mNameTF.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
        else
            _mNameTF.text=[mPickerViewData objectAtIndex:row];
    }
    else
        _mRequestTypeTF.text=[mPickerViewData objectAtIndex:row];
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
    if(textField.tag==0)
    {
        mPickerViewData=[[NSArray alloc]initWithObjects:@"Name",@"Anonymous", nil];
    }
    else
    {
        mPickerViewData=[[NSArray alloc]initWithObjects:@"Request",@"Appreciation",@"Query/Suggestion", nil];
    }
    [self initializePicker];
    mPickerView.tag=textField.tag;
    return NO;
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
