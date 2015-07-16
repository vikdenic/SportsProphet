//
//  ViewController.m
//  SportsProphet
//
//  Created by Vik Denic on 7/7/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self sportsAPITokenRetrievalWithBlock:^(BOOL success, NSError *error) {
        [DataManager retrieverRosterForTeam:kChicagoBulls withBlock:^(NSArray *players, NSError *error) {
            NSLog(@"%@", players);
        }];
    }];
}

-(void)sportsAPITokenRetrievalWithBlock:(void (^)(BOOL success, NSError *error))completion;
{
    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {

        if (error == nil)
        {
            NSString *token = config[@"xmlstatsToken"];
            [UniversalToken sharedInstance].token = token;
            NSLog(@"xmlstats token: %@", token);
        }
        else
        {
            NSLog(@"%@", error);
        }

        completion(YES, error);
    }];
}

@end
