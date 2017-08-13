//
//  GenderSelectionView.m
//  Talos
//
//  Created by Anik on 7/27/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "GenderSelectionView.h"
#import "ColorUtils.h"

@implementation GenderSelectionView

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
    
 //   [[UIColor whiteColor] set];
    [[ColorUtils UIColorFromRGB:0x25292D] set];
  //  [[UIColor colorWithRed:37/255.0 green:41/255.0 blue:45/255.0 alpha:1.0] set];
    UIRectFill(bounds);
    
    // Example of a bigger switch with images
    _maleFemleSwitch = [[MaleFemaleSwitch alloc] init];
    _maleFemleSwitch.center = CGPointMake(190, 150);
    // [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    _maleFemleSwitch.offImage = [UIImage imageNamed:@"women"];
    _maleFemleSwitch.onImage = [UIImage imageNamed:@"man"];
    _maleFemleSwitch.onLabel.text = @"Male";
    _maleFemleSwitch.offLabel.text = @"Female";
    _maleFemleSwitch.onTintColor = [UIColor blueColor];
    //  mySwitch2.isRounded = NO;
    [self addSubview:_maleFemleSwitch];
     [_maleFemleSwitch setOn:YES animated:YES];
}


@end
