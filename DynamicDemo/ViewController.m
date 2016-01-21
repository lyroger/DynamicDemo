//
//  ViewController.m
//  DynamicDemo
//
//  Created by luoyan on 16/1/21.
//  Copyright © 2016年 Roger. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *dynamicAction = [UIButton buttonWithType:UIButtonTypeCustom];
    dynamicAction.frame = CGRectMake(0, 0, 150, 40);
    dynamicAction.center = self.view.center;
    [dynamicAction setTitle:@"加载动态库中模块" forState:UIControlStateNormal];
    
    [dynamicAction setBackgroundColor:[UIColor grayColor]];
    [dynamicAction addTarget:self action:@selector(loadDynamicFrameworkModel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dynamicAction];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDynamicFrameworkModel
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = nil;
    if ([paths count] != 0)
        documentDirectory = [paths objectAtIndex:0];
    
    //本地动态库文件
    NSString *libName = @"DynamicFramework.framework";
    NSString *destLibPath = [documentDirectory stringByAppendingPathComponent:libName];
    
    //下载的动态库的压缩文件
    NSString *zipLibName = @"DynamicFramework.framework.zip";
    NSString *destZipLibPath = [documentDirectory stringByAppendingPathComponent:zipLibName];
    
    //判断是否存在动态库文件，或下载下来的压缩文件
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:destZipLibPath] && ![manager fileExistsAtPath:destLibPath]) {
        NSLog(@"没有动态库文件或动态库文件的下载压缩文件");
        return;
    }
    
    //有动态库的压缩文件，则解压，解压完成后删除。
    if ([manager fileExistsAtPath:destZipLibPath]) {
        BOOL unZipWorked = [SSZipArchive unzipFileAtPath:destZipLibPath toDestination:documentDirectory];
        if (unZipWorked) {
            [manager removeItemAtPath:destZipLibPath error:nil];
        } else {
            NSLog(@"压缩下载包失败");
            return;
        }
    }
    
    
    //复制到程序中
    NSBundle *frameworkBundle = [NSBundle bundleWithPath:destLibPath];
    if (frameworkBundle && [frameworkBundle load]) {
        NSLog(@"load Bundle success");
    } else {
        NSLog(@"load Bundle failed");
        return;
    }
    
    /*
     *通过NSClassFromString方式读取类
     *PacteraFramework　为动态库中入口类
     */
    Class pacteraClass = NSClassFromString(@"DynamaicEnterance");
    if (!pacteraClass) {
        NSLog(@"Unable to get DynamicFramework class");
        return;
    }
    
    /*
     *初始化方式采用下面的形式
     　alloc　init的形式是行不通的
     　同样，直接使用PacteraFramework类初始化也是不正确的
     *通过- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
     　方法调用入口方法（showView:withBundle:），并传递参数（withObject:self withObject:frameworkBundle）
     */
    NSObject *pacteraObject = [pacteraClass new];
    [pacteraObject performSelector:@selector(showViewOnController:withBundle:) withObject:self withObject:frameworkBundle];
    
}
@end
