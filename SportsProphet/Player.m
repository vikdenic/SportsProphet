//
//  Player.m
//  SportsProphet
//
//  Created by Vik Denic on 7/10/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "Player.h"

@implementation Player

@dynamic fullName;
@dynamic uniformNumber;
@dynamic position;

+(NSString *)parseClassName
{
    return @"Profile";
}

@end
