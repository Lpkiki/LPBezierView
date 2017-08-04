//
//  ViewController.m
//  BezierPath
//
//  Created by Lpkiki on 2017/8/4.
// Copyright © 2017年 kiki. All rights reserved.
//

#import "ViewController.h"
#import "LPBezierView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LPBezierView *view = [[LPBezierView  alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}





@end
