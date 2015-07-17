//
//  User.m
//  SportsProphet
//
//  Created by Vik Denic on 7/16/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "User.h"

@implementation User

+(void)load
{
    [self registerSubclass];
}

+(User *)currentUser
{
    return (User *)[PFUser currentUser];
}

+(void)createUserWithUserName:(NSString *)username withPassword:(NSString *)password completion:(void (^)(BOOL, NSError *))completionHandler
{
    User *user = [[User alloc] initWithUsername:username withPassword:password];

    Prediction *prediction = [Prediction new];
    prediction.user = [User currentUser];
    [UniversalPrediction sharedInstance].prediction = prediction;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [prediction saveInBackground];
        completionHandler(succeeded, error);
    }];
}

-(instancetype)initWithUsername:(NSString *)username withPassword: (NSString *)password
{
    self = [super init];
    self.username = username;
    self.password = password;
    return self;
}

@end
