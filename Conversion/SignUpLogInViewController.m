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
@end

@implementation SignUpLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isUser = NO;
    self.signUpPasswordTextField.secureTextEntry = YES;
    self.loginPasswordTextField.secureTextEntry = YES;
}

-(IBAction)onSignUpAsUser:(id)sender {
    self.isUser = YES;
    [self onSignUp:nil];
}


-(IBAction)onSignUp:(id)sender {
    NSString *userName = [self.signUpUserNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.signUpPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [self.signUpEmailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    PFUser *user = [PFUser user];
    user.username = userName;
    user.password = password;
    user[@"isUser"] = @(self.isUser);
    
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
    if ([PFUser currentUser]) {
        UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversionNavController"];
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    } else {
         [SVProgressHUD showErrorWithStatus: @"Register or Log In first"];
    }
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


#pragma mark Keyboard

//- (void)_dismissKeyboard {
//    [self.view endEditing:YES];
//}
//
//- (void)_registerForKeyboardNotifications {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(_keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(_keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)_keyboardWillShow:(NSNotification *)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//
//    CGRect keyboardFrame = [self.view convertRect:endFrame fromView:self.view.window];
//    CGFloat visibleKeyboardHeight = CGRectGetMaxY(self.view.bounds) - CGRectGetMinY(keyboardFrame);
//
//    [self setVisibleKeyboardHeight:visibleKeyboardHeight
//                 animationDuration:duration
//                  animationOptions:curve << 16];
//}
//
//- (void)_keyboardWillHide:(NSNotification *)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    [self setVisibleKeyboardHeight:0.0
//                 animationDuration:duration
//                  animationOptions:curve << 16];
//}
//
//- (void)setVisibleKeyboardHeight:(CGFloat)visibleKeyboardHeight
//               animationDuration:(NSTimeInterval)animationDuration
//                animationOptions:(UIViewAnimationOptions)animationOptions {
//
//    dispatch_block_t animationsBlock = ^{
//        self.visibleKeyboardHeight = visibleKeyboardHeight;
//    };
//
//    if (animationDuration == 0.0) {
//        animationsBlock();
//    } else {
//        [UIView animateWithDuration:animationDuration
//                              delay:0.0
//                            options:animationOptions | UIViewAnimationOptionBeginFromCurrentState
//                         animations:animationsBlock
//                         completion:nil];
//    }
//}
//
//- (void)setVisibleKeyboardHeight:(CGFloat)visibleKeyboardHeight {
//    if (self.visibleKeyboardHeight != visibleKeyboardHeight) {
//        _visibleKeyboardHeight = visibleKeyboardHeight;
//        [self _updateSignUpViewContentOffsetAnimated:NO];
//    }
//}
//
//- (void)_updateSignUpViewContentOffsetAnimated:(BOOL)animated {
//    CGPoint contentOffset = CGPointZero;
//    if (self.visibleKeyboardHeight > 0.0f) {
//        // Scroll the view to keep fields visible
//        CGFloat offsetForScrollingTextFieldToTop = CGRectGetMinY([self _currentFirstResponder].frame);
//
//        UIView *lowestView;
//        if (_signUpView.signUpButton) {
//            lowestView = _signUpView.signUpButton;
//        } else if (_signUpView.additionalField) {
//            lowestView = _signUpView.additionalField;
//        } else if (_signUpView.emailField) {
//            lowestView = _signUpView.emailField;
//        } else {
//            lowestView = _signUpView.passwordField;
//        }
//
//        CGFloat offsetForScrollingLowestViewToBottom = 0.0f;
//        offsetForScrollingLowestViewToBottom += self.visibleKeyboardHeight;
//        offsetForScrollingLowestViewToBottom += CGRectGetMaxY(lowestView.frame);
//        offsetForScrollingLowestViewToBottom -= CGRectGetHeight(_signUpView.bounds);
//
//        if (offsetForScrollingLowestViewToBottom < 0) {
//            return; // No scrolling required
//        }
//
//        contentOffset = CGPointMake(0.0f, MIN(offsetForScrollingTextFieldToTop,
//                                              offsetForScrollingLowestViewToBottom));
//    }
//
//    [_signUpView setContentOffset:contentOffset animated:animated];
//}

@end
