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
For now the library is using a singleton pattern to modify its properties, so just go ahead and set wathever public available properties you want
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

And finally when you want to dismiss the popup
```objective-c
[TZPopup dismissPopupWithAnimation:YES];
```


### Delegates (optionals)
```objective-c
- (void) popupDidShow;
- (void) popupDidDismiss;
```

### Discussion
- I'm using [FXBlurView](https://github.com/nicklockwood/FXBlurView) awesome library to enable blurred background
- Singleton pattern is used, but maybe it's not good, if you have a better idea, I'm really open to discuss on this matter !

### Development

- Want to contribute? Great! Do not hesitate to add a Issue/Fork/Comment my code ! I will try my best to answer quickly your questions !
- I'm not an expert and I'm excited to learn some best practices, show me your tricks !


### Todo's

 - ~~Put in cocoapods~~
 - Handle landscape orientation
 - add 3D Transformation properties
 - Add Top / Left "from" animation 

License
----
MIT


**Free Code, Hell Yeah!**