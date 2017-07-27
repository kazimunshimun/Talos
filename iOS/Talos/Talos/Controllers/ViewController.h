//
//  ViewController.h
//  Talos
//
//  Created by Anik on 7/25/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *mPageControl;
@property (weak, nonatomic) IBOutlet UIButton *mNextButton;
@property (weak, nonatomic) IBOutlet UIButton *mPreviousButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDescriptionLabel;

@end

