//
//  NVBannerView.h
//  UPGCNew
//
//  Created by zeng daqian on 15/6/9.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVBannerView : UIView

@property (nonatomic) NSInteger bannerCount;

- (void)makeBannerItems:(UIView *(^)(NSInteger index))createItem;

@end
