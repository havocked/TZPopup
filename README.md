# TZPopup

TZPopup helps you pop a viewcontroller

![Demo](http://havocked.github.io/TZPopupExample.gif)


### Version
0.0.1

### Installation

- If you are using Cocoapods, insert the line below into your podfile

```objectivec
    pod 'TZPopup', '~> 0.0.1'
```
- OR manually import TZPopup.h, TZPopup.m + UIKit directory into your project

### How to use

First you want to import the library into your viewController
```objective-c
#import <TZPopup.h>
```
For now the library is using a singleton pattern to modify it's properties, so just go ahead and set wathever public properties you want
```objective-c
//Init general properties of popup
[[TZPopup shared] setBackgroundColor:[UIColor blackColor]];
[[TZPopup shared] setBackgroundMaxAlpha:50.f];
[[TZPopup shared] setPopAnimation:TZPopAnimationBottom];
[[TZPopup shared] setBlurEnabled:YES];
```

when you are ready to pop your viewController, 3 lines:

```objective-c
//Init delegate
[[TZPopup shared] setDelegate:self];
    
//Init the uiviewcontroller you want to pop
TZPopupViewController *viewControllerToPop = [[TZPopupViewController alloc] initWithNibName:@"TZPopupViewController" bundle:nil];
    
//Show popup
[TZPopup showPopup:viewControllerToPop incontroller:self];
```


### Delegates (optionals)
```objective-c
- (void) popupDidShow;
- (void) popupDidDismiss;
```

### Development

- Want to contribute? Great! Do not hesitate to comment my code ! I will try my best to answer your questions !
- I'm not an expert and i'm excited to learn some best practices, show me your tricks !


### Todo's

 - ~~Put in cocoapods~~
 - Handle landscape orientation
 - add 3dTrasform properties
 - Add Top / Left "from" animation 

License
----
MIT


**Free Code, Hell Yeah!**