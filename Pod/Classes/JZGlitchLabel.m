//
//  JZGlitchLabel.m
//  JZGlitchLabel
//
//  Created by Fincher Justin on 15/11/7.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#define IN_RANGE(x, low, high)  ((low<=(x))&&((x)<=high))
#define IS_CJK_Unified_Ideographs(x) IN_RANGE(x, 0x4E00, 0x9FFF)
#define IS_CJK_Unified_Ideographs_Extension(x) IN_RANGE(x, 0x3400, 0x4DFF)
#define IS_EMOJI(x) IN_RANGE(x, 0x1F600, 0x1F64F)

#import "JZGlitchLabel.h"
@interface JZGlitchLabel ()

@property (nonatomic) NSTimer *GlitchTimer;

@end


@implementation JZGlitchLabel

@synthesize Label;
@synthesize FromString,ToString;
@synthesize CurrentStep,TotalStep;
@synthesize GlitchTimer,Interval;
@synthesize MinFontSize,MinFontWeight,MaxFontSize,MaxFontWeight;
@synthesize ToFontSize,ToFontWeight;
@synthesize GlitchPara;



- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    //Label.backgroundColor = [UIColor blackColor];
    [self addSubview:Label];
    
    return self;
}



- (void)performGlitchTransformTo:(NSString *)String
                       WithSteps:(NSUInteger)Step
                    WithInterval:(CGFloat)TimeInterval
                    WithFontSize:(CGFloat)FontSize
                  WithFontWeight:(CGFloat)FontWeight
             WithGlitchParameter:(int)Para;
{
    self.CurrentStep = 0;
    self.TotalStep = Step;
    
    self.ToString = String;
    self.FromString = self.Label.text;
    
    self.ToFontWeight = FontWeight;
    self.ToFontSize = FontSize;
    
    self.GlitchPara = Para;
    self.Interval = TimeInterval;
    
    GlitchTimer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval
                                                   target:self
                                                 selector:@selector(GenerateRandomText)
                                                 userInfo:nil
                                                  repeats:YES];
    
}

- (CGFloat)degreesToRadians:(double)degrees
{
    return (CGFloat)(degrees * M_PI / 180.0);
}
- (void)GenerateRandomText
{
    
    if (CurrentStep == TotalStep)
    {
        [GlitchTimer invalidate];
        self.Label.text = self.ToString;
        self.Label.font = [UIFont systemFontOfSize:ToFontSize weight:ToFontWeight];
    }
    else
    {
        
        self.Label.font = [UIFont systemFontOfSize:(MinFontSize + arc4random() % (int)(MaxFontSize - MinFontSize)) weight:MinFontWeight + arc4random() % (int)(MaxFontWeight - MinFontWeight)];
        
        
        if (CurrentStep < TotalStep / 2)
        {
            //NSLog(@"self randomStringWithString FromString");
            self.Label.text = [self randomStringWithString:FromString];
        }
        else
        {
            //NSLog(@"self randomStringWithString ToString");
            self.Label.text = [self randomStringWithString:ToString];
        }
        
        
        UIImage *LabelImage = [self SaveLabelImage];
        
        int Seed = arc4random() % 10;
        NSMutableArray *CGRexts = [self CalRectFromSelfAndSliceNum:Seed];
        for (int i = 0; i < Seed; i++)
        {
            NSValue *RectValue = [CGRexts objectAtIndex:i];
            CGRect Rect = [RectValue CGRectValue];
            CGRect GlitchRect = CGRectMake((arc4random() % GlitchPara), Rect.origin.y, Rect.size.width, Rect.size.height);
            UIImage *NewImage = [self CropImage:LabelImage withRect:Rect];
            UIImageView *NewImageView = [[UIImageView alloc] initWithFrame:GlitchRect];
            NewImageView.image = NewImage;
            [self addSubview:NewImageView];
            [self performSelector:@selector(RemoveImageView:) withObject:NewImageView afterDelay:Interval];
        }
        
    }
    
    
    //NSLog(@"Now Step: %d",CurrentStep);
    
    
    CurrentStep ++ ;
}

- (void)RemoveImageView:(UIImageView *)View
{
    [View removeFromSuperview];
}
- (NSMutableArray *)CalRectFromSelfAndSliceNum:(int)Number
{
    NSMutableArray *AllHeights = [[NSMutableArray alloc] initWithCapacity:Number];
    NSMutableArray *CurrentHeights = [[NSMutableArray alloc] initWithCapacity:Number];
    CGFloat ViewWidth = self.frame.size.width;
    CGFloat ViewHeight = self.frame.size.height;
    
    int HeightSum = 0;
    for (int i = 0; i < Number; i++)
    {
        NSNumber * Height = [NSNumber numberWithInt:(arc4random() % 200 + 1000)];
        [AllHeights addObject:Height];
        HeightSum = HeightSum + [Height intValue];
    }
    
    CGFloat CurrentHeight = 0;
    for (int i = 0; i < Number; i++)
    {
        NSNumber * Height = [AllHeights objectAtIndex:i];
        [AllHeights replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:[Height floatValue] / HeightSum * ViewHeight]];
        
        CurrentHeight = CurrentHeight + [Height floatValue] / HeightSum * ViewHeight;
        [CurrentHeights addObject:[NSNumber numberWithDouble:CurrentHeight]];
    }
    
    NSMutableArray *CGRects = [[NSMutableArray alloc] initWithCapacity:Number];
    for (int i = 0; i < Number; i++)
    {
        NSNumber *y = [CurrentHeights objectAtIndex:i];
        NSNumber *height = [AllHeights objectAtIndex:i];
        CGRect NewCGRect = CGRectMake(0, [y floatValue], ViewWidth, [height floatValue]);
        [CGRects addObject:[NSValue valueWithCGRect:NewCGRect]];
    }
    
    return CGRects;
}

- (UIImage *)CropImage:(UIImage *)image withRect:(CGRect)cropRect
{
    cropRect = CGRectMake(cropRect.origin.x * image.scale,
                          cropRect.origin.y * image.scale,
                          cropRect.size.width * image.scale,
                          cropRect.size.height * image.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}

- (UIImage *)SaveLabelImage
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    [self.Label.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *savedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return savedImage;
}

-(NSString *) randomStringWithString:(NSString*)String
{
    //NSLog(@"FromString Length: %d ToString Length: %d",[[NSNumber numberWithInteger:[FromString length]] intValue],[[NSNumber numberWithInteger:[ToString length]]intValue]);
    //int AimedLenthInt = ([[NSNumber numberWithUnsignedInteger:[ToString length]]intValue] - [[NSNumber numberWithUnsignedInteger:[FromString length]] intValue])*CurrentStep/TotalStep + [[NSNumber numberWithUnsignedInteger:[ToString length]]intValue] ;
    
    int AimedLenthInt = (int)(([[NSNumber numberWithUnsignedInteger:[ToString length]] floatValue]-[[NSNumber numberWithUnsignedInteger:[FromString length]] floatValue])*CurrentStep/TotalStep + [[NSNumber numberWithUnsignedInteger:[FromString length]] floatValue]);
    //NSLog(@"AimedLenthInt : %d",AimedLenthInt);
    NSUInteger AimedLength = AimedLenthInt;
    //NSLog(@"AimedLength: %lu",(unsigned long)AimedLength);
    NSMutableString *AimedString = [NSMutableString stringWithCapacity:AimedLength];
    
    NSMutableArray *Characters = [[NSMutableArray alloc] initWithCapacity:[String length]];
    //NSLog(@"randomStringWithString String:%@ StringLength:%d",String,[String length]);
    for (int i=0; i < [[NSNumber numberWithInteger:[String length]] intValue]; i++)
    {
        NSString *OneChar  = [NSString stringWithFormat:@"%C", [String characterAtIndex:i]];
        
        //NSLog(@"%C %@",[String characterAtIndex:i],OneChar);
        
        
        [Characters addObject:OneChar];
    }
    
    for (int i = 0; i < AimedLenthInt ; i++)
    {
        if (i < [Characters count])
        {
            //数组里面有对应的字符 根据对应的字符返回随机的字符
            NSString *OneChar = [Characters objectAtIndex:i];
            //NSLog(@"OneChar: %@ at Index %d",OneChar,i);
            NSString *OutputChar = [self CharacterReplaceWithGivenOneChar:OneChar];
            
            [AimedString appendString:OutputChar];
        }
        else
        {
            //数组里面没有对应的字符 随机一个英文／数字
            NSString *vowels = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789.,+-/#$%^&*()@!<>                ";
            NSString *OutputChar = [vowels substringWithRange:NSMakeRange(arc4random_uniform((int)[vowels length]), 1)];
            
            [AimedString appendString:OutputChar];
        }
    }
    
    return AimedString;
}

- (NSString *)CharacterReplaceWithGivenOneChar:(NSString *)OneChar
{
    if ([self IsCJK:OneChar])
    {
        //NSLog(@"Han ");
        // 随机一个中文字符出去
        uint32_t first = 0x04E00;
        uint32_t last  = 0x09FFF;
        uint32_t random = first + arc4random() % (last - first);
        NSString *tmp = [[NSString alloc] initWithBytes:&random length:4 encoding:NSUTF32LittleEndianStringEncoding];
        //NSLog(@"%@", tmp);
        return tmp;
    }
    else
    {
        //随机一个英文／数字
        //NSLog(@"not Han ");
        NSString *vowels = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789.,+-/#$%^&*()@!<>                ";
        NSString *tmp = [vowels substringWithRange:NSMakeRange(arc4random_uniform((int)[vowels length]), 1)];
        return tmp;
    }
}

- (BOOL)IsCJK:(NSString *)CJKString
{
    //NSLog(@"IsCJK:%@",CJKString);
    for(int i = 0; i<[CJKString length];i++)
    {
        if (IS_CJK_Unified_Ideographs([CJKString characterAtIndex:i]))
        {
            return YES;
        }
    }
    return NO;
}

@end
