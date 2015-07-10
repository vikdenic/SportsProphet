//
//  UniversalToken.h
//  SportsProphet
//
//  Created by Vik Denic on 7/10/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversalToken : NSObject {
    NSString *token;
}

@property (nonatomic, retain) NSString *token;

+ (UniversalToken *)sharedInstance;

@end