//
//  AgeSelectionView.h
//  Talos
//
//  Created by Anik on 7/27/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberPickerView.h"

@interface AgeSelectionView : UIView<NumberPickerDelegate>

@property (nonatomic, strong) NumberPickerView *agePicker;

@end
