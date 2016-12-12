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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
