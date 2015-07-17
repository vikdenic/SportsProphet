//
//  LoginViewController.m
//  SportsProphet
//
//  Created by Vik Denic on 7/16/15.
//  Copyright (c) 2015 nektar labs. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onLoginButtonTapped:(UIButton *)sender
{
    if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        [User createUserWithUserName:self.usernameTextfield.text withPassword:self.passwordTextfield.text completion:^(BOOL result, NSError *error)
         {
             if (error == nil)
             {
                 [self dismissViewControllerAnimated:YES completion:^{

                 }];             }
             else
             {
                 [VZAlert showAlertWithTitle:@"Oops" message:error.localizedDescription viewController:self];
             }
         }];
    }
    else
    {
        [User logInWithUsernameInBackground:self.usernameTextfield.text password:self.passwordTextfield.text block:^(PFUser *user, NSError *error)
         {
             if (error == nil)
             {
                 [self dismissViewControllerAnimated:YES completion:^{

                 }];
             }
             else
             {
                 [VZAlert showAlertWithTitle:@"Oops" message:error.localizedDescription viewController:self];
             }
         }];
    }
}

@end
