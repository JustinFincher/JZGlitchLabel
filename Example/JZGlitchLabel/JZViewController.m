//
//  JZViewController.m
//  JZGlitchLabel
//
//  Created by Fincher Justin on 11/07/2015.
//  Copyright (c) 2015 Fincher Justin. All rights reserved.
//

#import "JZViewController.h"
#import "JZGlitchLabel.h"

@interface JZViewController ()

@property (nonatomic) JZGlitchLabel *GLabel;

@end

@implementation JZViewController

@synthesize GLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    GLabel = [[JZGlitchLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,300)];
    GLabel.Label.text = @"T";
    GLabel.Label.font = [UIFont systemFontOfSize:150.0f weight:40];
    GLabel.Label.textColor = [UIColor whiteColor];
    GLabel.Label.textAlignment = NSTextAlignmentCenter;
    
    GLabel.MinFontSize = 60;
    GLabel.MaxFontSize = 160;
    GLabel.MinFontWeight = 20;
    GLabel.MaxFontWeight = 40;
    
    [self.view addSubview:GLabel];
    
    NSTimer * GlitchTimer = [NSTimer scheduledTimerWithTimeInterval:4
                                                             target:self
                                                           selector:@selector(BeginGlitch)
                                                           userInfo:nil
                                                            repeats:YES];
    
    
    UIButton * ConfirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [ConfirmButton setFrame:CGRectMake(20, self.view.frame.size.height - 80, self.view.frame.size.width - 40, 60)];
    [ConfirmButton setTitle:@"Login" forState:UIControlStateNormal];
    ConfirmButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [ConfirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ConfirmButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ConfirmButton];
    
}
-(void)BeginGlitch
{
    NSArray *Username = @[@"@JZ",@"@SC",@"@改",@"X"];
    
    [GLabel performGlitchTransformTo:[Username objectAtIndex:(arc4random() % 4)]
                           WithSteps:30
                        WithInterval:0.08
                        WithFontSize:130
                      WithFontWeight:50
                 WithGlitchParameter:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

