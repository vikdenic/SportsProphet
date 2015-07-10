//
//  UniversalToken.m
//  SportsProphet
//
//  Created by Vik Denic on 7/10/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "UniversalToken.h"

@implementation UniversalToken

@synthesize token;

+ (UniversalToken *)sharedInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    //static id sharedObject = nil;  //if you're not using ARC
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
        //sharedObject = [[[self alloc] init] retain]; // if you're not using ARC
    });
    return sharedObject;
}

@end