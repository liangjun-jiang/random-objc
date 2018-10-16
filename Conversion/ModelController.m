//
//  ModelController.m
//  Conversion
//
//  Created by l.jiang on 10/15/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *samplePageData;
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        
        _samplePageData = @[@{@"index":@0, @"title":@"Stage 1: Video Collection", @"instruction":@"Step 1: Please put your face in the circle"},
                            @{@"index":@1, @"title":@"Stage 2: ", @"instruction":@"Step 2: Play your video"}];
  
        _pageData = @[
                     @{@"index":@0, @"instruction":@"Please keep calm on your face and press the record button and hold for 10 sec (do not talk)"},
                     @{@"index":@1, @"instruction":@"Please keep smile on your face and press the record button and hold for 10 sec (do not talk)"},
                     @{@"index":@2, @"instruction":@"Please keep unhappy on your face and press the record button and hold for 10 sec (do not talk)"},
                     @{@"index":@3, @"instruction":@"Please keep angry on your face and press the record button and hold for 10 sec (do not talk)"},
                     @{@"index":@4, @"instruction":@"Please keep surprise on your face and press the record button and hold for 10 sec (do not talk)"},
                     @{@"index":@5, @"instruction":@"Please keep sad on your face and press the record button and hold for 10 sec (do not talk)"},
                     @{@"index":@6, @"instruction":@"Please keep calm on your face and keep talking with your mouth moving but don't make any sound and press the record button and hold for 10 sec "},
                     @{@"index":@7, @"instruction":@"Please keep smile on your face and keep talking with your mouth moving but don't make any sound and press the record button and hold for 10 sec"},
                     @{@"index":@8, @"instruction":@"Please keep unhappy on your face and keep talking with your mouth moving but don't make any sound and press the record button and hold for 10 sec"},
                     @{@"index":@9, @"instruction":@"Please keep angry emotion on your face and keep talking with your mouth moving but don't make any sound and press the record button and hold for 10 sec"},
                     @{@"index":@10, @"instruction":@"Please keep surprise emotion on your face and keep talking with your mouth moving but don't make any sound and press the record button and hold for 10 sec"},
                     @{@"index":@11, @"instruction":@"Please keep sad emotion on your face and keep talking with your mouth moving but don't make any sound and press the record button and hold for 10 sec"}
                     ];
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}


- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
