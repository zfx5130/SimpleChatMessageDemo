//
//  ChatMessageBubbleImageModel.h
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright (c) 2015年 thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSQMessages.h>

@interface ChatMessageBubbleImageModel : NSObject <JSQMessageBubbleImageDataSource>

/**
 *  The message bubble image for a regular display state.
 */
@property (strong, nonatomic) UIImage *messageBubbleImage;

/**
 *  The message bubble image for a highlight display state.
 */
@property (strong, nonatomic) UIImage *messageBubbleHighlightedImage;

- (instancetype)initWithMessageBubbleImage:(UIImage *)messageBubbleImage
             messageBubbleHighLightedImage:(UIImage *)messageBubbleHighlightedImage;

@end
