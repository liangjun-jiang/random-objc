//
//  SignUpLogInViewController.m
//  Conversion
//
//  Created by l.jiang on 10/15/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import "SignUpLogInViewController.h"
#import "TermsViewController.h"

@interface SignUpLogInViewController ()

@end

@implementation SignUpLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)onSignUp:(id)sender {
    [self saveLoggedInOrSignedUp];
    [self presentTermsViewController];
}

-(IBAction)onLogin:(id)sender {
    [self saveLoggedInOrSignedUp];
    [self presentTermsViewController];
}

- (void)saveLoggedInOrSignedUp {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)presentTermsViewController {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isAcceptedTerm"]) {
        TermsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
