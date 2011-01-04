//
//  AFCircularGestureRecognizer.m
//  AFCircularGestureRecognizer
//
//  Created by James Randall on 04/01/2011.
//  Copyright 2011 Accidental Fish Ltd. All rights reserved.
//

#import "AFCircularGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

const int AFCircularGestureRecognizerQuadrantNone = 0;
const int AFCircularGestureRecognizerQuadrantFore = 1;
const int AFCircularGestureRecognizerQuadrantLeft = 2;
const int AFCircularGestureRecognizerQuadrantRear = 4;
const int AFCircularGestureRecognizerQuadrantRight = 8;
const int AFCircularGestureRecognizerQuadrantAll = 15;

@interface AFCircularGestureRecognizer (private)

- (int)pointInQuadrant:(CGPoint)point;

@end

@implementation AFCircularGestureRecognizer (private)

- (int)pointInQuadrant:(CGPoint)point
{
	CGFloat yDistance = point.y - _radialCenterY;
	CGFloat xDistance = point.x - _radialCenterX;
	CGFloat measuredRadius = sqrtf(xDistance * xDistance + yDistance * yDistance);
	
	if (measuredRadius > _outerRadius || measuredRadius < _innerRadius)
		return AFCircularGestureRecognizerQuadrantNone;
	
	CGFloat angleInRadians = asin(yDistance/measuredRadius);
	CGFloat angleInDegrees = angleInRadians * 180 / M_PI;
		
	if (angleInDegrees < -45)
		return AFCircularGestureRecognizerQuadrantFore;
	
	if (angleInDegrees >= -45 && angleInDegrees <= 45)
	{
		if (xDistance < 0)
		{
			return AFCircularGestureRecognizerQuadrantLeft;
		}
		else
		{
			return AFCircularGestureRecognizerQuadrantRight;
		}
	}
	return AFCircularGestureRecognizerQuadrantRear;
}

@end


@implementation AFCircularGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action outerRadius:(CGFloat)outerRadius innerRadius:(CGFloat)innerRadius
{
	self = [super initWithTarget:target action:action];
	if (self)
	{
		if (innerRadius >= outerRadius)
		{
			@throw [NSException exceptionWithName:@"InvalidRange" reason:@"The outer radius must be bigger than the inner radius." userInfo:nil];
		}
		
		_action = action;
		_innerRadius = innerRadius;
		_outerRadius = outerRadius;
		_quadrantsMovedThrough = AFCircularGestureRecognizerQuadrantNone;
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (touches.count == 1)
	{
		CGPoint point = [[touches anyObject] locationInView:self.view];
		_radialCenterX = CGRectGetMidX(self.view.bounds);
		_radialCenterY = CGRectGetMidY(self.view.bounds);
		_quadrantsMovedThrough = (int)[self pointInQuadrant:point];
		
		if (_quadrantsMovedThrough != 0)
		{
			self.state = UIGestureRecognizerStatePossible;
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (touches.count == 1 && self.state == UIGestureRecognizerStatePossible)
	{
		CGPoint point = [[touches anyObject] locationInView:self.view];
		int currentQuadrant = (int)[self pointInQuadrant:point];
		if (currentQuadrant == 0)
		{
			_quadrantsMovedThrough = 0;
			self.state = UIGestureRecognizerStateFailed;
		}
		else {
			_quadrantsMovedThrough |= currentQuadrant;
		}
	}
	else
	{
		self.state = UIGestureRecognizerStateFailed;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (_quadrantsMovedThrough == AFCircularGestureRecognizerQuadrantAll && self.state == UIGestureRecognizerStatePossible)
	{
		self.state = UIGestureRecognizerStateRecognized;
	}
	else {
		self.state = UIGestureRecognizerStateFailed;
	}
}

- (void)reset
{
	[super reset];
	_quadrantsMovedThrough = AFCircularGestureRecognizerQuadrantNone;
}

@end
