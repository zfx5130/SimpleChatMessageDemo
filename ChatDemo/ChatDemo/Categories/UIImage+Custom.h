//
//  UIImage+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Custom)

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)QRCodeImageFromContent:(NSString *)content
                               size:(CGSize)size;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

+ (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur;

@end
