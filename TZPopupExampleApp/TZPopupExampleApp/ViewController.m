//
//  ViewController.m
//  TZPopupExampleApp
//
//  Created by Nataniel Martin on 08/07/15.
//  Copyright (c) 2015 Nataniel Martin. All rights reserved.
//

#import "ViewController.h"
#import "TZPopupViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Init general properties of popup
    [[TZPopup shared] setBackgroundColor:[UIColor blackColor]];
    [[TZPopup shared] setBackgroundMaxAlpha:50.f];
    [[TZPopup shared] setPopAnimation:TZPopAnimationBottom];
    [[TZPopup shared] setBlurEnabled:YES];
}

- (IBAction)buttonAction:(id)sender {

    //Init delegate
    [[TZPopup shared] setDelegate:self];
    
    //Init the uiviewcontroller you want to pop
    TZPopupViewController *viewControllerToPop = [[TZPopupViewController alloc] initWithNibName:@"TZPopupViewController" bundle:nil];
    
    //Show popup
    [TZPopup showPopup:viewControllerToPop incontroller:self];
}

- (void)popupDidShow {
    NSLog(@"Popup did show, wizzz");
}

- (void)popupDidDismiss {
    NSLog(@"popup did dismiss, :'(");
}

@end
