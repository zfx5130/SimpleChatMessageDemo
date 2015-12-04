//
//  MessageTableViewCell.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    self.separatorInset = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

@end
