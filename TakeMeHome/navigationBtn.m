//
//  navigationBtn.m
//  testDelegateDragBtn
//
//  Created by Nigel on 2015/7/29.
//  Copyright (c) 2015年 Nigel. All rights reserved.
//

#import "navigationBtn.h"


@implementation navigationBtn



+(instancetype)shareInstance{
    static dispatch_once_t once;
    static navigationBtn *master = nil;
    dispatch_once(&once,^{
        master = [[[self class]alloc]init];
    });
    
    return master;
}
-(instancetype)init{
   
    if (self = [super init]) {
       [self setup];
    }
    
    return self;
}


-(void)setCTpopoutMenuItem{

    NSMutableArray * items = [NSMutableArray new];
    /*
     for (int i = 0; i < 6 ; i++) {
     CTPopoutMenuItem * item = [[CTPopoutMenuItem alloc]initWithTitle:[NSString stringWithFormat:@"item%d",i] image:[UIImage imageNamed:nil]];
     [items addObject:item];
     }
     */
    
    
    CTPopoutMenuItem * item1 = [[CTPopoutMenuItem alloc]initWithTitle:@"走失" image:[UIImage imageNamed:@"lost.png"]];
    [items addObject:item1];
    CTPopoutMenuItem * item2 = [[CTPopoutMenuItem alloc]initWithTitle:@"領養" image:[UIImage imageNamed:@"adopt.png"]];
    [items addObject:item2];
    CTPopoutMenuItem * item3 = [[CTPopoutMenuItem alloc]initWithTitle:@"附近生活" image:[UIImage imageNamed:@"lifeButton.png"]];
    [items addObject:item3];
    CTPopoutMenuItem * item4 = [[CTPopoutMenuItem alloc]initWithTitle:@"個人資料" image:[UIImage imageNamed:@"memberSetting.png"]];
    [items addObject:item4];
    CTPopoutMenuItem * item5 = [[CTPopoutMenuItem alloc]initWithTitle:@"設定" image:[UIImage imageNamed:@"settingButton.png"]];
    [items addObject:item5];
    CTPopoutMenuItem * item6 = [[CTPopoutMenuItem alloc]initWithTitle:@"通知" image:[UIImage imageNamed:nil]];
    [items addObject:item6];
    
    
    
    
    self.popMenu = [[CTPopoutMenu alloc]initWithTitle:@"點擊大頭兩下回到首頁" message:nil items:items];
    self.popMenu.delegate = self;

}

-(void)setNaviBtnSetting{
    self.naviBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 50)];
    
    
    UIImage *naviBtnImg = [UIImage imageNamed:@"img.png"];
    [self.naviBtn setImage:naviBtnImg forState:UIControlStateNormal];
    [self.naviBtn addTarget:self action:@selector(showGrid) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(dragTheObj:)];
    
    [self.naviBtn addGestureRecognizer:panGesture];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressedObj:)];
    [self.naviBtn addGestureRecognizer:longGesture];

}

- (void)longPressedObj:(UILongPressGestureRecognizer*)recognizer{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id targetViewController = [storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    [_parentVC presentViewController:targetViewController animated:false completion:nil];
}

-(void)setup{

    [self setCTpopoutMenuItem];
    [self setNaviBtnSetting];
    
}

-(void)setDelegate:(id<NavigationBtnObjecterDelegate>)delegate
{
    _delegate = delegate;
    [[self.delegate attachedViewController].view addSubview:self.naviBtn];
}

- (void)menu:(CTPopoutMenu *)menu willDismissWithSelectedItemAtIndex:(NSUInteger)index{
    
    switch (index) {
        case 0: //走失
        {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            id targetViewController = [storyboard instantiateViewControllerWithIdentifier:@"lost"];
            [_parentVC presentViewController:targetViewController animated:false completion:nil];
            break;
        }
            
        case 1: //領養
        {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"adopt" bundle:nil];
            id targetViewController = [storyboard instantiateViewControllerWithIdentifier:@"adopt"];
            [_parentVC presentViewController:targetViewController animated:false completion:nil];
            break;
        }

            
        case 2: //附近生活
            NSLog(@"%d",index);
            break;
        case 3: //個人資料（訪客點選則出現註冊畫面）
            NSLog(@"%d",index);
            break;
        case 4: //設定
            NSLog(@"%d",index);
            break;
        case 5: //通知
            NSLog(@"%d",index);
            break;

    }

}

- (void)menuwillDismiss:(CTPopoutMenu *)menu{
}

- (void)showGrid{
    self.popMenu.menuStyle = MenuStyleGrid;
    id viewController = [self.delegate attachedViewController];
    [self.popMenu showMenuInParentViewController:viewController withCenter:self.parentVC.view.center];
    NSLog(@"showGrid");
}


- (void)dragTheObj:(UIPanGestureRecognizer*)recognizer{
    UIViewController *viewController = [self.delegate attachedViewController];
    CGPoint translation = [recognizer translationInView:viewController.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:viewController.view];
    
    
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
        CGFloat coorX = recognizer.view.center.x;
        CGFloat coorY = recognizer.view.center.y;
        
        
        [self getSender:recognizer getPositionX:coorX getPositionY:coorY];
        [recognizer setTranslation:CGPointMake(0, 0) inView:viewController.view];
    }
}


- (void)getSender:(UIPanGestureRecognizer*)recognizer getPositionX:(CGFloat)coordX getPositionY:(CGFloat)coordY {
    
    UIViewController *viewController = [self.delegate attachedViewController];
    CGFloat borderWidth = viewController.view.frame.size.width;
    CGFloat borderHeight = viewController.view.frame.size.height;
    
    CGFloat rationX = coordX / borderWidth ;
    CGFloat rationY = coordY / borderHeight ;
    
    BOOL rightBorder = FALSE ;
    BOOL downBorder = FALSE;
    
    
    
    if (rationX >= 0.5) {
        rationX = fabs(--rationX);
        rightBorder = true;
    }
    if (rationY >= 0.5) {
        rationY = fabs(--rationY);
        downBorder = true;
    }
    
    if (rationX > rationY) {
        //top or down
        if (downBorder == false) { //top
            //top有上面的電信資料 高度為20
            recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                                 40);
        }else{ //down
            recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                                 borderHeight-20);
        }
    }else{
        //right or left
        if (rightBorder == true) {
            recognizer.view.center = CGPointMake(borderWidth-20,
                                                 recognizer.view.center.y);
        }else{//left
            recognizer.view.center = CGPointMake(20,
                                                 recognizer.view.center.y);
        }
    }
 
    
}




-(void)dealloc
{
    NSLog(@"dealloc");
}

//- (BOOL)NavigationBtnObjecterShoudDisplay:(UIViewController*)VC{
//   
//    [self.parentVC = VC];
//    [self setup];
//    
//    return false;
//}

/*
 //    if ([self.delegate respondsToSelector:@selector(didChangeValueForKey:)]) {
 //        [self.delegate DidFinishTyping:textField.text];
 //         }
 
 */

@end

