//
//  BharatQueryController.h
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BharatDTO.h"

@interface BharatQueryController : NSObject
-(void)sendQueryToServer:(RequestDTO *)requestData;
-(void)registerToServer:(RegisterDTO *)requestData;
-(void)retrieveNewsFeedFromServer:(BOOL)me;
@end
