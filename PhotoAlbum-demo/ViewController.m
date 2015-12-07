//
//  ViewController.m
//  PhotoAlbum-demo
//
//  Created by huanghy on 15/12/7.
//  Copyright © 2015年 huanghy. All rights reserved.
//

#import "ViewController.h"


#import "HYScrollView.h"

#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height

#define kNumOfPages 3

#define kMarginWidth 30


@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)setupScrollView
{
    UIScrollView *scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth+kMarginWidth, kHeight)];
    
    // 属性设置
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = CGSizeMake((kWidth+kMarginWidth) * kNumOfPages, kHeight);
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    [self.view addSubview:_scrollView];
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    for (int i = 0; i < kNumOfPages; i++) {
        // 创建QYScrollView实例
        HYScrollView *imgScrollView = [[HYScrollView alloc] initWithFrame:CGRectMake(i * (kWidth+kMarginWidth), 0, kWidth, kHeight)];
        imgScrollView.tag = i+1;
        
        // 设置QYScrollView 的图片视图的图片
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d-568h", i+1]];
        imgScrollView.imageView.image = image;
        
        // 添加为_scrollView的子视图
        [self.scrollView addSubview:imgScrollView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupScrollView];
}

#pragma mark - scroll view delegate

static int preTag = 1;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentTag = scrollView.contentOffset.x / (kWidth + kMarginWidth) + 1;
    
    if (currentTag != preTag) {
        UIScrollView *preScrollView = (UIScrollView *)[_scrollView viewWithTag:preTag];
        //        preScrollView.zoomScale = 1.0;
        if (preScrollView.zoomScale != 1.0) {
            preScrollView.zoomScale = 1.0;
        }
    }
    
    preTag = currentTag;
}

@end

