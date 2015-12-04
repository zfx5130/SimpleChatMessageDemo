//
//  ChatAvatarImageModel.h
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright (c) 2015年 thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSQMessages.h>

@interface ChatAvatarImageModel : NSObject <JSQMessageAvatarImageDataSource>

/**
 *  The avatar image for a regular display state.
 */
@property (strong, nonatomic) UIImage *avatarImage;

/**
 *  The avatar image for a highlight display state.
 */
@property (strong, nonatomic) UIImage *avatarHighlightedImage;

/**
 *  the placeholder avatar image
 */
@property (strong, nonatomic) UIImage *avatarPlaceholderImage;

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage
                   highlightedImage:(UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage;
@end
