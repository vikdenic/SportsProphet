//
//  Team.m
//  SportsProphet
//
//  Created by Vik Denic on 7/16/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "Team.h"

@implementation Team

@dynamic fullName;
@dynamic conference;
@dynamic record;
@dynamic rank;
@dynamic team_id;

+(NSString *)parseClassName
{
    return @"Team";
}

+(NSArray *)getStandingsForConference:(Conference)conference
{
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"NBA_Standings_14-15" withExtension:@"plist"];
    NSArray *standingsArray = [NSArray arrayWithContentsOfURL:path];

    NSMutableArray *teamsArray = [NSMutableArray new];

    NSString *conferenceString;

    if (conference == EasternConference)
    {
        conferenceString = @"EAST";
    }
    else
    {
        conferenceString = @"WEST";
    }

    for (NSDictionary *dict in standingsArray)
    {
        if ([dict[@"conference"] isEqualToString:conferenceString])
        {
            Team *team = [Team new];

            team.fullName = dict[@"full_name"];
            team.conference = dict[@"conference"];
            team.rank = (NSInteger) dict[@"rank"];
            team.team_id = dict[@"team_id"];
            team.record = dict[@"record"];

            [teamsArray addObject:team];
        }
    }

    return teamsArray;
}

@end
