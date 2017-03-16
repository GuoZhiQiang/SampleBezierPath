//
//  ViewController.m
//  TestBezierPath
//
//  Created by guo on 17/3/14.
//  Copyright © 2017年 guo. All rights reserved.
//

#import "ViewController.h"
#import "ShapeLayer.h"

@interface ViewController ()

@property (nonatomic, strong) ShapeLayer *shapeLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shapeLayer = [[ShapeLayer alloc] initWithFrame:self.view.bounds];
    self.view   = _shapeLayer;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
