//
//  SignUpLogInViewController.m
//  Conversion
//
//  Created by l.jiang on 10/15/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import "SignUpLogInViewController.h"
#import "TermsViewController.h"
#import "Parse/Parse.h"
#import "SVProgressHUD.h"

@interface SignUpLogInViewController ()
@property (nonatomic, weak) IBOutlet UITextField *signUpUserNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *signUpPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *signUpEmailTextField;

@property (nonatomic, weak) IBOutlet UITextField *loginUserNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *loginPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *loginEmailTextField;

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
    NSString *userName = [self.signUpUserNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.signUpPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [self.signUpEmailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    PFUser *user = [PFUser user];
    user.username = userName;
    user.password = password;
    
    if (email) {
        user.email = email;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [self saveLoggedInOrSignedUp];
            [self presentTermsViewController];
        } else {
             [SVProgressHUD showErrorWithStatus: [error localizedDescription]];
        }
    }];
}

-(IBAction)onLogin:(id)sender {
    NSString *userName = [self.loginUserNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.loginPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [self.loginEmailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [PFUser logInWithUsernameInBackground:userName password:password block:^(PFUser *user, NSError *error){
        if (!error) {
            [self saveLoggedInOrSignedUp];
            [self presentTermsViewController];
        } else {
            [SVProgressHUD showErrorWithStatus: [error localizedDescription]];
        }
    }];
}

- (IBAction)loginAsUser:(id)sender {
    
    
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversionNavController"];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}


- (void)saveLoggedInOrSignedUp {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)presentTermsViewController {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isAcceptedTerm"]) {
        TermsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraNavigationController"];
    }
}
@end
