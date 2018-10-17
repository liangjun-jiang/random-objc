//
//  DataViewController.m
//  Conversion
//
//  Created by l.jiang on 10/15/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, assign) int initSecs;
@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.initSecs = 10;
    self.instructionLabel.text =  self.dataObject[@"instruction"];
}

- (IBAction)onCancel:(id)sender {
    NSLog(@"canceled");
}

- (IBAction)onRecord:(id)sender {
    if (self.countdownTimer!=nil) self.countdownTimer = nil;
    self.countdownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop] addTimer:self.countdownTimer forMode:NSRunLoopCommonModes];
}

- (void)countdown:(id)data {
    NSLog(@"should be counting");
    self.dataLabel.text = [NSString stringWithFormat:@"%d sec",self.initSecs--];
    if (self.initSecs <= 0) {
        //todo: move to the next one
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
    }
}
@end
