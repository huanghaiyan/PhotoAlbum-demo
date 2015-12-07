//
//  QYScrollView.m
//  AlbumZoomingDemo
//
//  Created by huanghy on 14-11-20.
//  Copyright (c) 2014年 huanghy. All rights reserved.
//

#import "HYScrollView.h"

@implementation HYScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
        
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 3;
        
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomAction:)];
        
        doubleTapGesture.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer:doubleTapGesture];
    }
    return self;
}

- (void)zoomAction:(UITapGestureRecognizer *)gesture
{
    if (self.zoomScale != 1.0) {
        self.zoomScale = 1.0;
    } else {
        CGPoint location = [gesture locationInView:self.imageView];
        
        CGFloat width = self.frame.size.width/2;
        CGFloat height = self.frame.size.height/2;
        
        [self zoomToRect:CGRectMake(location.x - width/2, location.y - height/2, width, height) animated:YES];
    }
}


#pragma mark - scroll view delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"view:%@, scale:%.2f", view, scale);
//    scrollView.zoomScale = 1.0;
}
@end
