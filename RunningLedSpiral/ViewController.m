//
//  ViewController.m
//  RunningLedSpiral
//
//  Created by Xmob - Longdt on 5/5/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    CGFloat _space;
    NSTimer* _timer;
    int _lastOnLED;
    int _allBall;
    Boolean _leftToRight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _space = 40.0;
    _lastOnLED = -1;
    _allBall = 0;
    _leftToRight = true;
    
    [self drawRowBallsSpiral:9];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLEDLeftToRight) userInfo:nil repeats:true];
}

-(void) runningLEDLeftToRight{
    if (_lastOnLED != -1){
        [self turnOFFLed:_lastOnLED];
    }
    if (_leftToRight){
        if (_lastOnLED != _allBall - 1){
            _lastOnLED ++;
        }else{
            _lastOnLED --;
            _leftToRight = false;
        }
    }else{
        if (_lastOnLED != 0){
            _lastOnLED --;
        }else{
            _lastOnLED ++;
            _leftToRight = true;
        }
    }
    [self turnONLed:_lastOnLED];
}

- (void) turnONLed: (int)index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}

- (void) turnOFFLed: (int)index{
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"orange"];
    }
}

-(void) placeGreyBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int)tag{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orange"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    _allBall++;
}


- (void) drawRowBallsSpiral: (int) n{
    int i;
    int d = 0;
    int tag = 100;
    int row = n-1;
    int col = n-1;
    
    while (d <= n/2){
        for (i = d; i<= col; i++) {
            [self placeGreyBallAtX: i*_space + _margin
                              andY: d*_space + _margin
                           withTag: tag];
            tag++ ;
        }
        for (i = d + 1; i<= row; i++) {
            [self placeGreyBallAtX: col *_space + _margin
                              andY: i* _space + _space
                           withTag: tag];
            tag++ ;
        }
        for (i = col - 1; i >= d; i--) {
            [self placeGreyBallAtX: i*_space + _margin
                              andY: row* _space + _space
                           withTag: tag];
            tag++ ;
        }
        for (i = row - 1; i > d; i--) {
            [self placeGreyBallAtX: _margin + d*_space
                              andY: i* _space + _space
                           withTag: tag];
            tag++ ;
        }
        d++;
        row--;
        col--;
    }
}

@end
