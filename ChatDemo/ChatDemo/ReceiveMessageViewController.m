//
//  ReceiveMessageViewController.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import "ReceiveMessageViewController.h"
#import "SendChatMessageViewController.h"

#import "MessageTableViewCell.h"
#import "macro.h"

#import "UIImage+Custom.h"
#import <M13BadgeView.h>

@interface ReceiveMessageViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) M13BadgeView *m13BadgeView;

@end

@implementation ReceiveMessageViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收到的私信";
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private 

- (void)setupViews {
    [self registerTableViewCell];
    [self setupNavigation];
}

- (void)registerTableViewCell {
    UINib *messageCellNib =
    [UINib nibWithNibName:NSStringFromClass([MessageTableViewCell class])
                   bundle:nil];
    [self.tableView registerNib:messageCellNib
         forCellReuseIdentifier:kReuseMessageTableViewCellIdentifier];
}

- (void)setupNavigation {
    UIColor *navigationTitleColor = RGBColor(59.0f, 80.0f, 105.0f);
    UIColor *navigationBarTintColor = RGBColor(59.0f, 183.0f, 247.0f);
    UIImage *navigationBarBackgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    [self updateNavigationAppearanceWithTitleColor:navigationTitleColor
                                      barTintColor:navigationBarTintColor
                                   backgroundImage:navigationBarBackgroundImage];
}
- (void)updateNavigationAppearanceWithTitleColor:(UIColor *)navigationTitleColor
                                    barTintColor:(UIColor *)navigationBarTintColor
                                 backgroundImage:(UIImage *)navigationBarBackgroundImage {
    
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName : navigationTitleColor
                                     };
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationController.navigationBar setTintColor:navigationBarTintColor];
    [self.navigationController.navigationBar setBackgroundImage:navigationBarBackgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    NSDictionary *barButtonTextAttributes = @{
                                              NSForegroundColorAttributeName : navigationBarTintColor,
                                              NSFontAttributeName : [UIFont systemFontOfSize:16.0f]
                                              };
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonTextAttributes
                                                forState:UIControlStateNormal];
    
    NSMutableArray *barButtonItems =
    [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [barButtonItems addObjectsFromArray:self.navigationItem.rightBarButtonItems];
    
    for (UIBarButtonItem *item in barButtonItems) {
        [item setTitleTextAttributes:barButtonTextAttributes
                            forState:UIControlStateNormal];
    }
    UIImage *shadowImage =
    [UIImage imageWithColor:RGBAColor(241.0f, 241.0f, 241.0f, 1.0f)];
    [self.navigationController.navigationBar setShadowImage:shadowImage];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MessageTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:kReuseMessageTableViewCellIdentifier
                                    forIndexPath:indexPath];
    cell.layoutMargins = UIEdgeInsetsZero;
    
    CGRect frame = CGRectMake(0.0f, 0.0f, 20.0f, 17.0f);
    self.m13BadgeView = [[M13BadgeView alloc] initWithFrame:frame];
    self.m13BadgeView.badgeBackgroundColor = RGBColor(249.0f, 90.0f, 73.0f);
    self.m13BadgeView.text = @"19";
    self.m13BadgeView.cornerRadius = 10.0f;
    self.m13BadgeView.shadowBadge = YES;
    self.m13BadgeView.maximumWidth = 40.0f;
    [cell.badgeView addSubview:self.m13BadgeView];
    return cell;
}

#pragma mark - UItableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultMessageTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    SendChatMessageViewController *sendChatController = [[SendChatMessageViewController alloc] init];
    [self.navigationController pushViewController:sendChatController
                                         animated:YES];
}

#pragma mark - Handlers

@end
