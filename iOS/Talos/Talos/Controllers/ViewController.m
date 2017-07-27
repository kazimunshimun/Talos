//
//  ViewController.m
//  Talos
//
//  Created by Anik on 7/25/17.
//  Copyright © 2017 mTeam. All rights reserved.
//

#import "ViewController.h"
#import "GenderSelectionView.h"
#import "AgeSelectionView.h"
#import "WeightSelectionView.h"
#import "HeightSelectionView.h"
#import "FitnessGoalSelectionView.h"

@interface ViewController (){
    int mCurrentPage;
    NSArray *mTitleData;
    NSArray *mDescriptionData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initViews];
    [self initData];
    [self updateTitleDescriptionText];
}

-(void)initViews {
    mCurrentPage = 0;
    [self.mPreviousButton setEnabled:NO];
    [self initScrollView];
}

-(void)initData {
    mTitleData = @[@"Choose your gender",
                   @"How old are you?",
                   @"How tall are you?",
                   @"How much do you weight?",
                   @"What is your fitness goal?"];
    
    mDescriptionData = @[@"This will help us to adjust reps, weights and plan for you.",
                         @"This is used to provide you with more suitable workout plans and let you track your progress.",
                         @"This is used to provide you with more suitable workout plans and let you track your progress.",
                         @"This is used to provide you with more suitable workout plans and let you track your progress.",
                         @"This is used to provide you with more suitable workout plans and let you track your progress."];
}

-(void)initScrollView {
    
    CGFloat scrollViewWidth = self.mScrollView.frame.size.width;
    CGFloat scrollViewHeight = self.mScrollView.frame.size.height;
    
    self.mScrollView.contentSize = CGSizeMake(self.mScrollView.frame.size.width * self.mPageControl.numberOfPages, self.mScrollView.frame.size.height);
    self.mScrollView.pagingEnabled = YES;
    self.mScrollView.showsHorizontalScrollIndicator = NO;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.scrollsToTop = NO;
    self.mScrollView.delegate = self;
    
    //3
    
    GenderSelectionView *viewOne = [[GenderSelectionView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth, scrollViewHeight)];
    AgeSelectionView *viewTwo = [[AgeSelectionView alloc] initWithFrame:CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)];
    WeightSelectionView *viewThree = [[WeightSelectionView alloc] initWithFrame:CGRectMake(scrollViewWidth*2, 0, scrollViewWidth, scrollViewHeight)];
    HeightSelectionView *viewFour = [[HeightSelectionView alloc] initWithFrame:CGRectMake(scrollViewWidth*3, 0, scrollViewWidth, scrollViewHeight)];
    FitnessGoalSelectionView *viewFive = [[FitnessGoalSelectionView alloc] initWithFrame:CGRectMake(scrollViewWidth*4, 0, scrollViewWidth, scrollViewHeight)];
    
    [self.mScrollView addSubview:viewOne];
    [self.mScrollView addSubview:viewTwo];
    [self.mScrollView addSubview:viewThree];
    [self.mScrollView addSubview:viewFour];
    [self.mScrollView addSubview:viewFive];
    
    self.mScrollView.scrollEnabled = NO;
}

#pragma mark - ScrollView Delegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
  //  NSLog(@"scrollView Did End Scrolling Animation");
    self.mNextButton.enabled = YES;
    [self updatePreviousNextButton];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonPressed:(id)sender {
  //  NSLog(@"next button pressed");
    
    if (mCurrentPage != self.mPageControl.numberOfPages - 1) {
        mCurrentPage++;
        [self.mPageControl setCurrentPage:mCurrentPage];
        [self moveToNextPage];
        [self updateTitleDescriptionText];
    }else{
        //done button pressed, go to next view
    }
    
}

- (IBAction)previousButtonPressed:(id)sender {
  //  NSLog(@"privious button pressed");
    if (mCurrentPage != 0) {
        mCurrentPage--;
        [self.mPageControl setCurrentPage:mCurrentPage];
        [self moveToPriviousPage];
        [self updateTitleDescriptionText];
    }
}

-(void)updatePreviousNextButton {
 //   NSLog(@"update next privious button pressed");
    if(mCurrentPage == self.mPageControl.numberOfPages - 1){
        [self.mNextButton setImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    }else{
        [self.mNextButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    }
    
    if(mCurrentPage == 0) {
    //    NSLog(@"current page is 0");
        [self.mPreviousButton setEnabled:NO];
    }else{
    //    NSLog(@"current page is not 0");
        [self.mPreviousButton setEnabled:YES];
    }
}

-(void)moveToNextPage {
    CGFloat pageWidth = self.mScrollView.frame.size.width;
    CGFloat contentOffset = self.mScrollView.contentOffset.x;
    CGFloat slideToX = contentOffset + pageWidth;
    
  //  NSLog(@"scrollView scrollRectToVisible called on Next Button");
    self.mNextButton.enabled = NO;
    self.mPreviousButton.enabled = NO;
    [self.mScrollView scrollRectToVisible:CGRectMake(slideToX, 0, pageWidth, self.mScrollView.frame.size.height) animated:YES];
    
}

-(void)moveToPriviousPage {
    CGFloat pageWidth = self.mScrollView.frame.size.width;
    CGFloat contentOffset = self.mScrollView.contentOffset.x;
    CGFloat slideToX = contentOffset - pageWidth;

  //  NSLog(@"scrollView scrollRectToVisible called on Previous Button");
    self.mNextButton.enabled = NO;
    self.mPreviousButton.enabled = NO;
    [self.mScrollView scrollRectToVisible:CGRectMake(slideToX, 0, pageWidth, self.mScrollView.frame.size.height) animated:YES];
    
}

-(void)updateTitleDescriptionText {
    self.mTitleLabel.text = [mTitleData objectAtIndex:mCurrentPage];
    self.mDescriptionLabel.text = [mDescriptionData objectAtIndex:mCurrentPage];
}

@end
