# PagerView
PagerView is  a custom view controller similar to the flip effect.
Instructions：
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc]initWithFrame:self.view.bounds];
    view1.backgroundColor =[UIColor redColor];
    
    UIView *view2 = [[UIView alloc]initWithFrame:self.view.bounds];
    view2.backgroundColor =[UIColor blueColor];
    
    UIView *view3 = [[UIView alloc]initWithFrame:self.view.bounds];
    view3.backgroundColor =[UIColor yellowColor];
    
    UIView *view4 = [[UIView alloc]initWithFrame:self.view.bounds];
    view4.backgroundColor =[UIColor orangeColor];
    
    XWCPagerView *pagerView = [[XWCPagerView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height) withItems:[NSArray arrayWithObjects:@"用户消息",@"系统消息",@"故事推荐",@"测试用例", nil] withSubViews:@[view1,view2,view3,view4]];
    
    pagerView.delegate = self;
    [self.view addSubview:pagerView];
    // Do any additional setup after loading the view.
}

- (void)pagerView:(XWCPagerView *)pagerView withIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}
