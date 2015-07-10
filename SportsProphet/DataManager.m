//
//  DataManager.m
//  SportsProphet
//
//  Created by Vik Denic on 7/9/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+(void)retreiveTeamswithBlock:(void (^)(NSArray *teams, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:@"https://erikberg.com/nba/teams.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

+(void)retrieve2015DraftPicksWithBlock:(void (^)(NSArray *players, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager.requestSerializer setValue:@"Bearer fdb914cc-9de6-43f0-a277-114ea44d7443" forHTTPHeaderField:@"Authorization"];
    NSDictionary *paramaters = @{@"season" : @"2015"};

    [manager GET:@"https://erikberg.com/nba/draft.json" parameters:paramaters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

@end
