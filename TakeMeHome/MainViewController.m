//
//  MainViewController.m
//  TakeMeHome
//
//  Created by Josh on 2015/7/23.
//  Copyright (c) 2015年 Josh. All rights reserved.
//

#import "MainViewController.h"
#import "navigationBtn.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>



@interface MainViewController ()<FBSDKLoginButtonDelegate,NavigationBtnObjecterDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *adoptButton;
@property (weak, nonatomic) IBOutlet UIButton *lostButton;
@property (weak, nonatomic) IBOutlet UIButton *lifeButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *memberSettingButton;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLogOutButton;


@property(nonatomic)UIDynamicAnimator*animator;
@property(nonatomic)UIAttachmentBehavior*attachBehavior;

@end

@implementation MainViewController
{
    navigationBtn *naviClass;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:false];
    [self NavigationBtnObjecterShoudDisplay:self];
    [naviClass setDelegate:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    naviClass = [navigationBtn shareInstance];
    
    
    //隱藏Menu的按鈕
    _adoptButton.hidden=YES;
    _lostButton.hidden=YES;
    _lifeButton.hidden=YES;
    _settingButton.hidden=YES;
    _memberSettingButton.hidden=YES;
    
    //
    self.fbLogOutButton.delegate = self;
    

    
}
-(UIViewController *)attachedViewController
{
    return self;
}
- (BOOL)NavigationBtnObjecterShoudDisplay:(UIViewController*)VC{
    naviClass.parentVC = VC;
    return  true;
}
-(void)viewDidAppear:(BOOL)animated
{

    [self menuBtnPress:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//當按下小幫手的時候展開或收起Menu的按鈕
- (IBAction)menuBtnPress:(UITapGestureRecognizer*)sender {
    
    //展開Menu
    if (_adoptButton.hidden==YES) {
        //顯示Menu的按鈕
        _adoptButton.hidden=NO;
        _lostButton.hidden=NO;
        _lifeButton.hidden=NO;
        _settingButton.hidden=NO;
        _memberSettingButton.hidden=NO;
        
        //取得螢幕中心點xy值
        CGFloat centerX=self.view.center.x;
        CGFloat centerY=self.view.center.y;
        self.animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
       
        //領養按鈕的位置
        CGPoint point1=CGPointMake(centerX,centerY-130);
        UISnapBehavior * snapBehavior1=[[UISnapBehavior alloc]initWithItem:_adoptButton snapToPoint:point1];
        snapBehavior1.damping=0.7;
        [self.animator addBehavior:snapBehavior1];
        
        //走失按鈕的位置
        CGPoint point2=CGPointMake(centerX-95,centerY-80);
        UISnapBehavior * snapBehavior2=[[UISnapBehavior alloc]initWithItem:_lostButton snapToPoint:point2];
        snapBehavior2.damping=0.5;
        [self.animator addBehavior:snapBehavior2];
        
        //生活按鈕的位置
        CGPoint point3=CGPointMake(centerX+95,centerY-80);
        UISnapBehavior * snapBehavior3=[[UISnapBehavior alloc]initWithItem:_lifeButton snapToPoint:point3];
        snapBehavior3.damping=0.5;
        [self.animator addBehavior:snapBehavior3];
        
        //設定按鈕的位置
        CGPoint point4=CGPointMake(centerX+120,centerY+8);
        UISnapBehavior * snapBehavior4=[[UISnapBehavior alloc]initWithItem:_settingButton snapToPoint:point4];
        snapBehavior4.damping=0.5;
        [self.animator addBehavior:snapBehavior4];
        
        //個人資料按鈕的位置
        CGPoint point5=CGPointMake(centerX-120,centerY+8);
        UISnapBehavior * snapBehavior5=[[UISnapBehavior alloc]initWithItem:_memberSettingButton snapToPoint:point5];
        snapBehavior5.damping=0.5;
        [self.animator addBehavior:snapBehavior5];
    }
    //收起Menu
    else{
        //隱藏Menu的按鈕
        _adoptButton.hidden=YES;
        _lostButton.hidden=YES;
        _lifeButton.hidden=YES;
        _settingButton.hidden=YES;
        _memberSettingButton.hidden=YES;
        
        CGPoint point=[[self view]center];
        self.animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
   
        //領養按鈕的位置
        UISnapBehavior * snapBehavior1=[[UISnapBehavior alloc]initWithItem:_adoptButton snapToPoint:point];
        snapBehavior1.damping=0.7;
        [self.animator addBehavior:snapBehavior1];
        
        //走失按鈕的位置
        UISnapBehavior * snapBehavior2=[[UISnapBehavior alloc]initWithItem:_lostButton snapToPoint:point];
        snapBehavior2.damping=0.7;
        [self.animator addBehavior:snapBehavior2];
        
        //生活按鈕的位置
        UISnapBehavior * snapBehavior3=[[UISnapBehavior alloc]initWithItem:_lifeButton snapToPoint:point];
        snapBehavior3.damping=0.7;
        [self.animator addBehavior:snapBehavior3];
        
        //設定按鈕的位置
        UISnapBehavior * snapBehavior4=[[UISnapBehavior alloc]initWithItem:_settingButton snapToPoint:point];
        snapBehavior4.damping=0.7;
        [self.animator addBehavior:snapBehavior4];
        
        //個人資料按鈕的位置
        UISnapBehavior * snapBehavior5=[[UISnapBehavior alloc]initWithItem:_memberSettingButton snapToPoint:point];
        snapBehavior5.damping=0.7;
        [self.animator addBehavior:snapBehavior5];
        
    }
    
    
}

//FBLogOutButton 按下
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{

    [self dismissViewControllerAnimated:true completion:^{NSLog(@"backLog");}];


}

//回到此頁
-(IBAction)backToWhite:(UIStoryboardSegue*)segue{ NSLog(@"backToWhite");}


- (IBAction)adoptButtonPressed:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"adopt" bundle:nil];
    id targetViewController = [storyboard instantiateViewControllerWithIdentifier:@"adopt"];
    [self presentViewController:targetViewController animated:false completion:nil];
    
}




@end
