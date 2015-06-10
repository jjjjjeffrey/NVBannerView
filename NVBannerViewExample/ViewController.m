//
//  ViewController.m
//  NVBannerViewExample
//
//  Created by zeng daqian on 15/6/10.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "ViewController.h"
#import "NVBannerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NVBannerView *bannerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *colors = @[[UIColor purpleColor], [UIColor brownColor], [UIColor blackColor], [UIColor redColor]];
    self.bannerView.bannerCount = 4;
    [self.bannerView makeBannerItems:^UIView *(NSInteger index) {
        UIView *banner = [UIView new];
        banner.backgroundColor = colors[index];
        return banner;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
