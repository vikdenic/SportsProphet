//
//  DataManager.m
//  SportsProphet
//
//  Created by Vik Denic on 7/9/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+(void)retrieveTeamswithBlock:(void (^)(NSArray *teams, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:@"https://erikberg.com/nba/teams.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *newTeamsArray = [NSMutableArray new];
        NSArray *teamsArray = responseObject;

        for (NSDictionary *team in teamsArray)
        {
            Team *newTeam = [Team new];

            newTeam.fullName = [team objectForKey:@"full_name"];
            newTeam.conference = [team objectForKey:@"conference"];

            [newTeamsArray addObject:newTeam];
        }

//        NSLog(@"JSON: %@", newTeamsArray);
        completion(newTeamsArray, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

+(void)retrieverRosterForTeam:(NSString *)team withBlock:(void (^)(NSArray *players, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *tokenString = [NSString stringWithFormat:@"Bearer %@", [UniversalToken sharedInstance].token];

    [manager.requestSerializer setValue:tokenString forHTTPHeaderField:@"Authorization"];

    NSString *urlString = [NSString stringWithFormat:@"https://erikberg.com/nba/roster/%@.json", team];

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *newPlayersArray = [NSMutableArray new];
        NSArray *playersArray = [responseObject valueForKey:@"players"];

        for (NSDictionary *player in playersArray)
        {
            Player *newPlayer = [Player new];

            newPlayer.fullName = [player objectForKey:@"display_name"];
            newPlayer.uniformNumber = [[player objectForKey:@"uniform_number"] stringValue];
            newPlayer.position = [player objectForKey:@"position"];

            [newPlayersArray addObject:newPlayer];
        }

//        NSLog(@"JSON: %@", responseObject);
        completion(newPlayersArray, nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

+(void)retrieveStandingsWithBlock:(void (^)(NSArray *teams, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

//    NSString *tokenString = [NSString stringWithFormat:@"Bearer %@", [UniversalToken sharedInstance].token];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"xmlStatsToken"];
    NSString *tokenString = [NSString stringWithFormat:@"Bearer %@", token];

    [manager.requestSerializer setValue:tokenString forHTTPHeaderField:@"Authorization"];

    [manager GET:@"https://erikberg.com/nba/standings.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *teamsArray = [NSMutableArray new];

        for (NSDictionary *standing in responseObject[@"standing"])
        {
            Team *team = [Team new];

            team.fullName = [NSString stringWithFormat:@"%@ %@", [standing objectForKey:@"first_name"], [standing objectForKey:@"last_name"]];
            team.conference = [standing objectForKey:@"conference"];
            team.rank = [standing objectForKey:@"rank"];
            team.team_id = [standing objectForKey:@"team_id"];

            NSString *record = [NSString stringWithFormat:@"%@ - %@", [standing objectForKey:@"won"], [standing objectForKey:@"lost"]];
            team.record = record;

            [teamsArray addObject:team];
        }
//        NSLog(@"JSON: %@", responseObject);
        completion(teamsArray, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completion(nil, error);
    }];
}

+(void)retrieve2015DraftPicksWithBlock:(void (^)(NSArray *players, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *tokenString = [NSString stringWithFormat:@"Bearer %@", [UniversalToken sharedInstance].token];

    [manager.requestSerializer setValue:tokenString forHTTPHeaderField:@"Authorization"];
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
