//
//  UIImage+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color
                              size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)QRCodeImageFromContent:(NSString *)content
                               size:(CGSize)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data
              forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1.0f
                                   orientation:UIImageOrientationUp];
    
    
    UIGraphicsBeginImageContext(size);
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(resizedContext, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return resizedImage;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter =
    [CIFilter filterWithName:@"CIGaussianBlur"
               keysAndValues:kCIInputImageKey, inputImage,@"inputRadius", @(blur),nil];
    
    CIImage *outputImage = filter.outputImage;
    CGImageRef outImage = [context createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

@end
