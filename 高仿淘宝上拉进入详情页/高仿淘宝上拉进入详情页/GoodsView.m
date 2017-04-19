//
//  GoodsView.m
//  高仿淘宝上拉进入详情页
//
//  Created by DMR on 17/4/18.
//  Copyright © 2017年 DMR. All rights reserved.
//

#import "GoodsView.h"
#define K_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define K_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GoodsView()

@end

@implementation GoodsView

- (instancetype)init {
    if (self == [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
    [self addSubview:self.tableView];
    [self setUpFootLabel];
}


- (void)setUpFootLabel {
    self.footLabel = [[UILabel alloc]init];
    self.footLabel.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, 40);
    self.footLabel.textAlignment = NSTextAlignmentCenter;
    self.footLabel.text = @"继续拖动，查看图文详情";
    self.tableView.tableFooterView = self.footLabel;
}


@end
