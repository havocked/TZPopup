//
//  TZPopupViewController.m
//  TZPopupExampleApp
//
//  Created by Nataniel Martin on 08/07/15.
//  Copyright (c) 2015 Nataniel Martin. All rights reserved.
//

#import "TZPopupViewController.h"

#import <TZPopup.h>

@interface TZPopupViewController ()

@end

@implementation TZPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_popupView.layer setCornerRadius:8.f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissButton:(id)sender {
    [TZPopup dismissPopupWithAnimation:YES];
}
@end
