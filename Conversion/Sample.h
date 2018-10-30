//
//  Sample.h
//  Conversion
//
//  Created by l.jiang on 10/30/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface Sample : NSObject <PFSubclassing>
@property (nullable, nonatomic, strong) PFFile *videoFile;
@end

NS_ASSUME_NONNULL_END
