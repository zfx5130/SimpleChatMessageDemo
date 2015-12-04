//
//  ChatAvatarImageModel.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright (c) 2015年 thomas. All rights reserved.
//

#import "ChatAvatarImageModel.h"

@implementation ChatAvatarImageModel

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage
                   highlightedImage:(UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage {
    self = [super init];
    if (self) {
        _avatarImage = avatarImage;
        _avatarHighlightedImage = highlightedImage;
        _avatarPlaceholderImage = placeholderImage;
    }
    return self;
}

- (NSString *)description {
    NSString *description =
    [NSString stringWithFormat:@"avatarImage=%@\n avatarHightlightImage=%@\n avatarPlaceholderImage=%@\n ",
     self.avatarImage,
     self.avatarHighlightedImage,
     self.avatarPlaceholderImage];
    return description;
}


@end
