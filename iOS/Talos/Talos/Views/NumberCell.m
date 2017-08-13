//
//  NumberCell.m
//  Talos
//
//  Created by Anik on 8/13/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect labelRect = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.contentView.bounds.size.width, 50);
        self.label = [[UILabel alloc] initWithFrame:labelRect];
        self.label.textAlignment = NSTextAlignmentCenter;
    //    self.label.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)configureCellWithNumber:(NSNumber *)number withColor:(UIColor *)color
{
    self.label.text = [number stringValue];
    self.label.textColor = color;
}
@end
