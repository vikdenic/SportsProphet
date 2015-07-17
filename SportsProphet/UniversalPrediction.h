//
//  UniversalPrediction.h
//  SportsProphet
//
//  Created by Vik Denic on 7/17/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversalPrediction : NSObject {
    Prediction *prediction;
}

@property (nonatomic, retain) Prediction *prediction;

+ (UniversalPrediction *)sharedInstance;

@end