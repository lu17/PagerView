//
//  XWCPagerView.m
//  XWClient
//
//  Created by HELIUMIN on 15/5/13.
//  Copyright (c) 2015年 XWClient. All rights reserved.
//

#import "XWCPagerView.h"

#define KTEXTCOLOR   RGBColor(136, 136, 136)     //默认文本颜色
#define KSTEXTCOLOR  RGBColor(128, 208, 51)      //选中文本颜色
#define KSEPLINCOLOR RGBColor(180, 180, 180)     //分割线颜色
#define KTEXTFONT                       Arial(14)//文本字体
#define KTIPIMGSIZE                     8
#define KSegmentHeight                  40
#define Arial(x) [UIFont fontWithName:@"Arial" size:x]

@interface XWCSegmentView()
{
    CGSize _textSize;//文本size
}
@property (nonatomic,strong) NSArray        *items;//标题数组
@property (nonatomic,strong) NSMutableArray *titleLbls;//label数组
@property (nonatomic,strong) NSMutableArray *tipViews;//提示view(类似红点)
@property (nonatomic,strong) UIView         *btmLineView;//底部view
@property (nonatomic,strong) UIImageView    *triangleImgView;//底部三角

@end

@implementation XWCSegmentView

#pragma mark-LIFE CYCLE
- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items
{
    self =[super initWithFrame:frame];
    if (self) {

        _items = items;
        [self initViews];
        [self setSIndex:0];
    }
    return self;
}

- (void)initViews
{
    self.backgroundColor = RGBColor(255, 255, 255);
    
    //阴影线
    UIImageView *shadowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bottom-0.5, self.width, 0.5)];
    shadowImgView.backgroundColor = RGBColor(230, 230, 230);
    [self addSubview:shadowImgView];
    
    //分割线
//    _textSize =[_items[0] sizeWithAttributes:@{NSFontAttributeName:KTEXTFONT}];
    _textSize =[_items[0] textSizeWithFont:KTEXTFONT constrainedToSize:CGSizeZero lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat sepLineViewX = self.width / _items.count;
    CGFloat sepLineViewY = (self.height-_textSize.height-6)/2;
    for (int i = 0; i < _items.count - 1; i ++) {
        
        UIView *sepLineView = [[UIView alloc] initWithFrame:CGRectMake(sepLineViewX-0.5, sepLineViewY, 0.5,_textSize.height+6)];
        sepLineView.backgroundColor = KSEPLINCOLOR;
        [self addSubview:sepLineView];
        sepLineViewX = (self.width / _items.count)*(i+2);
    }
    
    //标题
    _titleLbls = [NSMutableArray array];
    _tipViews =[NSMutableArray array];
    for (int i = 0; i < self.items.count; i ++) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = _items[i];
        titleLabel.textColor = (i == 0)?KSTEXTCOLOR:KTEXTCOLOR;
        titleLabel.font = KTEXTFONT;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        [_titleLbls addObject:titleLabel];
        
        UIImageView *tipImgView =[[UIImageView alloc]initWithFrame:CGRectZero];
        tipImgView.backgroundColor =[UIColor redColor];
        tipImgView.hidden = YES;
        [self addSubview:tipImgView];
        [_tipViews addObject:tipImgView];
    }
    
    //底部的线条
    _btmLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _btmLineView.backgroundColor = KSTEXTCOLOR;;
    [self addSubview:_btmLineView];

    _triangleImgView = [[UIImageView alloc] init];
    _triangleImgView.image = [UIImage imageNamed:@"common_triangle"];
    [self addSubview:_triangleImgView];
    //红点
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float imgWidth = self.width/self.items.count;
    for (int i = 0; i < self.items.count ; i ++) {
        
        UILabel *titleLbl= _titleLbls[i];
        titleLbl.frame = CGRectMake(i*imgWidth, 0, imgWidth, self.height);
        titleLbl.text = self.items[i];
        titleLbl.textColor = (i==_sIndex)?KSTEXTCOLOR:KTEXTCOLOR;
        
        CGSize textSize = [titleLbl intrinsicContentSize];
        UIImageView *imgView = _tipViews[i];
        imgView.layer.cornerRadius = KTIPIMGSIZE/2;
        imgView.frame = CGRectMake(i*imgWidth + (imgWidth+textSize.width)/2.0+KTIPIMGSIZE/2.0 ,(self.height-textSize.height)/2.0-KTIPIMGSIZE/2.0, KTIPIMGSIZE, KTIPIMGSIZE);
    }
}

#pragma mark-SETTER
- (void)setRecommendEnter:(BOOL)recommendEnter
{
    _recommendEnter = recommendEnter;
    if (recommendEnter == YES) {
        
        _btmLineView.hidden = YES;
        
        _textSize = [_titleLbls[_sIndex] intrinsicContentSize];
        float imgWidth = self.width/self.items.count;
        _triangleImgView.frame = CGRectMake(imgWidth*_sIndex + (imgWidth - 8)/2, self.height - 5, 8, 5);
    }
}

- (void)setSIndex:(NSInteger)sIndex
{
    _sIndex = sIndex;
    
   // DLog(@"_titleLbls IS %@",_titleLbls);
    _textSize = [_titleLbls[sIndex] intrinsicContentSize];
    
    float imgWidth = self.width/self.items.count;
    float withd = _textSize.width;

    if (_recommendEnter == YES) {
       
        _btmLineView.hidden = YES;
        if (_triangleImgView.width == 0) {
            _triangleImgView.frame = CGRectMake(imgWidth*sIndex + (imgWidth - 8)/2, self.height - 5, 8, 5);
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                _triangleImgView.left = imgWidth*sIndex + (imgWidth - 8)/2;
            }];
        }
    }else {
        
        if (_btmLineView.width == 0) {
            _btmLineView.frame = CGRectMake(imgWidth*sIndex + (imgWidth - withd)/2, self.height - 2, withd, 2);
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                _btmLineView.left = imgWidth*sIndex + (imgWidth - withd)/2;
                _btmLineView.width = withd;
            }];
        }
    }
    //发送一个值修改的事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    //重新设置一下选中状态，调用一下layoutSubviews
    [self setNeedsLayout];
}

#pragma mark-EVENT RESPONSE
//监听点击事件
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    NSInteger index = p.x / (self.width/self.items.count);
    self.sIndex = index;
}

#pragma mark-PRIVATE METHOD
//显示提示view
- (void)showTipViewWithIndex:(NSInteger)index withIsShow:(BOOL)isShow
{
    UIImageView *imgView = _tipViews[index];
    imgView.hidden = isShow;
}

@end

@interface XWCPagerView()

@property(nonatomic,strong) NSArray *items;//［标题］
@property(nonatomic,strong) NSArray *subViews;//[view]
@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation XWCPagerView

#pragma mark-LIFE CYCLE
- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items withSubViews:(NSArray *)subViews
{
    self =[super initWithFrame:frame];
    if (self) {
        _items = items;
        _subViews = [subViews copy];
        [self initViews];
    }
    return self;
}

//views
- (void)initViews
{
    _segmentView = [[XWCSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.width, KSegmentHeight) withItems:_items];
    [_segmentView addTarget:self action:@selector(segmentSelectAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_segmentView];
    
    //scrollView
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.width, self.height - 40)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.tag = 100;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = RGBColor(234, 234, 234);
    _scrollView.contentSize = CGSizeMake(self.width * _items.count, 0);
    _scrollView.scrollsToTop = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self insertSubview:_scrollView belowSubview:_segmentView];
    
    //views
    for (int i = 0; i < _subViews.count; i ++) {
        UIView *view = _subViews[i];
        view.left = self.width * i;
        [_scrollView addSubview:view];
    }
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + self.width/2)/self.width;
    if (_segmentView.sIndex != index) {
        _segmentView.sIndex = index;
        if ([_delegate respondsToSelector:@selector(pagerView:withIndex:)]) {
            [_delegate pagerView:self withIndex:index];
        }
    }
}

#pragma mark-EVENT RESPONSE
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView* result = [super hitTest:point withEvent:event];
    if (point.x < self.width / 2 && _segmentView.sIndex == 0) {
        _scrollView.scrollEnabled = NO;
    }else{
        _scrollView.scrollEnabled = YES;
    }
    return result;
}

#pragma mark-PRIVATE METHOD
- (void)segmentSelectAction:(XWCSegmentView *)segmentView
{
    NSInteger index = segmentView.sIndex;
    [UIView animateWithDuration:0.35 animations:^{
        _scrollView.contentOffset = CGPointMake(self.width * segmentView.sIndex, 0);
        if ([_delegate respondsToSelector:@selector(pagerView:withIndex:)]) {
            [_delegate pagerView:self withIndex:index];
        }
    }];
}



@end
