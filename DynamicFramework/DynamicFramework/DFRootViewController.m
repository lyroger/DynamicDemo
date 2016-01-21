//
//  DFRootViewController.m
//  DynamicFramework
//
//  Created by luoyan on 16/1/21.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "DFRootViewController.h"

@interface DFRootViewController ()

@end

@implementation DFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubView
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //测试加载动态库中的资源
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(0, 0, 60, 60);
    imageV.center = self.view.center;
    imageV.image = [UIImage imageWithContentsOfFile:[self.rootBundle pathForResource:@"icon_logo" ofType:@"png"]];
    [self.view addSubview:imageV];
    
    UIBarButtonItem *testFunButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeVC)];
    self.navigationItem.leftBarButtonItem = testFunButton;
}

- (void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
