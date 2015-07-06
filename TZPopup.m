//
//  TZPopup.m
//  ContainerViewController
//
//  Created by Nataniel Martin on 03/07/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import "TZPopup.h"
#import "UIColor+Extend.h"

UIScrollView *_scrollview;

#define ROTATION_DEGREE 90

@implementation TZPopup

+ (instancetype) shared {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Public methods

+ (void) showPopup:(UIViewController *)viewcontroller incontroller:(UIViewController *)controller {
    [[self shared] showPopup:viewcontroller incontroller:controller];
}

+ (void) dismissPopupWithAnimation:(BOOL)animated {
    [[self shared] scrollToPage:0 animated:animated];
}

#pragma mark - Private Methods
- (id) init {
    self = [super init];
    if (self) {
        //Defaults values
        _backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.f];
        _backgroundMaxAlpha = 50;
        _popAnimation = TZPopAnimationBottom;
    }
    return self;
}

- (void) showPopup:(UIViewController *)viewcontrollerToShow incontroller:(UIViewController *)parentController {
    
#warning TODO: to remove TEMPVC
    _tempVC = viewcontrollerToShow;
    
    //Scrollview is the container of the popup
    //Will take the frame of the parentViewController
    #warning TODO: Use constraints instead
    _scrollview = [[UIScrollView alloc] initWithFrame:parentController.view.frame];
    
    if (_blurEnabled) {
        _blurView = [[FXBlurView alloc] init];
        [_blurView setDynamic:NO];
        [_blurView setFrame:parentController.view.frame];
        [_blurView setAlpha:0.f];
    }
    
    [_scrollview setDelegate:(id<UIScrollViewDelegate>)self];
    [_scrollview setShowsHorizontalScrollIndicator:NO];
    [_scrollview setShowsVerticalScrollIndicator:NO];
    [_scrollview addSubview:_tempVC.view];
    _scrollview.pagingEnabled = YES;
    

    CGRect frame = _tempVC.view.frame;
    switch (_popAnimation) {
        case TZPopAnimationBottom:
            frame.origin.y = parentController.view.frame.size.height;
            _scrollview.contentSize = CGSizeMake(parentController.view.frame.size.width, parentController.view.frame.size.height * 2);
            break;
        case TZPopAnimationTop:
            frame.origin.y = parentController.view.frame.size.height * -1;
            _scrollview.contentSize = CGSizeMake(parentController.view.frame.size.width, parentController.view.frame.size.height * 2);
            break;
        case TZPopAnimationLeft:
            frame.origin.x = parentController.view.frame.size.width * -1;
            _scrollview.contentSize = CGSizeMake(parentController.view.frame.size.width, parentController.view.frame.size.height * 2);
            break;
        case TZPopAnimationRight:
            frame.origin.x = parentController.view.frame.size.width;
            _scrollview.contentSize = CGSizeMake(parentController.view.frame.size.width * 2, parentController.view.frame.size.height);
            break;
            
        default:
            break;
    }
    _tempVC.view.frame = frame;
    [parentController addChildViewController:_tempVC];
    [_tempVC didMoveToParentViewController:parentController];
    [parentController.view addSubview:_blurView];
    
    [parentController.view addSubview:_scrollview];
    
    [self scrollToPage:1 animated:YES];
    
    //Trigger delegate when popup showed
    if([_delegate respondsToSelector:@selector(popupDidShow)]){
        [_delegate popupDidShow];
    }
}

- (void) scrollToPage:(NSInteger)page animated:(BOOL)animated{
    CGRect scrollframe = _scrollview.frame;
    
    switch (_popAnimation) {
        case TZPopAnimationBottom:
            scrollframe.origin.y = scrollframe.size.height * page;
            break;
        case TZPopAnimationTop:
            scrollframe.origin.y = scrollframe.size.height * page * -1;
            break;
        case TZPopAnimationLeft:
            scrollframe.origin.x = scrollframe.size.width * page * -1;
            break;
        case TZPopAnimationRight:
            scrollframe.origin.x = scrollframe.size.width * page;
            break;
        default:
            break;
    }
    
//    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//        [_scrollview scrollRectToVisible:scrollframe animated:NO];
//    } completion:nil];
    
    [_scrollview scrollRectToVisible:scrollframe animated:animated];
    if (!animated && page != 1) {
        //Should clean popup
        [self cleanPopup];
    }
}

- (void) cleanPopup {
    [_blurView removeFromSuperview];
    [_scrollview removeFromSuperview];
    _tempVC = nil;
    
    if (_blurEnabled) {
        _blurView = nil;
    }
    
    //Trigger delegate when popup dismissed
    if([_delegate respondsToSelector:@selector(popupDidDismiss)]){
        [_delegate popupDidDismiss];
    }
}

- (BOOL) shouldCleanPopup:(UIScrollView *)scrollView {
    int page;
    switch (_popAnimation) {
        case TZPopAnimationBottom:
            page = scrollView.contentOffset.y / scrollView.frame.size.height;
            break;
        case TZPopAnimationTop:
            page = scrollView.contentOffset.y / scrollView.frame.size.height;
            break;
        case TZPopAnimationLeft:
            page = scrollView.contentOffset.x / scrollView.frame.size.width;
            break;
        case TZPopAnimationRight:
            page = scrollView.contentOffset.x / scrollView.frame.size.width;
            break;
        default:
            page = 0;
            break;
    }
    if (page != 1) {
        return YES;
    }
    return NO;
}

#pragma mark - UIScrollview Delegates

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    BOOL shouldClean = [self shouldCleanPopup:scrollView];
    if (shouldClean) {
        [self cleanPopup];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // vertical
    CGFloat maximumVerticalOffset = scrollView.contentSize.height - CGRectGetHeight(scrollView.frame);
    CGFloat currentVerticalOffset = scrollView.contentOffset.y;
    
    // horizontal
    CGFloat maximumHorizontalOffset = scrollView.contentSize.width - CGRectGetWidth(scrollView.frame);
    CGFloat currentHorizontalOffset = scrollView.contentOffset.x;
    
    // percentages
    CGFloat percentageHorizontalOffset = currentHorizontalOffset / maximumHorizontalOffset;
    CGFloat percentageVerticalOffset = currentVerticalOffset / maximumVerticalOffset;
    
    //NSLog(@"HORIZONTAL: %f | VERTICAL : %f", percentageHorizontalOffset, percentageVerticalOffset);
    if (_backgroundColor) {
        CGFloat percentAlpha = (percentageVerticalOffset * _backgroundMaxAlpha) / 100;
        [_scrollview setBackgroundColor:[_backgroundColor colorByChangingAlphaTo:percentAlpha]];
        //[_scrollview setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:]];
    }
    
    if (_blurEnabled) {
        [_blurView setAlpha:percentageVerticalOffset];
    }
    
    
    
    CGFloat rotatePercent = ROTATION_DEGREE - ((ROTATION_DEGREE * (percentageVerticalOffset * 100)) / 100);
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, rotatePercent * M_PI / 180.0f, 1, 0, 0);
    _tempVC.view.layer.transform = t;
     
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL shoudlClean = [self shouldCleanPopup:scrollView];
    if (shoudlClean) {
        [self cleanPopup];
    }
}

@end
