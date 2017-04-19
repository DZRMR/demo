//
//  ViewController.m
//  高仿淘宝上拉进入详情页
//
//  Created by DMR on 17/4/18.
//  Copyright © 2017年 DMR. All rights reserved.
//

#import "ViewController.h"
#import "GoodsView.h"
#import "DetailsView.h"

#define K_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define K_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *const identifier  = @"cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)GoodsView *goodsView;
@property (nonatomic,strong)DetailsView *detailsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self detailsView];
    [self goodsView];
    [self.detailsView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.detailsView.scrollView && [keyPath isEqualToString:@"contentOffset"]) {
        CGFloat contentOffsetY = [change[@"new"] CGPointValue].y;
        [self headLabelChangeAnimation:contentOffsetY];
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)headLabelChangeAnimation:(CGFloat)contentOffsetY {
    self.detailsView.headLabel.alpha = -contentOffsetY / 100;
    self.detailsView.headLabel.center = CGPointMake(K_SCREEN_WIDTH/2.f, - contentOffsetY / 2.f);
    if (-contentOffsetY > 100) {
        self.detailsView.headLabel.text = @"释放，返回商品简介";
    }else {
        self.detailsView.headLabel.text = @"下拉，返回商品简介";
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetYoffsetYoffsetYoffsetYoffsetY ====%f",offsetY);
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat value = self.goodsView.tableView.contentSize.height - self.view.frame.size.height;
        if ((offsetY - value) > 100 ) {
            [self goToDetailsView];
        }
    }else {
        if (offsetY < 0 && -offsetY > 100 ) {
            [self goToGoodsView];
        }
    }
}

- (void)goToDetailsView {
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.detailsView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
        self.goodsView.frame = CGRectMake(0, -K_SCREEN_HEIGHT, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
    } completion:nil];
}

- (void)goToGoodsView {
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.detailsView.frame = CGRectMake(0, self.goodsView.tableView.contentSize.height, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
        self.goodsView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);

    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark -<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"商品%ld号",indexPath.row];
    return cell;
}


#pragma mark - lazyLoad
- (GoodsView *)goodsView {
    if (!_goodsView) {
        _goodsView = [[GoodsView alloc]init];
        _goodsView.frame = self.view.bounds;
        _goodsView.tableView.delegate = self;
        _goodsView.tableView.dataSource = self;
        [self.view addSubview:_goodsView];
    }
    return _goodsView;
}

- (DetailsView *)detailsView {
    if (!_detailsView) {
        _detailsView = [[DetailsView alloc]init];
        _detailsView.frame = self.view.bounds;
        [self.view addSubview:_detailsView];
        _detailsView.scrollView.delegate = self;
    }
    return _detailsView;
}

@end
