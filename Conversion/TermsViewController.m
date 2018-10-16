//
//  TermsViewController.m
//  Conversion
//
//  Created by l.jiang on 10/15/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *disclaimer = @"Disclaimer: This app will collect the user's personal video and voice. I (the user) agree that the develper and the company will process and save the video and voice and personal information. The developer and the company promise not to personalize the video and voice of the user's personal information";
    
    self.termsTextView.text = disclaimer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)onAgree:(id)sender {
    [self saveUserChoice:YES];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
}

-(IBAction)onNotAgree:(id)sender {
    [self saveUserChoice:NO];
}

- (void)saveUserChoice:(BOOL)choice {
    [[NSUserDefaults standardUserDefaults] setBool:choice forKey:@"isAcceptedTerm"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
