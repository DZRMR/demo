//
//  DetailsView.m
//  高仿淘宝上拉进入详情页
//
//  Created by DMR on 17/4/18.
//  Copyright © 2017年 DMR. All rights reserved.
//

#import "DetailsView.h"

@implementation DetailsView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
        [self setUpLable];
    }
    return self;
}

- (void)setUp {
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

- (void)setUpLable {
    self.headLabel = [[UILabel alloc]init];
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    self.headLabel.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    self.headLabel.text = @"加载";
    [self addSubview:self.headLabel];
    [self.headLabel bringSubviewToFront:self];
}



@end
