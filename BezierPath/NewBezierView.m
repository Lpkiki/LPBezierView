//
//  NewBezierView.m
//  BezierPath
//
//  Created by Lpkiki on 2017/8/4.
// Copyright © 2017年 kiki. All rights reserved.
//

#import "NewBezierView.h"

@interface NewBezierView (){

    NSMutableArray *_paths;
    NSMutableArray *_imageCenterArray;

}

/** icon */
@property (nonatomic,strong) UIImageView *icon;

@end

@implementation NewBezierView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.icon];
    }
    return self;

}

//重绘
- (void)drawRect:(CGRect)rect {
    
    for (UIBezierPath *path in _paths) {
        path.lineWidth = 4.0f;
        [[UIColor blueColor]set];
        [path stroke];
    }
    
}


#pragma mark - Set

-(void)setPathsArray:(NSMutableArray *)pathsArray{

    _paths = pathsArray;
    [self setNeedsDisplay];
}


-(void)setPointArray:(NSMutableArray *)pointArray{
//    _imageCenterArray = pointArray;
//    NSValue *point = _imageCenterArray.lastObject;
//    CGPoint cgpoint = [point CGPointValue];
//    self.icon.hidden = NO;
//    self.icon.center   =  cgpoint;
}

#pragma mark - Get

-(UIImageView *)icon{
    if (!_icon) {
        _icon    = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _icon.hidden    = YES;
    }
    return _icon;
}

@end
