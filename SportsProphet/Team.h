//
//  Team.h
//  SportsProphet
//
//  Created by Vik Denic on 7/16/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Parse/Parse.h>

typedef NS_ENUM(NSInteger, Conference) {
    EasternConference,
    WesternConference,
};

@interface Team : PFObject <PFSubclassing>

@property NSString *fullName;
@property NSString *conference;
@property NSString *record;
@property NSInteger rank;
@property NSString *team_id;

+(NSArray *)getStandingsForConference:(Conference)conference;

@end
