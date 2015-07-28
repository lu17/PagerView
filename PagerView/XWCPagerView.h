//
//  XWCPagerView.h
//  XWClient
//
//  Created by HELIUMIN on 15/5/13.
//  Copyright (c) 2015年 XWClient. All rights reserved.
//

/**
 *  @author HLM, 15-07-10 15:07:20
 *
 *  功能描述
 *  该类继承UIView 一个页面包含多个view 分页显示
 */

#import <UIKit/UIKit.h>
#import "UIView+Private.h"
#import "NSString+Private.h"
#define RGBColor(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface XWCSegmentView : UIControl

@property (nonatomic,assign) NSInteger sIndex;//选择索引
@property (nonatomic,assign) BOOL      recommendEnter;

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items;
- (void)showTipViewWithIndex:(NSInteger)index withIsShow:(BOOL)isShow;



@end

@class XWCPagerView;

@protocol XWCPagerViewDelegate <NSObject>

@optional

- (void)pagerView:(XWCPagerView *)pagerView withIndex:(NSInteger)index;

@end

@interface XWCPagerView : UIView<UIScrollViewDelegate>

@property (nonatomic,weak  ) id<XWCPagerViewDelegate> delegate;

@property (nonatomic,strong) XWCSegmentView       *segmentView;

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items withSubViews:(NSArray *)subViews;


@end


/*
 使用方法:
 UIView *view1 = [[UIView alloc]initWithFrame:self.view.bounds];
 view1.backgroundColor =[UIColor redColor];
 
 UIView *view2 = [[UIView alloc]initWithFrame:self.view.bounds];
 view2.backgroundColor =[UIColor blueColor];
 
 UIView *view3 = [[UIView alloc]initWithFrame:self.view.bounds];
 view3.backgroundColor =[UIColor yellowColor];
 
 XWCPagerView *pagerView =  [[XWCPagerView alloc] initWithFrame:self.view.bounds withItems:@[@"我的圈子",@"圈子",@"圈"] withSubViews:@[view1,view2,view3]];
 pagerView.delegate = self;
 [self.view addSubview:pagerView];
 
 */