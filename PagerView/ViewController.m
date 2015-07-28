//
//  View2Controller.m
//  BlockExample
//
//  Created by hcc on 15/7/15.
//  Copyright (c) 2015年 pupuwang. All rights reserved.
//

#import "ViewController.h"

#import "XWCPagerView.h"

@interface ViewController ()<XWCPagerViewDelegate>

@end

@implementation ViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
