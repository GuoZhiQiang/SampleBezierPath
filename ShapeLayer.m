//
//  ShapeLayer.m
//  TestBezierPath
//
//  Created by guo on 17/3/14.
//  Copyright © 2017年 guo. All rights reserved.
//

#import "ShapeLayer.h"

@interface ShapeLayer ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UIBezierPath *aPath,*zeroPath;

@property (nonatomic, assign) CGPoint deltaPoint;

@property (nonatomic, assign) CGPoint point;

@property (nonatomic, assign) BOOL isAnimated;

@end

@implementation ShapeLayer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    _animated   = YES;
    _isAnimated = YES;
    
    self.backgroundColor = [UIColor lightGrayColor];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 120)/2.0, 300, 120.0, 50.0)];
    
    [btn setTintColor:[UIColor blueColor]];
    [btn setTitle:@"慢动作" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

- (void)btnClick:(UIButton *)sender {
    
    _isAnimated   = !_isAnimated;
    
    self.animated = _isAnimated;
    
    if (_isAnimated) {
        
        [sender setTitle:@"慢动作" forState:UIControlStateNormal];
    }
    else {
        
        [sender setTitle:@"动画" forState:UIControlStateNormal];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    _point = [touches.anyObject locationInView:self];
    
    UITouch *aTouch       = touches.anyObject;
    CGPoint currentPoint  = [aTouch locationInView:self];
    CGPoint previousPoint = [aTouch previousLocationInView:self];
    
    float deltaX = currentPoint.x - previousPoint.x;
    float deltaY = currentPoint.y - previousPoint.y;
    
    _deltaPoint.x += deltaX;
    _deltaPoint.y += deltaY;
    if (_deltaPoint.x < 0) {
        
        _deltaPoint.x = 0;
    }
    if (_deltaPoint.y < 0) {
        
        _deltaPoint.y = 0;
    }
    
    [self addBezierLayer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_animated) {
        
        [self addEndAnimation];
    }
}

- (void)addEndAnimation {
    
    [self.shapeLayer removeAllAnimations];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue         = (__bridge id _Nullable)(self.aPath.CGPath);
    animation.toValue           = (__bridge id _Nullable)(self.zeroPath.CGPath);
    animation.fillMode          = kCAFillModeForwards;
    animation.duration          = 0.3;
    animation.removedOnCompletion = NO;
    
    [self.shapeLayer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(initLayer) withObject:nil afterDelay:0.5];
}

- (void)addBezierLayer {
    
    [self.shapeLayer removeFromSuperlayer];
    
    self.shapeLayer             = [CAShapeLayer layer];
    self.shapeLayer.frame       = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.shapeLayer.fillColor   = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    self.shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    self.shapeLayer.path        = [self createBezierPath].CGPath;
    self.shapeLayer.lineWidth   = 1.0f;
    
    [self.layer addSublayer:self.shapeLayer];
}

- (UIBezierPath *)createBezierPath {
    
    CGFloat width = self.frame.size.width;
    [self.aPath   removeAllPoints];
    [self.aPath   moveToPoint:CGPointMake(0,0)];
    [self.aPath   addLineToPoint:CGPointMake(width,0)];
    [self.aPath   addQuadCurveToPoint:CGPointMake(0,0) controlPoint:CGPointMake(width/2.0+ _point.x<width/2.0?(-_point.x):_point.x, _deltaPoint.y)];
    
    return self.aPath;
}

- (UIBezierPath *)aPath {
    
    if (_aPath == nil) {
        
        _aPath = [UIBezierPath bezierPath];
    }
    
    return _aPath;
}

- (UIBezierPath *)zeroPath {
    
    if (_zeroPath == nil) {
        
        CGFloat width = self.frame.size.width;
        
        _zeroPath  = [UIBezierPath bezierPath];
        [_zeroPath moveToPoint:CGPointMake(0,0)];
        [_zeroPath addLineToPoint:CGPointMake(width, 0)];
        [_zeroPath addQuadCurveToPoint:CGPointMake(0,0) controlPoint:CGPointMake(width/2.0+ _point.x<width/2.0?(-_point.x):_point.x, 0)];
    }
    
    return _zeroPath;
}

- (CAShapeLayer *)shapeLayer {
    
    if (_shapeLayer == nil) {
        
        _shapeLayer = [CAShapeLayer layer];
    }
    
    return _shapeLayer;
}

- (void)setAnimated:(BOOL)animated {
    
    if (_animated != animated) {
        
        _animated = animated;
        
        [self initLayer];
    }
}

- (void)initLayer {
    
    _point      = CGPointMake(0,0);
    _deltaPoint = CGPointMake(0,0);
    
    [_aPath removeAllPoints];
    _aPath      = nil;
    
    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
