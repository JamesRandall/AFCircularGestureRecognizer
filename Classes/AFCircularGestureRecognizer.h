//
//  AFCircularGestureRecognizer.h
//  AFCircularGestureRecognizer
//
//  Created by James Randall on 04/01/2011.
//  Copyright 2011 Accidental Fish Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFCircularGestureRecognizer : UIGestureRecognizer {
	CGFloat _outerRadius;
	CGFloat _innerRadius;
	CGFloat _radialCenterX;
	CGFloat _radialCenterY;
	
	int _quadrantsMovedThrough;
	SEL _action;
}

- (id)initWithTarget:(id)target action:(SEL)action outerRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius;

@end
