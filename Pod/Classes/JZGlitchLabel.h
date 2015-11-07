//
//  JZGlitchLabel.h
//  JZGlitchLabel
//
//  Created by Fincher Justin on 15/11/7.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZGlitchLabel : UIView

@property (nonatomic) UILabel *Label;
@property (nonatomic) NSString *ToString;
@property (nonatomic) NSString *FromString;
@property (nonatomic) NSUInteger TotalStep;
@property (nonatomic) NSUInteger CurrentStep;
@property (nonatomic) CGFloat MinFontSize;
@property (nonatomic) CGFloat MaxFontSize;
@property (nonatomic) CGFloat MinFontWeight;
@property (nonatomic) CGFloat MaxFontWeight;
@property (nonatomic) CGFloat ToFontSize;
@property (nonatomic) CGFloat ToFontWeight;
@property (nonatomic) int GlitchPara;
@property (nonatomic) CGFloat Interval;

- (void)performGlitchTransformTo:(NSString *)String
                       WithSteps:(NSUInteger)Step
                    WithInterval:(CGFloat)TimeInterval
                    WithFontSize:(CGFloat)FontSize
                  WithFontWeight:(CGFloat)FontWeight
             WithGlitchParameter:(int)Para;

@end
