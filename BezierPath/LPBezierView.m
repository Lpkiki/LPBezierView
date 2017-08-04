//
//  LPBezierView.m
//  BezierPath
//
//  Created by Lpkiki on 2017/8/4.
// Copyright © 2017年 kiki. All rights reserved.
//
#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]  


#import "LPBezierView.h"
#import "NewBezierView.h"


@interface LPBezierView ()

/** 当前界面所有的path集合 */
@property (nonatomic,strong) NSMutableArray  *currentPaths;
/** 当前界面所有path上的点集合 */
@property (nonatomic,strong) NSMutableArray  *allPathsPoints;
/** 每条path分成点数相应的 path */
@property (nonatomic,strong) NSMutableArray  *allPathsArray;
/** newview */
@property (nonatomic,strong) NewBezierView *newview;

/** UISlider */
@property (nonatomic,strong) UISlider *slier;

@end

@implementation LPBezierView

-(instancetype )initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor yellowColor ];
        [self setupUI];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
//    NSLog(@"👌👌👌👌重绘 " );
    for (UIBezierPath *path in self.currentPaths) {
        [[UIColor orangeColor] set];
        [path stroke];
    }
}


#pragma mark  -  取path
//在此获取起点
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    
    UIBezierPath  *path = [UIBezierPath bezierPath];
    //曲线中点样式
    path.lineCapStyle = kCGLineCapRound;
    //曲线链接点样式
    path.lineJoinStyle = kCGLineJoinRound;
    //线宽
    path.lineWidth =  4.0f;
    
    [path moveToPoint:startPoint];//设置起点
    
    [self.currentPaths addObject:path];
//    NSLog(@"❤️起点 === %lu",(unsigned long)self.paths.count );
    [self setNeedsDisplay]; //需要重绘
}



//在此获取一条曲线的终点
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];   // 当前移动的点
    UIBezierPath *path = [self.currentPaths lastObject];
    [path addLineToPoint:currentPoint];
//  NSLog(@"❤️移动 === %lu",(unsigned long)self.paths.count );
    [self setNeedsDisplay];
}




- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


    [self.allPathsPoints removeAllObjects];
    [self.allPathsArray  removeAllObjects];
    
    for (UIBezierPath *path in self.currentPaths) {
        //获取每条path上的点
        NSArray *array = [self points:path];
        //当前界面所有path上的点集合
        [self.allPathsPoints addObjectsFromArray:array];
        //每条path上的点对应的path总集合
        NSArray *patharray  = [self pathFormPointsArray:array];
        [self.allPathsArray  addObjectsFromArray:patharray];

    }
    
}


#pragma mark - actions

-(void)btnClick:(UIButton *)sender{
 
    //用来装载新的path
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
//    NSMutableArray *pointarray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ;i<self.allPathsArray.count * self.slier.value;i++ ) {
        UIBezierPath *path = self.allPathsArray[i];
        [array addObject:path];
    }
    
//    for (int i = 0 ;i<self.allPoints.count * self.slier.value;i++ ) {
//        NSValue *point = self.allPoints[i];
//        [pointarray addObject:point];
//    }
 
    //self.newview.pointArray = pointarray;
    self.newview.pathsArray = array;
}


//清除所有数据
-(void)btnClearClick:(UIButton *)sender{
    [self.currentPaths removeAllObjects];
    [self setNeedsDisplay];
    [self.allPathsPoints removeAllObjects];
    [self.allPathsArray  removeAllObjects];
    
}


#pragma mark - 根据一条贝塞尔曲线 获取 point集合

void getPointsFromBezier(void *info,const CGPathElement *element){
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:VALUE(0)];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:VALUE(1)];
        }
    }
    
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:VALUE(2)];
    }
    
}

- (NSArray *)points:(UIBezierPath *)path
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(path.CGPath, (__bridge void *)points, getPointsFromBezier);
    return points;
    
}
#pragma mark - 根据点数组获取path数组
-(NSMutableArray *)pathFormPointsArray:(NSArray *)pointsArray{
    
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
//    @autoreleasepool {}
    for (int i = 0; i<pointsArray.count; i++){
        //第一个点
        NSValue *point = pointsArray[0];
        CGPoint cgpoint = [point CGPointValue];
        //画曲线
        UIBezierPath  *path = [UIBezierPath bezierPath];
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineWidth =  4.0f;
        //设置起点
        [path moveToPoint:cgpoint];
        //设置终点
        for ( int  j = 0; j <= i; j++)
        {
           NSValue *p = pointsArray[j];
           CGPoint c = [p CGPointValue];
           [path addLineToPoint:c];
        }
        [resultArr addObject:path];
    }
    
    return resultArr;
}


#pragma mark - Ui   

-(void)setupUI{

    
    UIButton  *btnClear = [[UIButton alloc]initWithFrame: CGRectMake(200, 0, 100, 50)];
    [btnClear setTitle:@"清除" forState:UIControlStateNormal];
    [btnClear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnClear addTarget:self action:@selector(btnClearClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClear];
   
     self.newview  = [[NewBezierView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:self.newview];

     self.slier = [[UISlider alloc] initWithFrame:CGRectMake(20,60,self.bounds.size.width-40,20)];
     self.slier.minimumValue = 0;
     self.slier.maximumValue = 1;
     self.slier.value =0;
     self.slier.continuous= YES;
     self.slier.minimumTrackTintColor = [UIColor blueColor];
     self.slier.maximumTrackTintColor = [UIColor whiteColor];
     self.slier.thumbTintColor = [UIColor blueColor];

    [self addSubview: self.slier];
    //添加点击事件
    [ self.slier addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventValueChanged];

}

#pragma mark - Get


-(NSMutableArray *)currentPaths{
    if (!_currentPaths) {
        _currentPaths = [[NSMutableArray alloc]init];
    }
    return _currentPaths;

}


-(NSMutableArray *)allPathsPoints{
    if (!_allPathsPoints) {
        _allPathsPoints = [[NSMutableArray alloc]init];
    }
    return _allPathsPoints   ;
}

-(NSMutableArray  *)allPathsArray{

    if (!_allPathsArray) {
        _allPathsArray = [[NSMutableArray alloc]init];
    }
    return _allPathsArray   ;
}


@end
