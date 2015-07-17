//
//  Prediction.h
//  SportsProphet
//
//  Created by Vik Denic on 7/17/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Parse/Parse.h>

@interface Prediction : PFObject <PFSubclassing>

@property User *user;
@property NSArray *eastRankings;
@property NSArray *westRankings;

+(NSString *)parseClassName;

@end
