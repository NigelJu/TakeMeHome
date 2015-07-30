//
//  indexAdoptVC.m
//  TakeMeHome
//
//  Created by Nigel on 2015/7/30.
//  Copyright (c) 2015年 Josh. All rights reserved.
//

#import "indexAdoptVC.h"
#import "navigationBtn.h"

@interface indexAdoptVC ()<NavigationBtnObjecterDelegate>
{
    navigationBtn *naviClass;
}
@end

@implementation indexAdoptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    naviClass = [navigationBtn shareInstance];
    [self NavigationBtnObjecterShoudDisplay:self];
    [naviClass setDelegate:self];
    
}

-(UIViewController *)attachedViewController
{
    return self;
}
- (BOOL)NavigationBtnObjecterShoudDisplay:(UIViewController*)VC{
    naviClass.parentVC = VC;
    return  true;
}



@end
