//
//  Team.h
//  SportsProphet
//
//  Created by Vik Denic on 7/16/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Parse/Parse.h>

@interface Team : PFObject <PFSubclassing>

@property NSString *name;
@property NSString *conference;

@end
