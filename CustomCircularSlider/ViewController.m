//
//  ViewController.m
//  CustomCircularSlider
//
//  Created by user on 01.01.17.
//  Copyright © 2017 I&N. All rights reserved.
//

#import "ViewController.h"
#import "IACircularSlider.h"

@interface ViewController ()
@property (strong, nonatomic) IACircularSlider* slider;
@property (strong, nonatomic) UILabel* label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    IACircularSlider* slider = [[IACircularSlider alloc] initWithFrame:CGRectZero];
    [self.view addSubview:slider];

    
    slider.trackHighlightedTintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    slider.thumbTintColor = [UIColor whiteColor];
    slider.trackTintColor = [UIColor lightGrayColor];
    slider.thumbHighlightedTintColor = [UIColor whiteColor];
    slider.trackWidth = 20;
    slider.thumbWidth = 25;
    
    
    slider.minimumValue = 0;
    slider.startAngle = 0;
    slider.endAngle = 7*M_PI/4;
    slider.clockwise = YES;
    
    CGPoint start = CGPointMake(200, 100);
    CGPoint end = CGPointMake(0, 100);
    
    [slider setGradientColorForHighlightedTrackWithFirstColor:[UIColor orangeColor] secondColor:[UIColor blueColor] colorsLocations:CGPointMake(0.3, 0.9) startPoint:start andEndPoint:end];
    
    UILabel* label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(100, 175, 200, 50)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label  setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:26.f]];
    [self.view addSubview:label];
    self.label = label;
    
    
    [slider addTarget:self action:@selector(handleValue:) forControlEvents:UIControlEventValueChanged];
    
    self.slider = slider;
    
    [self.slider setThumbImage:[UIImage imageNamed:@"slide"]];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)handleValue:(IACircularSlider*)slider{
    self.label.text = [NSString stringWithFormat:@"%.00f", slider.value];
}

-(void)viewDidLayoutSubviews{
    [self.slider setFrame:CGRectMake(100, 100, 200, 200)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
