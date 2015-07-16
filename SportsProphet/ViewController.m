//
//  ViewController.m
//  SportsProphet
//
//  Created by Vik Denic on 7/7/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *teamsArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self sportsAPITokenRetrievalWithBlock:^(BOOL success, NSError *error) {

        [DataManager retrieveTeamswithBlock:^(NSArray *teams, NSError *error) {
            self.teamsArray = (NSMutableArray *) teams;
            [self.tableView reloadData];
        }];
    }];

    [self.tableView setEditing:YES animated:NO];
}

#pragma mark - tableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell"];
    Team *team = self.teamsArray[indexPath.row];

    cell.textLabel.text = team.name;
    cell.detailTextLabel.text = team.conference;

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

#pragma mark - helpers
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
