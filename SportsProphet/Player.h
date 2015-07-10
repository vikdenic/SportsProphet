//
//  Player.h
//  SportsProphet
//
//  Created by Vik Denic on 7/10/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Parse/Parse.h>

@interface Player : PFObject <PFSubclassing>

@property NSString *firstName;
@property NSString *lastName;

+(NSString *)parseClassName;

@end
