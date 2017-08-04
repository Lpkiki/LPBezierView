//
//  NewBezierView.h
//  BezierPath
//
//  Created by Lpkiki on 2017/8/4.
// Copyright © 2017年 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBezierView : UIView

/** 曲线数组 */
@property (nonatomic,strong) NSMutableArray *pathsArray;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *pointArray;


@end
