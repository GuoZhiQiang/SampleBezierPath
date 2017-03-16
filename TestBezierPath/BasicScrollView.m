//
//  BasicScrollView.m
//  TestBezierPath
//
//  Created by guo on 17/3/14.
//  Copyright © 2017年 guo. All rights reserved.
//

#import "BasicScrollView.h"

@implementation BasicScrollView

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesMoved");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    NSLog(@"touchesBegan");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    NSLog(@"touchesEnded");
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    NSLog(@"touchesCancelled");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
