//
//  NumberPickerView.h
//  Talos
//
//  Created by Anik on 8/13/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberPickerView;

@protocol NumberPickerDelegate <NSObject>

@optional
- (void)numberPicker:(NumberPickerView *)numberPicker didPickNumber:(NSInteger)value atIndex:(NSInteger)index;

@end

@interface NumberPickerView : UIView

@property (nonatomic, weak) id <NumberPickerDelegate> numberPickerDelegate;

/* CollectionView providing functionality for horizontal scrolling of numbers */
@property (nonatomic, strong) UICollectionView *collectionView;

/* Array of NSNumbers which represent the range of values to select from the picker */
@property (nonatomic, copy) NSArray *numbersList;

/* Color for text labels when not selected */
@property (nonatomic, strong) IBInspectable UIColor *unselectedColor;

/* Color for circle mask and color for text label when selected */
@property (nonatomic, strong) IBInspectable UIColor *selectedColor;

/* The minimum value for the control, inclusive */
@property (nonatomic, assign) IBInspectable NSInteger minimumValue;

/* The maximum value for the control, inclusive */
@property (nonatomic, assign) IBInspectable NSInteger maximumValue;

/* The default value to highlight when first loading the control */
@property (nonatomic, assign) IBInspectable NSInteger defaultValue;

/* The controls current value */
@property (nonatomic, assign, readonly) NSInteger currentValue;

/* Programatically scroll to the number with associated value. If the value does not exist scrolling will not occur */
- (void)highlightNumberWithValue:(NSInteger)value animated:(BOOL)animated;

/* Programatically scroll to the number at a given index. If the index does not exist scrolling will not occur */
- (void)highlightNumberAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
