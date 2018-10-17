//
//  ModelController.h
//  Conversion
//
//  Created by l.jiang on 10/15/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;
@class AVCamCameraViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

//- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
//- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

- (AVCamCameraViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(AVCamCameraViewController *)viewController;

@end

