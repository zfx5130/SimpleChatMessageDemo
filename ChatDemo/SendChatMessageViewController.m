//
//  SendChatMessageViewController.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import "SendChatMessageViewController.h"
#import "MessageData.h"
#import "ChatMessageDataModel.h"
#import "ChatMessageBubbleImageModel.h"
#import <JSQMessages.h>
#import <M13BadgeView.h>
#import "macro.h"

@interface SendChatMessageViewController ()
<JSQMessagesComposerTextViewPasteDelegate,
JSQMessagesCollectionViewDataSource,
JSQMessagesCollectionViewDelegateFlowLayout>

@property (strong, nonatomic) MessageData *messageData;

@end

@implementation SendChatMessageViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"某某某";
    [self setupViews];
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    [self setupNavigationBarItem];
}

- (void)setupNavigationBarItem {
    UIBarButtonItem *backButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_indicator"]
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)reloadData {
    
    self.messageData = [[MessageData alloc] init];
    self.senderId = kSenderAvatarId;
    self.senderDisplayName = kSenderAvatarImageName;
    self.inputToolbar.contentView.textView.pasteDelegate = self;
    self.inputToolbar.contentView.leftBarButtonItem = nil;
  //  self.collectionView.collectionViewLayout.springinessEnabled = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送"
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:107 / 255.0f
                                          green:124.0f / 255.0f
                                           blue:145.0f / 255.0f
                                          alpha:1.0f]
                 forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.inputToolbar.contentView.rightBarButtonItem = button;
    self.inputToolbar.contentView.textView.backgroundColor = [UIColor whiteColor];
    self.inputToolbar.contentView.textView.placeHolder = @"请输入评论";
    self.inputToolbar.contentView.textView.placeHolderTextColor =
    [UIColor colorWithRed:214.0f / 255.0f
                    green:224.0f / 255.0f
                     blue:223.0f / 255.0f
                    alpha:1.0f];
    //头像size
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(40.0f, 40.0f);
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeMake(40.0f, 40.0f);
//    self.showLoadEarlierMessagesHeader = YES;
    self.collectionView.backgroundColor = RGBColor(242.0f, 249.0f, 246.0f);
    //custom menu
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
    [UIMenuController sharedMenuController].menuItems = @[ [[UIMenuItem alloc] initWithTitle:@"Custom Action"
                                                                                      action:@selector(customAction:)] ];
    
    //delete action
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
}

#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date {
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    ChatMessageDataModel *message =
    [[ChatMessageDataModel alloc] initWithSenderId:senderId
                                 senderDisplayName:senderDisplayName
                                              date:date
                                              text:text];
    
    [self.messageData.messages addObject:message];
    [self finishSendingMessageAnimated:YES];
}

#pragma mark - JSQMessagesCollectionViewDataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.messageData.messages objectAtIndex:indexPath.item];
}

//删除
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
    didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
    [self.messageData.messages removeObjectAtIndex:indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView
             messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatMessageDataModel *message =
    [self.messageData.messages objectAtIndex:indexPath.item];
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.messageData.senderBubbleImageModel;
    }
    return self.messageData.receiverBubbleImageModel;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView
                    avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessageDataModel *message = [self.messageData.messages objectAtIndex:indexPath.item];
    
    return [self.messageData.avatars objectForKey:message.senderId];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.messageData.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
    attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = [self.messageData.messages objectAtIndex:indexPath.item];
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messageData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [self.messageData.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    ChatMessageDataModel *msg = [self.messageData.messages objectAtIndex:indexPath.item];
    if (!msg.isMediaMessage) {
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
#pragma mark - CustomMenuItems

- (BOOL)collectionView:(UICollectionView *)collectionView
      canPerformAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender {
    if (action == @selector(customAction:)) {
        return YES;
    }
    
    return [super collectionView:collectionView
                canPerformAction:action
              forItemAtIndexPath:indexPath
                      withSender:sender];
}

- (void)collectionView:(UICollectionView *)collectionView
         performAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender {
    if (action == @selector(customAction:)) {
        [self customAction:sender];
        return;
    }
    [super collectionView:collectionView
            performAction:action
       forItemAtIndexPath:indexPath
               withSender:sender];
}

#pragma mark - JSQMessages CollectionViewFlowLayoutDelegate
#pragma mark - AdjustingCellLabelHeights

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
    heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
    heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessageDataModel *currentMessage = [self.messageData.messages objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        return 0.0f;
    }
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messageData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            return 0.0f;
        }
    }
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
    heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0f;
}

#pragma mark - RespondingCollectionViewTapEvents

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView
    didTapLoadEarlierMessagesButton:(UIButton *)sender {
    NSLog(@"Load earlier messages!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapAvatarImageView:(UIImageView *)avatarImageView
           atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Tapped avatar!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
    didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Tapped message bubble!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapCellAtIndexPath:(NSIndexPath *)indexPath
         touchLocation:(CGPoint)touchLocation {
    NSLog(@"Tapped cell at %@!", NSStringFromCGPoint(touchLocation));
}

#pragma mark - JSQMessagesComposerTextViewPasteDelegate

- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView
   shouldPasteWithSender:(id)sender {
    if ([UIPasteboard generalPasteboard].image) {
        JSQPhotoMediaItem *item =
        [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:[NSDate date]
                                                             media:item];
        [self.messageData.messages addObject:message];
        [self finishSendingMessage];
        return NO;
    }
    return YES;
}

#pragma mark - Handlers

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Custom Action"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


@end
