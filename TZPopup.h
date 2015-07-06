//
//  TZPopup.h
//  ContainerViewController
//
//  Created by Nataniel Martin on 03/07/15.
//  Copyright (c) 2015 Yan Saraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FXBlurView.h>

typedef NS_ENUM(NSInteger, TZPopAnimation) {
    TZPopAnimationNone,
    TZPopAnimationBottom,
    TZPopAnimationTop,
    TZPopAnimationRight,
    TZPopAnimationLeft
};

@class TZPopup;
@protocol TZPopupDelegate <NSObject>
@optional
- (void) popupDidShow;
- (void) popupDidDismiss;

@end

@interface TZPopup : NSObject <UIScrollViewDelegate>

@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, weak) UIViewController *tempVC;

#pragma mark - Delegate
@property (nonatomic, weak) id<TZPopupDelegate> delegate;

#pragma mark - Popup Public properties
@property (nonatomic) UIColor   *backgroundColor;

/*! @brief Should be set between 0.f to 100.f (like a percentage: 0% to 100% of alpha) */
@property (nonatomic) CGFloat   backgroundMaxAlpha;
@property (nonatomic) TZPopAnimation popAnimation;
@property (nonatomic) BOOL blurEnabled;

#pragma mark - Singleton Pattern
/*! @brief Singleton pattern, open to dicussion on how to show the popup */
+ (instancetype) shared;

#pragma mark - Public methods

/*!
 * @discussion Shows the popup with properties setted previously
 * @param viewcontroller The viewController that needs to be shown
 * @param controller The viewController where the popup shows above
 */
+ (void) showPopup:(UIViewController *)viewcontroller incontroller:(UIViewController *)controller;

+ (void) dismissPopupWithAnimation:(BOOL)animated;

@end
