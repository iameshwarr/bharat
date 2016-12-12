//
//  BharatDTO.h
//  Bharat+
//
//  Created by Pavan on 12/12/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BharatDTO : NSObject

@end

@interface RequestDTO : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *requestType;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSData *imageData;
@end

@interface RegisterDTO : NSObject
@property(nonatomic,strong) NSString *personName;
@property(nonatomic,strong) NSString *gender;
@property(nonatomic,strong) NSString *age;
@property(nonatomic,strong) NSString *profession;
@end