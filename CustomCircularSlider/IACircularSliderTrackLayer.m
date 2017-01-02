//
//  IACircularSliderTrackLayer.m
//  CustomCircularSlider
//
//  Created by user on 01.01.17.
//  Copyright © 2017 I&N. All rights reserved.
//

#import "IACircularSliderTrackLayer.h"
#import "IACircularSlider.h"

@implementation IACircularSliderTrackLayer

-(void)drawInContext:(CGContextRef)ctx{
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    CGFloat arcWidth = self.slider.trackWidth;
    CGFloat arcRadius = (CGRectGetWidth(self.frame)-arcWidth)/2;
    
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center radius:arcRadius
                                                    startAngle:self.slider.startAngle
                                                      endAngle:self.slider.endAngle
                                                     clockwise:self.slider.clockwise];
    
    UIBezierPath* hPath = [UIBezierPath bezierPathWithArcCenter:center radius:arcRadius
                                                    startAngle:self.slider.startAngle
                                                      endAngle:self.slider.radian
                                                      clockwise:self.slider.clockwise];
    
    CGContextSetStrokeColorWithColor(ctx, self.slider.trackTintColor.CGColor);
    CGContextSetLineWidth(ctx, arcWidth);
    
    
    if (_slider.isCapRound) {
        CGContextSetLineCap(ctx, kCGLineCapRound);
    }
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, self.slider.trackHighlightedTintColor.CGColor);
    CGContextSetLineWidth(ctx, arcWidth);
    CGContextAddPath(ctx, hPath.CGPath);
    CGContextStrokePath(ctx);
    

    
}

@end
