//
//  HeightSelectionView.m
//  Talos
//
//  Created by Anik on 7/27/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "HeightSelectionView.h"

@implementation HeightSelectionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initialized");
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = [self bounds];
    
    [[UIColor brownColor] set];
    UIRectFill(bounds);
    
    CGRect square = CGRectMake(10, 10, 10, 100);
    [[UIColor blackColor] set];
    UIRectFill(square);
    
    [[UIColor redColor] set];
    UIRectFill(square);
    NSLog(@"drawRect called");
}

@end
