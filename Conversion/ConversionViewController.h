//
//  ConversionViewController.h
//  Conversion
//
//  Created by l.jiang on 10/19/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class AAPLPlayerView;

@interface ConversionViewController : UIViewController
@property (readonly) AVPlayer *player;
@property AVURLAsset *asset;

@property CMTime currentTime;
@property (readonly) CMTime duration;
@property float rate;

@property (weak) IBOutlet AAPLPlayerView *playerView;
@property (weak) IBOutlet UIButton *playPauseButton;
@end

NS_ASSUME_NONNULL_END
