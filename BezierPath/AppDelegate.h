//
//  AppDelegate.h
//  BezierPath
//
//  Created by Lpkiki on 2017/8/4.
// Copyright © 2017年 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

