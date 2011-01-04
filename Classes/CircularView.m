//
//  CircularView.m
//  AFCircularGestureRecognizer
//
//  Created by James Randall on 04/01/2011.
//  Copyright 2011 Accidental Fish Ltd. All rights reserved.
//

#import "CircularView.h"


@implementation CircularView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	const CGFloat kOuterRadius = 150;
	const CGFloat kInnerRadius = 75;
	
	CGFloat midX = CGRectGetMidX(self.bounds);
	CGFloat midY = CGRectGetMidY(self.bounds);
	CGRect outerEllipseRect = CGRectMake(midX - kOuterRadius, midY - kOuterRadius, kOuterRadius * 2, kOuterRadius * 2);
	CGRect innerEllipseRect = CGRectMake(midX - kInnerRadius, midY - kInnerRadius, kInnerRadius * 2, kInnerRadius * 2);
									
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
	CGContextFillEllipseInRect(context, outerEllipseRect);
	
	CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
	CGContextFillEllipseInRect(context, innerEllipseRect);
}


- (void)dealloc {
    [super dealloc];
}


@end
