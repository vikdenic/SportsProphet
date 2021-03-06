//
//  DataManager.h
//  SportsProphet
//
//  Created by Vik Denic on 7/9/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+(void)retrieveSportsAPITokenWithBlock:(void (^)(BOOL success, NSError *error))completion;

+(void)retrieveTeamswithBlock:(void (^)(NSArray *teams, NSError *error))completion;

+(void)retrieverRosterForTeam:(NSString *)team withBlock:(void (^)(NSArray *players, NSError *error))completion;

+(void)retrieveStandingsWithBlock:(void (^)(NSArray *teams, NSError *error))completion;

+(void)retrieve2015DraftPicksWithBlock:(void (^)(NSArray *players, NSError *error))completion;

@end
