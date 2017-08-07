//
//  GenderSelectionView.m
//  Talos
//
//  Created by Anik on 7/27/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "GenderSelectionView.h"
#import "GenderSwitch.h"
#import "MaleFemaleSwitch.h"

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
    
    [[UIColor whiteColor] set];
    UIRectFill(bounds);
    
    /*
    // Example of a bigger switch with images
    GenderSwitch *mySwitch2 = [[GenderSwitch alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    mySwitch2.center = CGPointMake(200, 200);
   // [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch2.offImage = [UIImage imageNamed:@"women"];
    mySwitch2.onImage = [UIImage imageNamed:@"man"];
    mySwitch2.onTintColor = [UIColor blueColor];
  //  mySwitch2.isRounded = NO;
    [self addSubview:mySwitch2];
     
    
    // turn the switch on with animation
 //   [mySwitch2 setOn:YES animated:YES];
    */
    
    // Example of a bigger switch with images
    MaleFemaleSwitch *mySwitch2 = [[MaleFemaleSwitch alloc] init];
    mySwitch2.center = CGPointMake(190, 200);
    // [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch2.offImage = [UIImage imageNamed:@"women"];
    mySwitch2.onImage = [UIImage imageNamed:@"man"];
    mySwitch2.onLabel.text = @"Male";
    mySwitch2.offLabel.text = @"Female";
    mySwitch2.onTintColor = [UIColor blueColor];
    //  mySwitch2.isRounded = NO;
    [self addSubview:mySwitch2];
}


@end
