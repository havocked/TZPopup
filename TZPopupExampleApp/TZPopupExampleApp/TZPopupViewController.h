//
//  TZPopupViewController.h
//  TZPopupExampleApp
//
//  Created by Nataniel Martin on 08/07/15.
//  Copyright (c) 2015 Nataniel Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZPopupViewController : UIViewController

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UIView *popupView;

#pragma mark - Actions
- (IBAction)dismissButton:(id)sender;

@end
