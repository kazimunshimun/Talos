//
//  ColorUtils.m
//  Talos
//
//  Created by Anik on 8/13/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils

+(UIColor *) UIColorFromRGB:(unsigned) hexColor{
    return [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 \
                           green:((float)((hexColor & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((hexColor & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

@end
