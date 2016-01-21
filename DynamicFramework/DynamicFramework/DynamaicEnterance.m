//
//  DynamaicEnterance.m
//  DynamicFramework
//
//  Created by luoyan on 16/1/21.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "DynamaicEnterance.h"
#import "DFRootViewController.h"
#import <CommonFramework/CommonFun.h>

@implementation DynamaicEnterance

- (void)showViewOnController:(id)mainVC withBundle:(NSBundle *)bundle
{
    //测试调用其他库中的函数
    [CommonFun CommonFunTest];
    
    DFRootViewController *rootVC = [[DFRootViewController alloc] init];
    rootVC.rootBundle = bundle;
    
    //加上导航栏
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    //转换传递过来的mainCon参数，实现界面跳转
    UIViewController *viewVC = (UIViewController *)mainVC;
    [viewVC presentViewController:navCon animated:YES completion:^{
        NSLog(@"跳转到动态更新模块成功!");
    }];
    
}
@end
