//
//  lostMapViewController.m
//  TakeMeHome
//
//  Created by Josh on 2015/7/28.
//  Copyright (c) 2015年 Josh. All rights reserved.
//

#import "lostMapViewController.h"
#import <MapKit/MapKit.h>

@interface lostMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) NSTimer * timer;
@end

@implementation lostMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(changeMapView) userInfo:nil repeats:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeMapView) userInfo:nil repeats:NO];
}

- (void)changeMapView
{
    [self.timer invalidate];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.mapView setFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
