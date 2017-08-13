//
//  AgeSelectionView.m
//  Talos
//
//  Created by Anik on 7/27/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "AgeSelectionView.h"
#import "ColorUtils.h"

@implementation AgeSelectionView

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
    [[ColorUtils UIColorFromRGB:0x25292D] set];
    UIRectFill(bounds);
    
  //  self.bedroomsPicker = [[NumberPickerView alloc] initWithFrame:CGRectMake(15, 190, 345, 80)];
    self.agePicker = [[NumberPickerView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 - 80, 80, 160, 240)];
    self.agePicker.minimumValue = 1;
    self.agePicker.maximumValue = 150;
    self.agePicker.defaultValue = 1;
    self.agePicker.unselectedColor = [UIColor lightGrayColor];
    self.agePicker.selectedColor = [UIColor whiteColor];
    self.agePicker.backgroundColor = [UIColor clearColor];
    self.agePicker.numberPickerDelegate = self;
    [self addSubview:self.agePicker];
}

#pragma mark - NumberDelegate
- (void)numberPicker:(NumberPickerView *)numberPicker didPickNumber:(NSInteger)value atIndex:(NSInteger)index
{
    NSLog(@"age: %ld", (long)value);
 //   self.bedroomsLabel.text = [NSString stringWithFormat:@"%ld", (long)value];
}

@end
