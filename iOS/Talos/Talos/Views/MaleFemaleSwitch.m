//
//  MaleFemaleSwitch.m
//  Talos
//
//  Created by Anik on 8/7/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "MaleFemaleSwitch.h"

@interface MaleFemaleSwitch(){
    UIView *background;
    UIView *knob;
    UIView *connectedView;
    UIImageView *onImageView;
    UIImageView *offImageView;
    UIImageView *thumbImageView;
    BOOL currentVisualValue;
    BOOL startTrackingValue;
    BOOL didChangeWhileTracking;
    BOOL isAnimating;
    BOOL userDidSpecifyOnThumbTintColor;
}

- (void)showOn:(BOOL)animated;
- (void)showOff:(BOOL)animated;
- (void)setup;

@end

@implementation MaleFemaleSwitch

@synthesize inactiveColor, activeColor, onTintColor, borderColor, thumbTintColor, onThumbTintColor, shadowColor;
@synthesize onImage, offImage, thumbImage;
@synthesize isRounded;
@synthesize on;


#pragma mark init Methods

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 240, 120)];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    // use the default values if CGRectZero frame is set
    CGRect initialFrame;
    if (CGRectIsEmpty(frame)) {
        initialFrame = CGRectMake(0, 0, 240, 120);
    }
    else {
        initialFrame = frame;
    }
    self = [super initWithFrame:initialFrame];
    if (self) {
        [self setup];
    }
    return self;
}


/**
 *	Setup the individual elements of the switch and set default values
 */
- (void)setup {
    
    // default values
    self.on = NO;
    self.isRounded = YES;
    self.inactiveColor = [UIColor clearColor];
    self.activeColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
    self.onTintColor = [UIColor colorWithRed:0.30f green:0.85f blue:0.39f alpha:1.00f];
    self.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.91f alpha:1.00f];
    self.thumbTintColor = [UIColor whiteColor];
    self.onThumbTintColor = [UIColor whiteColor];
    self.shadowColor = [UIColor grayColor];
    currentVisualValue = NO;
    userDidSpecifyOnThumbTintColor = NO;
    
    // background
    background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    background.backgroundColor = [UIColor clearColor];
 //   background.layer.cornerRadius = self.frame.size.height * 0.5;
 //   background.layer.borderColor = self.borderColor.CGColor;
 //   background.layer.borderWidth = 1.0;
  //  background.userInteractionEnabled = NO;
//    background.clipsToBounds = YES;
    [self addSubview:background];
    
    // on/off images
    onImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 15, 60, 60)];
    onImageView.alpha = 1.0;
    onImageView.contentMode = UIViewContentModeScaleAspectFit;
    onImageView.backgroundColor = [UIColor grayColor];
    onImageView.layer.cornerRadius = 30;
    onImageView.clipsToBounds = YES;
  //  onImageView.layer.borderColor = self.borderColor.CGColor;
  //  onImageView.layer.borderWidth = 1.0;
    [background addSubview:onImageView];
    
    offImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 15, 60, 60)];
    offImageView.alpha = 1.0;
    offImageView.contentMode = UIViewContentModeScaleAspectFit;
    offImageView.backgroundColor = [UIColor grayColor];
    offImageView.layer.cornerRadius = 30;
    offImageView.clipsToBounds = YES;
    [background addSubview:offImageView];
    
    //connected view
    connectedView = [[UIView alloc] initWithFrame:CGRectMake(60, 15, 120, 60)];
    connectedView.backgroundColor = [UIColor grayColor];
    connectedView.userInteractionEnabled = NO;
    connectedView.clipsToBounds = YES;
    [background addSubview:connectedView];
    [background sendSubviewToBack:connectedView];
    
    // labels
    self.onLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 90, 60, 30)];
    self.onLabel.textAlignment = NSTextAlignmentCenter;
    self.onLabel.textColor = [UIColor lightGrayColor];
    self.onLabel.font = [UIFont systemFontOfSize:18];
    [background addSubview:self.onLabel];
    
    self.offLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 90, 60, 30)];
    self.offLabel.textAlignment = NSTextAlignmentCenter;
    self.offLabel.textColor = [UIColor lightGrayColor];
    self.offLabel.font = [UIFont systemFontOfSize:18];
    [background addSubview:self.offLabel];
    
    // knob
    knob = [[UIView alloc] initWithFrame:CGRectMake(30, 15, 60, 60)];
    knob.backgroundColor = [UIColor blueColor];
    knob.alpha = 0.5;
    knob.layer.cornerRadius = 30;
  //  knob.layer.shadowColor = self.shadowColor.CGColor;
  //  knob.layer.shadowRadius = 2.0;
  //  knob.layer.shadowOpacity = 0.5;
  //  knob.layer.shadowOffset = CGSizeMake(0, 3);
  //  knob.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:knob.bounds cornerRadius:knob.layer.cornerRadius].CGPath;
    knob.layer.masksToBounds = NO;
    knob.userInteractionEnabled = NO;
    [self addSubview:knob];
    
    // kob image
    thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 15, knob.frame.size.width, knob.frame.size.height)];
    thumbImageView.contentMode = UIViewContentModeCenter;
    thumbImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    offImageView.backgroundColor = [UIColor redColor];
    [knob addSubview:thumbImageView];
    
    isAnimating = NO;
}


#pragma mark Touch Tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    
    startTrackingValue = self.on;
    didChangeWhileTracking = NO;
    
    // make the knob larger and animate to the correct color
    CGFloat activeKnobWidth = 60 - 2 + 5;
    isAnimating = YES;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (self.on) {
            knob.frame = CGRectMake(150 - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.onTintColor;
            knob.backgroundColor = self.onThumbTintColor;
        }
        else {
            knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.activeColor;
            knob.backgroundColor = self.thumbTintColor;
        }
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    // Get touch location
    CGPoint lastPoint = [touch locationInView:self];
    
    // update the switch to the correct visuals depending on if
    // they moved their touch to the right or left side of the switch
    if (lastPoint.x > 150 * 0.5) {
        [self showOn:YES];
        if (!startTrackingValue) {
            didChangeWhileTracking = YES;
        }
    }
    else {
        [self showOff:YES];
        if (startTrackingValue) {
            didChangeWhileTracking = YES;
        }
    }
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    BOOL previousValue = self.on;
    
    if (didChangeWhileTracking) {
        [self setOn:currentVisualValue animated:YES];
    }
    else {
        [self setOn:!self.on animated:YES];
    }
    
    if (previousValue != self.on)
        [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    
    // just animate back to the original value
    if (self.on)
        [self showOn:YES];
    else
        [self showOff:YES];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!isAnimating) {
        CGRect frame = self.frame;
        
        // background
        background.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
       // background.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2;
        
        // images
        onImageView.frame = CGRectMake(30, 15, 60, 60);
        offImageView.frame = CGRectMake(150, 15, 60, 60);
        self.onLabel.frame = CGRectMake(30, 90, 60, 30);
        self.offLabel.frame = CGRectMake(150, 90, 60, 30);
        connectedView.frame = CGRectMake(60, 15, 120, 60);
        // knob
        if (self.on)
            knob.frame = CGRectMake(150, 15, 60, 60);
        else
            knob.frame = CGRectMake(30, 15, 60, 60);
        
        knob.layer.cornerRadius = self.isRounded ? 30 - 1 : 2;
    }
}


#pragma mark Setters

/*
 *	Sets the background color when the switch is off.
 *  Defaults to clear color.
 */
- (void)setInactiveColor:(UIColor *)color {
    inactiveColor = color;
    if (!self.on && !self.isTracking)
        background.backgroundColor = color;
}

/*
 *	Sets the background color that shows when the switch is on.
 *  Defaults to green.
 */
- (void)setOnTintColor:(UIColor *)color {
    onTintColor = color;
    if (self.on && !self.isTracking) {
        background.backgroundColor = color;
        background.layer.borderColor = color.CGColor;
    }
}

/*
 *	Sets the border color that shows when the switch is off. Defaults to light gray.
 */
- (void)setBorderColor:(UIColor *)color {
    borderColor = color;
    if (!self.on)
        background.layer.borderColor = color.CGColor;
}

/*
 *	Sets the knob color. Defaults to white.
 */
- (void)setThumbTintColor:(UIColor *)color {
    thumbTintColor = color;
    if (!userDidSpecifyOnThumbTintColor)
        onThumbTintColor = color;
    if ((!userDidSpecifyOnThumbTintColor || !self.on) && !self.isTracking)
        knob.backgroundColor = color;
}

/*
 *	Sets the knob color that shows when the switch is on. Defaults to white.
 */
- (void)setOnThumbTintColor:(UIColor *)color {
    onThumbTintColor = color;
    userDidSpecifyOnThumbTintColor = YES;
    if (self.on && !self.isTracking)
        knob.backgroundColor = color;
}

/*
 *	Sets the shadow color of the knob. Defaults to gray.
 */
- (void)setShadowColor:(UIColor *)color {
    shadowColor = color;
    knob.layer.shadowColor = color.CGColor;
}

/*
 *	Sets the thumb image.
 */
- (void)setThumbImage:(UIImage *)image
{
    thumbImage = image;
    thumbImageView.image = image;
}

/*
 *	Sets the image that shows when the switch is on.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
- (void)setOnImage:(UIImage *)image {
    onImage = image;
    onImageView.image = image;
}

/*
 *	Sets the image that shows when the switch is off.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
- (void)setOffImage:(UIImage *)image {
    offImage = image;
    offImageView.image = image;
}


/*
 *	Sets whether or not the switch edges are rounded.
 *  Set to NO to get a stylish square switch.
 *  Defaults to YES.
 */
- (void)setIsRounded:(BOOL)rounded {
    isRounded = rounded;
    
    if (rounded) {
        background.layer.cornerRadius = self.frame.size.height * 0.5;
        knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
    }
    else {
        background.layer.cornerRadius = 2;
        knob.layer.cornerRadius = 2;
    }
    
    knob.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:knob.bounds cornerRadius:knob.layer.cornerRadius].CGPath;
}


/*
 * Set (without animation) whether the switch is on or off
 */
- (void)setOn:(BOOL)isOn {
    [self setOn:isOn animated:NO];
}


/*
 * Set the state of the switch to on or off, optionally animating the transition.
 */
- (void)setOn:(BOOL)isOn animated:(BOOL)animated {
    on = isOn;
    
    if (isOn) {
        [self showOn:animated];
    }
    else {
        [self showOff:animated];
    }
}


#pragma mark Getters

/*
 *	Detects whether the switch is on or off
 *
 *	@return	BOOL YES if switch is on. NO if switch is off
 */
- (BOOL)isOn {
    return self.on;
}


#pragma mark State Changes


/*
 * update the looks of the switch to be in the on position
 * optionally make it animated
 */
- (void)showOn:(BOOL)animated {
    CGFloat normalKnobWidth = 60;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (self.tracking)
                knob.frame = CGRectMake(150 - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            else
                knob.frame = CGRectMake(150 - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.onTintColor;
            background.layer.borderColor = self.onTintColor.CGColor;
            knob.backgroundColor = self.onThumbTintColor;
            onImageView.alpha = 1.0;
            offImageView.alpha = 1.0;
            self.onLabel.alpha = 1.0;
            self.offLabel.alpha = 0;
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        if (self.tracking)
            knob.frame = CGRectMake(150 - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        else
            knob.frame = CGRectMake(150 - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        background.backgroundColor = self.onTintColor;
        background.layer.borderColor = self.onTintColor.CGColor;
        knob.backgroundColor = self.onThumbTintColor;
        onImageView.alpha = 1.0;
        offImageView.alpha = 1.0;
        self.onLabel.alpha = 1.0;
        self.offLabel.alpha = 0;
    }
    
    currentVisualValue = YES;
}


/*
 * update the looks of the switch to be in the off position
 * optionally make it animated
 */
- (void)showOff:(BOOL)animated {
    CGFloat normalKnobWidth = 60;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        isAnimating = YES;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            if (self.tracking) {
                knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
                background.backgroundColor = self.activeColor;
            }
            else {
                knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
                background.backgroundColor = self.inactiveColor;
            }
            background.layer.borderColor = self.borderColor.CGColor;
            knob.backgroundColor = self.thumbTintColor;
            onImageView.alpha = 1.0;
            offImageView.alpha = 1.0;
            self.onLabel.alpha = 0;
            self.offLabel.alpha = 1.0;
        } completion:^(BOOL finished) {
            isAnimating = NO;
        }];
    }
    else {
        if (self.tracking) {
            knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.activeColor;
        }
        else {
            knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.inactiveColor;
        }
        background.layer.borderColor = self.borderColor.CGColor;
        knob.backgroundColor = self.thumbTintColor;
        onImageView.alpha = 1.0;
        offImageView.alpha = 1.0;
        self.onLabel.alpha = 0;
        self.offLabel.alpha = 1.0;
    }
    
    currentVisualValue = NO;
}

- (UIColor *)onColor {
    return self.onTintColor;
}

- (void)setOnColor:(UIColor *)color {
    self.onTintColor = color;
}

- (UIColor *)knobColor {
    return self.thumbTintColor;
}

- (void)setKnobColor:(UIColor *)color {
    self.thumbTintColor = color;
}


@end
