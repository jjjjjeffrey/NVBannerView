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

    
}

- (void)viewWillLayoutSubviews {
    NSArray *colors = @[[UIColor purpleColor], [UIColor brownColor], [UIColor blackColor], [UIColor redColor]];
    NSMutableArray *views = [NSMutableArray new];
    for (UIColor *color in colors) {
        NSInteger index = [colors indexOfObject:color];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.bannerView.frame))];
        view.backgroundColor = color;
        [views addObject:view];
        
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"第%ld张", index+1];
        [label sizeToFit];
        label.center = CGPointMake(CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)/2);
        [view addSubview:label];
    }
    self.bannerView.bannerViews = views;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
