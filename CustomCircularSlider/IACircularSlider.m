//
//  IACircularSlider.m
//  CustomCircularSlider
//
//  Created by user on 01.01.17.
//  Copyright © 2017 I&N. All rights reserved.
//

#import "IACircularSlider.h"
#import "IACircleSliderThumbLayer.h"

#import "IACircularSliderTrackLayer.h"
@implementation IACircularSlider
{
    IACircularSliderTrackLayer* _trackLayer;
    IACircleSliderThumbLayer* _thumbLayer;
    CGPoint _center;
    CGPoint _lastPosition;
    CGFloat _rad;
    BOOL _isInitiallySet;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeComponents];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    _isInitiallySet = NO;
    [self updateLayers];

}

-(void)updateLayers{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [_trackLayer setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [_trackLayer setNeedsDisplay];
    
    self.radian = [self radianForValue:self.value];
    
    CGPoint point = [self mapRadianToPoint:self.radian];
    
    if (!_isInitiallySet) {
        point = [self mapRadianToPoint:[self radianForValue:self.value]];
        _isInitiallySet = YES;
    }
    
    [_thumbLayer setFrame:CGRectMake(point.x-self.thumbWidth/2, point.y-self.thumbWidth/2,
                                     self.thumbWidth, self.thumbWidth)];
    [_thumbLayer setNeedsDisplay];
    
    [CATransaction commit];
    
}

-(void)setThumbImage:(UIImage*)thumbImage{
    [_thumbLayer setImage:thumbImage];
    
}



-(void)initializeComponents{
    self.minimumValue = 50.0;
    self.maximumValue = 100.0;
    self.value = 75.f;
    
    self.startAngle = 0;
    self.endAngle = M_PI;
    self.clockwise = YES;
    
    self.thumbTintColor = [UIColor blueColor];
    self.thumbHighlightedTintColor = [UIColor blackColor];
    self.trackTintColor = [UIColor lightGrayColor];
    self.trackHighlightedTintColor = [UIColor blueColor];
    
    self.trackWidth = 10.f;
    self.thumbWidth = 20.f;
    self.isCapRound = YES;
    
    _trackLayer = [IACircularSliderTrackLayer layer];
    _thumbLayer = [IACircleSliderThumbLayer layer];
    
    _trackLayer.contentsScale = [UIScreen mainScreen].scale;
    _thumbLayer.contentsScale = [UIScreen mainScreen].scale;
    
    _thumbLayer.slider = self;
    _trackLayer.slider = self;

    
    [self.layer addSublayer:_trackLayer];
    [self.layer addSublayer:_thumbLayer];
    
    _isInitiallySet = NO;
    [self updateLayers];
}

-(CGFloat)radianForValue:(CGFloat)value{
    CGFloat val = ((value-self.minimumValue)/(self.maximumValue-self.minimumValue))*[self distance];
    
    return self.clockwise? val+self.startAngle :-val+self.startAngle;
}

-(CGFloat)valueForRadian:(CGFloat)radian{

    return (radian)*(self.maximumValue-self.minimumValue)/[self distance]+self.minimumValue;
}

-(CGPoint)mapRadianToPoint:(CGFloat)radian{
    return CGPointMake((_center.x-self.trackWidth/2)*cos(radian)+_center.x,
                                                              (( _center.y - self.trackWidth/2)*sin(radian)+_center.y));

}

-(CGFloat)distance{
    if (self.endAngle>self.startAngle) {
        if (self.clockwise) {
            return self.endAngle-self.startAngle;
        }else{
            return 2*M_PI-(self.endAngle-self.startAngle);
        }
    }else{
        if (self.clockwise) {
            return 2*M_PI-(self.startAngle-self.endAngle);
        }else{
            return self.startAngle-self.endAngle;
        }
    }
}


-(CGFloat)radianForPoint:(CGPoint)point{
    CGFloat val = 0;
    CGFloat x1 = point.x, x0 = _center.x, y1 = point.y, y0 = _center.y;
    
    if (x1>x0&&y1>y0) {
        val = atan((y1-y0)/(x1-x0));
    }else if (x1<x0&&y1>y0){
        val = atan((x0-x1)/(y1-y0))+M_PI/2;
    }else if (x1<x0&&y1<y0){
        val =  atan((y0-y1)/(x0-x1))+M_PI;
    }else if (x1>x0&&y1<y0){
        val = atan((x1-x0)/(y0-y1))+3*M_PI/2;
    }
    
    if (x1==x0) {
        if (y1>y0) {
            val = M_PI/2;
        }else{
            val = 3*M_PI/2;
        }
    }else if (y1==y0){
        if (x1<x0) {
            val = M_PI;
        }
    }
    
    return val;
}

-(CGFloat)transformRadianForCurrentOptions:(CGFloat)rad{
    CGFloat val = 0;
    
    if (self.clockwise) {
            if (rad>self.startAngle) {
                val =  rad - self.startAngle;
            }else if (rad<self.startAngle){
                val = 2*M_PI-self.startAngle+rad;
            }
    }else{
        if (rad>self.startAngle) {
            val = 2*M_PI -rad + self.startAngle;
        }else if (rad<self.startAngle){
            val = self.startAngle-rad;
        }
    }
    
    return val;
}

-(CGFloat)reverseTransformRadian:(CGFloat)val{
    
    CGFloat rad = 0;
    
    if (self.clockwise) {
        if (val>self.startAngle) {
            rad = val + self.startAngle;
        }else if (val<self.startAngle){
            rad = val - 2*M_PI + self.startAngle;
        }
    }else{
        if (val>self.startAngle) {
            rad = 2*M_PI - val + self.startAngle;
        }else if (val<self.startAngle){
            rad = self.startAngle-val;
        }
    }
    
    return val;
    
}

-(CGFloat)boundValueForValue:(CGFloat)value{
    return MIN(value, self.maximumValue);
}

-(CGFloat)boundRadianForRadian:(CGFloat)radian{
    return MIN(radian, [self distance]);
}


#pragma mark - Setters

-(void)setStartAngle:(CGFloat)startAngle{
    if (startAngle>2*M_PI||startAngle<0) {
        [NSException raise:@"Invalid value of startAngle" format:@"startAngle must be more than 0 and less than 2PI"];
    }
    _startAngle = startAngle;
    [self updateLayers];
}

-(void)setEndAngle:(CGFloat)endAngle{
    if (endAngle>2*M_PI||endAngle<0) {
        [NSException raise:@"Invalid value of endAngle" format:@"endAngle must be more than 0 and less than 2PI"];
    }
    _endAngle = endAngle;
    [self updateLayers];
}

-(void)setValue:(CGFloat)value{
    
    if (value>self.maximumValue||value<self.minimumValue) {
        value = self.minimumValue;
    }
    _value = value;
    [self updateLayers];
    
}

-(void)setClockwise:(BOOL)clockwise{
    _clockwise = clockwise;
    [self updateLayers];
}

-(void)setIsCapRound:(BOOL)isCapRound{
    _isCapRound = isCapRound;
    [self updateLayers];
}

-(void)setMinimumValue:(CGFloat)minimumValue{
    _minimumValue = minimumValue;
    [self updateLayers];
}

-(void)setMaximumValue:(CGFloat)maximumValue{
    _maximumValue = maximumValue;
    [self updateLayers];
}

-(void)setThumbWidth:(CGFloat)thumbWidth{
    _thumbWidth = thumbWidth;
    [self updateLayers];
}

-(void)setTrackWidth:(CGFloat)trackWidth{
    _trackWidth = trackWidth;
    [self updateLayers];
}

-(void)setThumbTintColor:(UIColor *)thumbTintColor{
    _thumbTintColor = thumbTintColor;
    [self updateLayers];
}

-(void)setThumbHighlightedTintColor:(UIColor *)thumbHighlightedTintColor{
    _thumbHighlightedTintColor = thumbHighlightedTintColor;
    [self updateLayers];
}

-(void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    [self updateLayers];
}

-(void)setTrackHighlightedTintColor:(UIColor *)trackHighlightedTintColor{
    _trackHighlightedTintColor = trackHighlightedTintColor;
    [self updateLayers];
}

#pragma mark - Tracking

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(_thumbLayer.frame, [touch locationInView:self])) {
        _thumbLayer.isHighlighted = YES;
        _lastPosition = [touch locationInView:self];
        return YES;
        
    }
    return NO;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGFloat preRad = [self radianForPoint:[touch locationInView:self]];
    
    _rad = preRad;
    
    CGFloat radian = [self transformRadianForCurrentOptions:preRad];
    
    self.value = [self boundValueForValue:[self valueForRadian:radian]];
    
    [self updateLayers];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    _thumbLayer.isHighlighted = NO;
    [_thumbLayer setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
