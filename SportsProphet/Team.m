//
//  Team.m
//  SportsProphet
//
//  Created by Vik Denic on 7/16/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "Team.h"

@implementation Team

@dynamic name;
@dynamic conference;
@dynamic record;
@dynamic rank;

+(NSString *)parseClassName
{
    return @"Team";
}

@end
