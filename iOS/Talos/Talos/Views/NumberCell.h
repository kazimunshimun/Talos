//
//  NumberCell.h
//  Talos
//
//  Created by Anik on 8/13/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;

- (void)configureCellWithNumber:(NSNumber *)number withColor:(UIColor *)color;

@end
