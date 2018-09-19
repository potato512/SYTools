//
//  ViewController.m
//  DemoSYTools
//
//  Created by zhangshaoyu on 17/4/14.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYToolsHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"SYTools";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"click" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click
{
    [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:NO afterDelay:3.0 enabled:NO message:@"点击..."];
}

@end
