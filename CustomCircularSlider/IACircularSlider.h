//
//  IACircularSlider.h
//  CustomCircularSlider
//
//  Created by user on 01.01.17.
//  Copyright © 2017 I&N. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface IACircularSlider : UIControl

@property (assign, nonatomic) IBInspectable CGFloat value;
@property (assign, nonatomic) IBInspectable CGFloat minimumValue;
@property (assign, nonatomic) IBInspectable CGFloat maximumValue;

@property (assign, nonatomic) CGFloat radian;

@property (assign, nonatomic) IBInspectable CGFloat startAngle;
@property (assign, nonatomic) IBInspectable CGFloat endAngle;
@property (assign, nonatomic) IBInspectable BOOL clockwise;
@property (assign ,nonatomic) IBInspectable BOOL isCapRound;

@property (strong, nonatomic) IBInspectable UIColor* thumbTintColor;
@property (strong, nonatomic) IBInspectable UIColor* thumbHighlightedTintColor;
@property (strong, nonatomic) IBInspectable UIColor* trackTintColor;
@property (strong, nonatomic) IBInspectable UIColor* trackHighlightedTintColor;

@property (assign, nonatomic) IBInspectable CGFloat trackWidth;
@property (assign, nonatomic) IBInspectable CGFloat thumbWidth;
@end
