//
//  AFCircularGestureRecognizerViewController.m
//  AFCircularGestureRecognizer
//
//  Created by James Randall on 04/01/2011.
//  Copyright 2011 Accidental Fish Ltd. All rights reserved.
//

#import "AFCircularGestureRecognizerViewController.h"
#import "AFCircularGestureRecognizer.h"

@implementation AFCircularGestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view addGestureRecognizer:[[[AFCircularGestureRecognizer alloc] initWithTarget:self action:@selector(circularComplete:) outerRadius:150 innerRadius:75] autorelease]];
}

- (void)circularComplete:(AFCircularGestureRecognizer*)recognizer
{
	UIAlertView *view = [[[UIAlertView alloc] initWithTitle:@"Complete" message:@"Circular gesture recognised" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[view show];
}

@end
