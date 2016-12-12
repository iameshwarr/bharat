//
//  BharatQueryController.m
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "BharatQueryController.h"
#import <Parse/Parse.h>

@implementation BharatQueryController

-(void)sendQueryToServer:(RequestDTO *)requestData
{
    PFObject *postRequest = [PFObject objectWithClassName:@"Request"];
    [postRequest setObject:requestData.name forKey:@"name"];
    [postRequest setObject:requestData.requestType forKey:@"requestType"];
    [postRequest setObject:requestData.message forKey:@"message"];
    [postRequest setObject:requestData.imageData forKey:@"imageData"];
    [postRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            NSLog(@"Object Uploaded!");
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
        
    }];
    
}

-(void)registerToServer:(RegisterDTO *)requestData
{
    PFObject *postRequest = [PFObject objectWithClassName:@"Register"];
    [postRequest setObject:requestData.personName forKey:@"personName"];
    [postRequest setObject:requestData.gender forKey:@"gender"];
    [postRequest setObject:requestData.age forKey:@"age"];
    [postRequest setObject:requestData.profession forKey:@"profession"];
    [postRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            NSLog(@"Object Uploaded!");
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
        
    }];
    
}


@end
