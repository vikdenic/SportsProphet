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

    if (!self.conference)
    {
        self.conference = EasternConference;
    }

    self.teamsArray = [NSMutableArray arrayWithArray:[Team getStandingsForConference:self.conference]];
    [self.tableView reloadData];

    [self.tableView setEditing:YES animated:NO];
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell"];
    Team *team = self.teamsArray[indexPath.row];

    cell.textLabel.text = team.fullName;
    cell.detailTextLabel.text = team.record;

    if (indexPath.row < 8)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%i - %@", indexPath.row + 1, team.fullName];
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
    if (self.conference == EasternConference)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        RankYourNBATeamsViewController *rankTheWestVC = [storyboard instantiateViewControllerWithIdentifier:@"RankYourNBATeamsViewController"];

        rankTheWestVC.conference = WesternConference;

        [self.navigationController pushViewController:rankTheWestVC animated:YES];
    }

    [self savePredictions];
}

#pragma mark - helpers
-(void)savePredictions
{
    Prediction *prediction = [UniversalPrediction sharedInstance].prediction;

    if (self.conference == EasternConference)
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
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"xmlStatsToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            NSLog(@"%@", error);
        }

        completion(YES, error);
    }];
}

@end
