//
//  SportsProphetTests.m
//  SportsProphetTests
//
//  Created by Vik Denic on 7/7/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DataManager.h"

@interface SportsProphetTests : XCTestCase

@end

@implementation SportsProphetTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//-(void)testXMLStatsTokenRetrieval
//{
//    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {
//        NSString *token = config[@"xmlstatsToken"];
//        NSLog(@"%@", token);
//    }];
//}

-(void)testTeamsRetrieval
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];

    [DataManager retreiveTeamswithBlock:^(NSArray *teams, NSError *error) {
        XCTAssertNotNil(teams);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:6.0 handler:nil];
}

-(void)testDraftRetrieval
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];

    [DataManager retrieve2015DraftPicksWithBlock:^(NSArray *players, NSError *error) {
        XCTAssertNotNil(players);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:6.0 handler:nil];
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
