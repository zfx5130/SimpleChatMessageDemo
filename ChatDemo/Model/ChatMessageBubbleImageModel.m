//
//  ChatMessageBubbleImageModel.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright (c) 2015年 thomas. All rights reserved.
//

#import "ChatMessageBubbleImageModel.h"

@implementation ChatMessageBubbleImageModel

- (instancetype)initWithMessageBubbleImage:(UIImage *)messageBubbleImage
             messageBubbleHighLightedImage:(UIImage *)messageBubbleHighlightedImage {
    self = [super init];
    if (self) {
        _messageBubbleImage = messageBubbleImage;
        _messageBubbleHighlightedImage = messageBubbleHighlightedImage;
    }
    return self;
}

- (NSString *)description {
    NSString *description =
    [NSString stringWithFormat:@"messageBubbleImage=%@\n messageBubbleHighlightedImage=%@\n", self.messageBubbleImage, self.messageBubbleHighlightedImage];
    return description;
}

@end
