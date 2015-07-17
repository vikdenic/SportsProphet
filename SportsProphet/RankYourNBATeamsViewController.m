//
//  ViewController.m
//  SportsProphet
//
//  Created by Vik Denic on 7/7/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "RankYourNBATeamsViewController.h"

@interface RankYourNBATeamsViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *teamsArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RankYourNBATeamsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([User currentUser] == nil)
    {
        [self performSegueWithIdentifier:kSegueNotLoggedIn sender:self];
    }

    self.teamsArray = [NSMutableArray new];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    if (self.conference == nil)
    {
        self.conference = @"EAST";
    }

    [self sportsAPITokenRetrievalWithBlock:^(BOOL success, NSError *error) {

        [DataManager retrieveStandingsWithBlock:^(NSArray *teams, NSError *error) {

            //Keep only Eastern Conference teams in the array
            for (Team *team in teams)
            {
                if ([team.conference isEqualToString:self.conference])
                {
                    [self.teamsArray addObject:team];
                }
            }

            [self.tableView reloadData];
        }];
    }];

    [self.tableView setEditing:YES animated:NO];

    [self getStandings];
}

-(void)getStandings
{
    [DataManager retrieveStandingsWithBlock:^(NSArray *teams, NSError *error) {
        NSLog(@"%@", teams);
    }];
}

#pragma mark - tableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell"];
    Team *team = self.teamsArray[indexPath.row];

    cell.textLabel.text = team.name;
    cell.detailTextLabel.text = team.record;

    if (indexPath.row < 8)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%d - %@", indexPath.row + 1, team.name];
    }

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.teamsArray.count;
}

#pragma mark - tableView delegate
//Enables draggability of celss
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Team *teamToMove = self.teamsArray[sourceIndexPath.row];
    [self.teamsArray removeObjectAtIndex:sourceIndexPath.row];
    [self.teamsArray insertObject:teamToMove atIndex:destinationIndexPath.row];

    [self.tableView reloadData];
}

//Removes deletion when in editing mode
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Actions
- (IBAction)onNextBarButtonTapped:(UIBarButtonItem *)sender
{
    if ([self.conference isEqualToString: @"EAST"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        RankYourNBATeamsViewController *rankTheWestVC = [storyboard instantiateViewControllerWithIdentifier:@"RankYourNBATeamsViewController"];

        rankTheWestVC.conference = @"WEST";

        [self.navigationController pushViewController:rankTheWestVC animated:YES];
    }

    [self savePredictions];
}

#pragma mark - helpers
-(void)savePredictions
{
    Prediction *prediction = [UniversalPrediction sharedInstance].prediction;

    if ([self.conference isEqualToString: @"EAST"])
    {
        prediction.eastRankings = self.teamsArray;
    }
    else
    {
        prediction.westRankings = self.teamsArray;
    }

    [prediction saveInBackground];
}

-(void)sportsAPITokenRetrievalWithBlock:(void (^)(BOOL success, NSError *error))completion;
{
    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {

        if (error == nil)
        {
            NSString *token = config[@"xmlstatsToken"];
            [UniversalToken sharedInstance].token = token;
            NSLog(@"xmlstats token: %@", token);
        }
        else
        {
            NSLog(@"%@", error);
        }

        completion(YES, error);
    }];
}

@end
