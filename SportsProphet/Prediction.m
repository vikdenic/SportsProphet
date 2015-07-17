//
//  Prediction.m
//  SportsProphet
//
//  Created by Vik Denic on 7/17/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "Prediction.h"

@implementation Prediction

@dynamic user;
@dynamic eastRankings;
@dynamic westRankings;

+(NSString *)parseClassName
{
    return @"Prediction";
}

@end
