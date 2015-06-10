//
//  NVBannerView.m
//  UPGCNew
//
//  Created by zeng daqian on 15/6/9.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "NVBannerView.h"

typedef NS_ENUM(NSInteger, NVScrollState) {
    NVScrollStateFirst,
    NVScrollStateEnd,
};

@interface NVBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *scrollItems;
@property (nonatomic) NVScrollState scrollState;

@end

@implementation NVBannerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        self.scrollState = NVScrollStateFirst;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.scrollView.frame = CGRectMake(0, 0, width, height);

    for (UIView *view in self.scrollItems) {
        NSInteger index = [self.scrollItems indexOfObject:view];
        view.frame = CGRectMake(index*width, 0, width, height);
    }
    
    if (self.bannerCount > 1) {
        self.scrollView.contentSize = CGSizeMake(self.scrollItems.count*width, height);
        CGFloat x = self.scrollState == NVScrollStateFirst ? width : (self.scrollItems.count-2)*width;
        self.scrollView.contentOffset = CGPointMake(x, 0);
    }
    
}

- (void)makeBannerItems:(UIView *(^)(NSInteger index))createItem {
    for (NSInteger i = 0; i<self.bannerCount; i++) {
        UIView *banner = createItem(i);
        [self.scrollItems addObject:banner];
    }
    if (self.bannerCount > 1) {
        self.bannerCount > 2 ? [self bringEndItemToFirst] : [self swapItem];
    } else {
        [self addItemToScrollView];
    }
    [self setNeedsLayout];
}

- (void)addItemToScrollView {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIView *view in self.scrollItems) {
        [self.scrollView addSubview:view];
    }
}

- (void)takeFirstItemToEnd {
    UIView *firstV = self.scrollItems[0];
    [self.scrollItems removeObjectAtIndex:0];
    [self.scrollItems addObject:firstV];
    [self addItemToScrollView];
}

- (void)bringEndItemToFirst {
    UIView *endV = self.scrollItems.lastObject;
    [self.scrollItems removeLastObject];
    [self.scrollItems insertObject:endV atIndex:0];
    [self addItemToScrollView];
}

- (void)swapItem {
    UIView *firstV = self.scrollItems[0];
    UIView *midV = self.scrollItems[1];
    [self.scrollItems removeAllObjects];
    NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:midV];
    UIView *midCopy = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
    [self.scrollItems addObjectsFromArray:@[midCopy, firstV, midV]];
    [self addItemToScrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(self.bounds);
    
    if (scrollView.contentOffset.x >= (self.scrollItems.count-1)*width) {
        if (scrollView.tracking == NO) {
            self.scrollState = NVScrollStateEnd;
            self.bannerCount > 2 ? [self takeFirstItemToEnd] : [self swapItem];
            [self setNeedsLayout];
        }
    } else if (scrollView.contentOffset.x == 0) {
        if (scrollView.tracking == NO) {
            self.scrollState = NVScrollStateFirst;
            self.bannerCount > 2 ? [self bringEndItemToFirst] : [self swapItem];
            [self setNeedsLayout];
        }
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

- (NSMutableArray *)scrollItems {
    if (_scrollItems == nil) {
        _scrollItems = [NSMutableArray new];
    }
    return _scrollItems;
}

@end
