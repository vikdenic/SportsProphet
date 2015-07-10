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
#import "Parse.h"

@interface SportsProphetTests : XCTestCase

@end

@implementation SportsProphetTests

- (void)setUp
{
    [super setUp];
    [self parseSetup];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testXMLStatsTokenRetrieval
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing token retrieval"];

    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {
        NSString *token = config[@"xmlstatsToken"];
        XCTAssertNotNil(token);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:6.0 handler:nil];
}

-(void)testTeamsRetrieval
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing teams retrieval"];

    [DataManager retreiveTeamswithBlock:^(NSArray *teams, NSError *error) {
        XCTAssertNotNil(teams);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:6.0 handler:nil];
}

-(void)testDraftRetrieval
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing draft picks retrieval"];

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

-(void)parseSetup
{
    //Private Keys in Keys.plist (hidden via gitignore)
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"]];
    NSString *applicationId = [dictionary objectForKey:@"ParseAppID"];
    NSString *clientKey = [dictionary objectForKey:@"ParseClientKey"];

    [Parse setApplicationId:applicationId
                  clientKey:clientKey];
}

@end
