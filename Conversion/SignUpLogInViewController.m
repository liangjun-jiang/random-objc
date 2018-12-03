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

@interface SignUpLogInViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *signUpUserNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *signUpPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *signUpEmailTextField;

@property (nonatomic, weak) IBOutlet UITextField *loginUserNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *loginPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *loginEmailTextField;

@property (nonatomic, assign) CGFloat visibleKeyboardHeight;

@property (nonatomic, assign) bool isUser;
@end

@implementation SignUpLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.signUpPasswordTextField.secureTextEntry = YES;
    self.loginPasswordTextField.secureTextEntry = YES;
}

-(IBAction)onSignUpAsUser:(id)sender {
    self.isUser = true;
    [self onSignUp:nil];
}
    

-(IBAction)onSignUp:(id)sender {
    NSString *userName = [self.signUpUserNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.signUpPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [self.signUpEmailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    PFUser *user = [PFUser user];
    user.username = userName;
    user.password = password;
    user[@"isUser"] = @(YES);
    
    if (email) {
        user.email = email;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [self saveLoggedInOrSignedUp];
            if (self.isUser) {
                [self presentUserInterface];
            } else {
                [self presentTermsViewController];
            }
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
            if (user[@"isUser"]) {
                [self presentUserInterface];
            } else
                [self presentTermsViewController];
        } else {
            [SVProgressHUD showErrorWithStatus: [error localizedDescription]];
        }
    }];
}

- (IBAction)loginAsUser:(id)sender {
    self.isUser = true;
    [self onLogin:nil];
}

-(void)presentUserInterface {
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversionNavController"];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}


- (void)saveLoggedInOrSignedUp {
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

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 100 || textField.tag == 101) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
     if (textField.tag == 100 || textField.tag == 101) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:TRUE];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +200., self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
     }
}


@end
