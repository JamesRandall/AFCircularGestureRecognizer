//
//  AFCircularGestureRecognizerAppDelegate.h
//  AFCircularGestureRecognizer
//
//  Created by James Randall on 04/01/2011.
//  Copyright 2011 Accidental Fish Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFCircularGestureRecognizerViewController;

@interface AFCircularGestureRecognizerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AFCircularGestureRecognizerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AFCircularGestureRecognizerViewController *viewController;

@end

