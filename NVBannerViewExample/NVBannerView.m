//
//  NVBannerView.m
//  UPGCNew
//
//  Created by zeng daqian on 15/6/9.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "NVBannerView.h"


@interface UIView (Copy)

+ (UIView*)copyWith:(UIView *)view;

@end

@implementation UIView (Copy)

+ (UIView*)copyWith:(UIView *)view; {
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

@end

@interface NVBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation NVBannerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.scrollView.frame = CGRectMake(0, 0, width, height);

    for (UIView *view in self.bannerViews) {
        NSInteger index = [self.bannerViews indexOfObject:view];
        view.frame = CGRectMake(index*width, 0, width, height);
    }
    self.scrollView.contentSize = CGSizeMake(width*self.bannerViews.count, height);
    self.scrollView.contentOffset = CGPointMake(width, 0);
}

- (void)addItemToScrollView {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIView *view in self.bannerViews) {
        [self.scrollView addSubview:view];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    CGFloat width = CGRectGetWidth(self.bounds);
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(width*(self.bannerViews.count-2), scrollView.contentOffset.y);
    }
    
    if (scrollView.contentOffset.x == width*(self.bannerViews.count-1)) {
        scrollView.contentOffset = CGPointMake(width, scrollView.contentOffset.y);
    }
}

#pragma mark - getter and setter
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor darkGrayColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setBannerViews:(NSArray *)bannerViews {
    UIView *firstView = [UIView copyWith:bannerViews[0]];
    UIView *endView = [UIView copyWith:bannerViews.lastObject];
    NSMutableArray *views = [NSMutableArray arrayWithArray:bannerViews];
    [views insertObject:endView atIndex:0];
    [views addObject:firstView];
    _bannerViews = [NSArray arrayWithArray:views];
    [self addItemToScrollView];
}

@end
