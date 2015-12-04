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

static const CGFloat kDefaultCollcetionCellTopLabelHeight = 20.0f;
static const CGFloat kDefaultCollectionBubbleTopLabelHeight = 20.0f;
static const CGFloat kDefaultCollectionBottomLabelHeight = 20.0f;
static const CGFloat kDefaultTimeInterval = 60.0f;

@interface SendChatMessageViewController ()
<JSQMessagesComposerTextViewPasteDelegate,
JSQMessagesCollectionViewDataSource,
JSQMessagesCollectionViewDelegateFlowLayout>

@property (strong, nonatomic) MessageData *messageData;

@property (assign, nonatomic) NSTimeInterval currentTimeInterval;

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
    [button setTitleColor:RGBColor(107.0f, 124.0f, 145.0f)
                 forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.inputToolbar.contentView.rightBarButtonItem = button;
    self.inputToolbar.contentView.textView.backgroundColor = [UIColor whiteColor];
    self.inputToolbar.contentView.textView.placeHolder = @"请输入评论";
    self.inputToolbar.contentView.textView.placeHolderTextColor = RGBColor(214.0f, 224.0f, 223.0f);
    //头像size
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(40.0f, 40.0f);
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeMake(40.0f, 40.0f);
    self.collectionView.backgroundColor = RGBColor(242.0f, 249.0f, 246.0f);
    
//custom menu
//    [JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
//    [UIMenuController sharedMenuController].menuItems = @[ [[UIMenuItem alloc] initWithTitle:@"Custom Action"
//                                                                                      action:@selector(customAction:)] ];
    
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
    
    ChatMessageDataModel *message = [self.messageData.messages objectAtIndex:indexPath.item];
    self.currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval chatReveiverTime = [message.date timeIntervalSince1970];
    if (self.currentTimeInterval - chatReveiverTime < kDefaultTimeInterval) {
        return nil;
    }
    return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
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
            cell.textView.textColor = RGBColor(120.0f, 139.0f, 160.0f);
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
            cell.messageBubbleTopLabel.text = nil;
        }
        cell.textView.font = [UIFont systemFontOfSize:16.0f];
        cell.cellTopLabel.textColor = RGBColor(179.0f, 192.0f, 207.0f);
        cell.cellTopLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)};
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
    return kDefaultCollcetionCellTopLabelHeight;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
    heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultCollectionBubbleTopLabelHeight;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
    heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultCollectionBottomLabelHeight;
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
