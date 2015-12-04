//
//  MessageTableViewCell.h
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kReuseMessageTableViewCellIdentifier = @"kReuseMessageTableViewCellIdentifier";
static const CGFloat kDefaultMessageTableViewCellHeight = 120.0f;

@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *badgeView;

@end
