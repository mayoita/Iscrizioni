//
//  BCRArtView.m
//  BarCodeReader
//
//  Created by Massimo Moro on 16/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import "BCRArtView.h"

@implementation BCRArtView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* rosso = [UIColor colorWithRed: 0.776 green: 0.071 blue: 0.137 alpha: 1];
    UIColor* arancione = [UIColor colorWithRed: 0.89 green: 0.553 blue: 0.176 alpha: 1];
    UIColor* color = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    UIColor* giallo2 = [UIColor colorWithRed: 0.992 green: 0.945 blue: 0.71 alpha: 1];
    UIColor* bianco = [UIColor colorWithRed: 0.988 green: 0.984 blue: 0.976 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)rosso.CGColor,
                               (id)arancione.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    NSArray* luciColors = [NSArray arrayWithObjects:
                           (id)bianco.CGColor,
                           (id)giallo2.CGColor, nil];
    CGFloat luciLocations[] = {0, 1};
    CGGradientRef luci = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)luciColors, luciLocations);
    
    //// Shadow Declarations
    UIColor* shadow = giallo2;
    CGSize shadowOffset = CGSizeMake(0.1, -0.1);
    CGFloat shadowBlurRadius = 7;
    
    //// Frames
    CGRect frame = rect;
    
    //// Subframes
    CGRect group2 = CGRectMake(CGRectGetMinX(frame) + 50, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 587, 14);
    CGRect group3 = CGRectMake(CGRectGetMinX(frame) + 51, CGRectGetMinY(frame) + 182, CGRectGetWidth(frame) - 587, 14);
    CGRect group4 = CGRectMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 48, 14, CGRectGetHeight(frame) - 52);
    CGRect group = CGRectMake(CGRectGetMinX(frame) + 522, CGRectGetMinY(frame) + 182, CGRectGetWidth(frame) - 587, 14);
    CGRect group7 = CGRectMake(CGRectGetMinX(frame) + 522, CGRectGetMinY(frame) + 3, CGRectGetWidth(frame) - 587, 14);
    CGRect group6 = CGRectMake(CGRectGetMinX(frame) + 1003, CGRectGetMinY(frame) + 48, 14, CGRectGetHeight(frame) - 52);
    
    
    //// Rectangle Drawing
    CGRect rectangleRect = CGRectMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMinX(rectangleRect), CGRectGetMidY(rectangleRect)),
                                CGPointMake(CGRectGetMaxX(rectangleRect), CGRectGetMidY(rectangleRect)),
                                0);
    CGContextRestoreGState(context);
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + 11, CGRectGetMinY(frame) + 10, CGRectGetWidth(frame) - 20, CGRectGetHeight(frame) - 20)];
    [color setFill];
    [rectangle2Path fill];
    
    
    //// Oval 12 Drawing
    CGRect oval12Rect = CGRectMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 3, 14, 14);
    UIBezierPath* oval12Path = [UIBezierPath bezierPathWithOvalInRect: oval12Rect];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [oval12Path addClip];
    CGContextDrawLinearGradient(context, luci,
                                CGPointMake(CGRectGetMidX(oval12Rect), CGRectGetMinY(oval12Rect)),
                                CGPointMake(CGRectGetMidX(oval12Rect), CGRectGetMaxY(oval12Rect)),
                                0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    
    
    //// Oval 23 Drawing
    CGRect oval23Rect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 21, CGRectGetMinY(frame) + 3, 14, 14);
    UIBezierPath* oval23Path = [UIBezierPath bezierPathWithOvalInRect: oval23Rect];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [oval23Path addClip];
    CGContextDrawLinearGradient(context, luci,
                                CGPointMake(CGRectGetMidX(oval23Rect), CGRectGetMinY(oval23Rect)),
                                CGPointMake(CGRectGetMidX(oval23Rect), CGRectGetMaxY(oval23Rect)),
                                0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);
    
    
    
    //// Group 2
    {
        //// Oval 14 Drawing
        CGRect oval14Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.00000 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.03204 + 0.5) - floor(CGRectGetWidth(group2) * 0.00000 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval14Path = [UIBezierPath bezierPathWithOvalInRect: oval14Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval14Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval14Rect), CGRectGetMinY(oval14Rect)),
                                    CGPointMake(CGRectGetMidX(oval14Rect), CGRectGetMaxY(oval14Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 15 Drawing
        CGRect oval15Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.10755 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.13959 + 0.5) - floor(CGRectGetWidth(group2) * 0.10755 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval15Path = [UIBezierPath bezierPathWithOvalInRect: oval15Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval15Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval15Rect), CGRectGetMinY(oval15Rect)),
                                    CGPointMake(CGRectGetMidX(oval15Rect), CGRectGetMaxY(oval15Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 16 Drawing
        CGRect oval16Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.21510 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.24714 + 0.5) - floor(CGRectGetWidth(group2) * 0.21510 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval16Path = [UIBezierPath bezierPathWithOvalInRect: oval16Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval16Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval16Rect), CGRectGetMinY(oval16Rect)),
                                    CGPointMake(CGRectGetMidX(oval16Rect), CGRectGetMaxY(oval16Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 17 Drawing
        CGRect oval17Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.32265 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.35469 + 0.5) - floor(CGRectGetWidth(group2) * 0.32265 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval17Path = [UIBezierPath bezierPathWithOvalInRect: oval17Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval17Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval17Rect), CGRectGetMinY(oval17Rect)),
                                    CGPointMake(CGRectGetMidX(oval17Rect), CGRectGetMaxY(oval17Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 18 Drawing
        CGRect oval18Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.43021 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.46224 + 0.5) - floor(CGRectGetWidth(group2) * 0.43021 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval18Path = [UIBezierPath bezierPathWithOvalInRect: oval18Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval18Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval18Rect), CGRectGetMinY(oval18Rect)),
                                    CGPointMake(CGRectGetMidX(oval18Rect), CGRectGetMaxY(oval18Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 19 Drawing
        CGRect oval19Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.53776 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.56979 + 0.5) - floor(CGRectGetWidth(group2) * 0.53776 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval19Path = [UIBezierPath bezierPathWithOvalInRect: oval19Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval19Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval19Rect), CGRectGetMinY(oval19Rect)),
                                    CGPointMake(CGRectGetMidX(oval19Rect), CGRectGetMaxY(oval19Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 20 Drawing
        CGRect oval20Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.64531 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.67735 + 0.5) - floor(CGRectGetWidth(group2) * 0.64531 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval20Path = [UIBezierPath bezierPathWithOvalInRect: oval20Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval20Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval20Rect), CGRectGetMinY(oval20Rect)),
                                    CGPointMake(CGRectGetMidX(oval20Rect), CGRectGetMaxY(oval20Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 21 Drawing
        CGRect oval21Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.75286 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.78490 + 0.5) - floor(CGRectGetWidth(group2) * 0.75286 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval21Path = [UIBezierPath bezierPathWithOvalInRect: oval21Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval21Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval21Rect), CGRectGetMinY(oval21Rect)),
                                    CGPointMake(CGRectGetMidX(oval21Rect), CGRectGetMaxY(oval21Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 22 Drawing
        CGRect oval22Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.86041 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 0.89245 + 0.5) - floor(CGRectGetWidth(group2) * 0.86041 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval22Path = [UIBezierPath bezierPathWithOvalInRect: oval22Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval22Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval22Rect), CGRectGetMinY(oval22Rect)),
                                    CGPointMake(CGRectGetMidX(oval22Rect), CGRectGetMaxY(oval22Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 24 Drawing
        CGRect oval24Rect = CGRectMake(CGRectGetMinX(group2) + floor(CGRectGetWidth(group2) * 0.96796 + 0.5), CGRectGetMinY(group2) + floor(CGRectGetHeight(group2) * 0.00000 + 0.5), floor(CGRectGetWidth(group2) * 1.00000 + 0.5) - floor(CGRectGetWidth(group2) * 0.96796 + 0.5), floor(CGRectGetHeight(group2) * 1.00000 + 0.5) - floor(CGRectGetHeight(group2) * 0.00000 + 0.5));
        UIBezierPath* oval24Path = [UIBezierPath bezierPathWithOvalInRect: oval24Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval24Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval24Rect), CGRectGetMinY(oval24Rect)),
                                    CGPointMake(CGRectGetMidX(oval24Rect), CGRectGetMaxY(oval24Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
    
    
    //// Group 3
    {
        //// Oval 2 Drawing
        CGRect oval2Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.00000 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.03204 + 0.5) - floor(CGRectGetWidth(group3) * 0.00000 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: oval2Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval2Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMinY(oval2Rect)),
                                    CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMaxY(oval2Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 3 Drawing
        CGRect oval3Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.10755 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.13959 + 0.5) - floor(CGRectGetWidth(group3) * 0.10755 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: oval3Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval3Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval3Rect), CGRectGetMinY(oval3Rect)),
                                    CGPointMake(CGRectGetMidX(oval3Rect), CGRectGetMaxY(oval3Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 4 Drawing
        CGRect oval4Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.21510 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.24714 + 0.5) - floor(CGRectGetWidth(group3) * 0.21510 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval4Path = [UIBezierPath bezierPathWithOvalInRect: oval4Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval4Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval4Rect), CGRectGetMinY(oval4Rect)),
                                    CGPointMake(CGRectGetMidX(oval4Rect), CGRectGetMaxY(oval4Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 5 Drawing
        CGRect oval5Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.32265 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.35469 + 0.5) - floor(CGRectGetWidth(group3) * 0.32265 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval5Path = [UIBezierPath bezierPathWithOvalInRect: oval5Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval5Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval5Rect), CGRectGetMinY(oval5Rect)),
                                    CGPointMake(CGRectGetMidX(oval5Rect), CGRectGetMaxY(oval5Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 6 Drawing
        CGRect oval6Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.43021 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.46224 + 0.5) - floor(CGRectGetWidth(group3) * 0.43021 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval6Path = [UIBezierPath bezierPathWithOvalInRect: oval6Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval6Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval6Rect), CGRectGetMinY(oval6Rect)),
                                    CGPointMake(CGRectGetMidX(oval6Rect), CGRectGetMaxY(oval6Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 8 Drawing
        CGRect oval8Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.53776 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.56979 + 0.5) - floor(CGRectGetWidth(group3) * 0.53776 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval8Path = [UIBezierPath bezierPathWithOvalInRect: oval8Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval8Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval8Rect), CGRectGetMinY(oval8Rect)),
                                    CGPointMake(CGRectGetMidX(oval8Rect), CGRectGetMaxY(oval8Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 9 Drawing
        CGRect oval9Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.64531 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.67735 + 0.5) - floor(CGRectGetWidth(group3) * 0.64531 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval9Path = [UIBezierPath bezierPathWithOvalInRect: oval9Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval9Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval9Rect), CGRectGetMinY(oval9Rect)),
                                    CGPointMake(CGRectGetMidX(oval9Rect), CGRectGetMaxY(oval9Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 10 Drawing
        CGRect oval10Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.75286 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.78490 + 0.5) - floor(CGRectGetWidth(group3) * 0.75286 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval10Path = [UIBezierPath bezierPathWithOvalInRect: oval10Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval10Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval10Rect), CGRectGetMinY(oval10Rect)),
                                    CGPointMake(CGRectGetMidX(oval10Rect), CGRectGetMaxY(oval10Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 11 Drawing
        CGRect oval11Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.86041 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 0.89245 + 0.5) - floor(CGRectGetWidth(group3) * 0.86041 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval11Path = [UIBezierPath bezierPathWithOvalInRect: oval11Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval11Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval11Rect), CGRectGetMinY(oval11Rect)),
                                    CGPointMake(CGRectGetMidX(oval11Rect), CGRectGetMaxY(oval11Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 7 Drawing
        CGRect oval7Rect = CGRectMake(CGRectGetMinX(group3) + floor(CGRectGetWidth(group3) * 0.96796 + 0.5), CGRectGetMinY(group3) + floor(CGRectGetHeight(group3) * 0.00000 + 0.5), floor(CGRectGetWidth(group3) * 1.00000 + 0.5) - floor(CGRectGetWidth(group3) * 0.96796 + 0.5), floor(CGRectGetHeight(group3) * 1.00000 + 0.5) - floor(CGRectGetHeight(group3) * 0.00000 + 0.5));
        UIBezierPath* oval7Path = [UIBezierPath bezierPathWithOvalInRect: oval7Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval7Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval7Rect), CGRectGetMinY(oval7Rect)),
                                    CGPointMake(CGRectGetMidX(oval7Rect), CGRectGetMaxY(oval7Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
    
    
    //// Group 4
    {
        //// Oval 25 Drawing
        CGRect oval25Rect = CGRectMake(CGRectGetMinX(group4) + floor(CGRectGetWidth(group4) * 0.00000 + 0.5), CGRectGetMinY(group4) + floor(CGRectGetHeight(group4) * 0.00000 + 0.5), floor(CGRectGetWidth(group4) * 1.00000 + 0.5) - floor(CGRectGetWidth(group4) * 0.00000 + 0.5), floor(CGRectGetHeight(group4) * 0.09459 + 0.5) - floor(CGRectGetHeight(group4) * 0.00000 + 0.5));
        UIBezierPath* oval25Path = [UIBezierPath bezierPathWithOvalInRect: oval25Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval25Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval25Rect), CGRectGetMinY(oval25Rect)),
                                    CGPointMake(CGRectGetMidX(oval25Rect), CGRectGetMaxY(oval25Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 26 Drawing
        CGRect oval26Rect = CGRectMake(CGRectGetMinX(group4) + floor(CGRectGetWidth(group4) * 0.00000 + 0.5), CGRectGetMinY(group4) + floor(CGRectGetHeight(group4) * 0.30405 + 0.5), floor(CGRectGetWidth(group4) * 1.00000 + 0.5) - floor(CGRectGetWidth(group4) * 0.00000 + 0.5), floor(CGRectGetHeight(group4) * 0.39865 + 0.5) - floor(CGRectGetHeight(group4) * 0.30405 + 0.5));
        UIBezierPath* oval26Path = [UIBezierPath bezierPathWithOvalInRect: oval26Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval26Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval26Rect), CGRectGetMinY(oval26Rect)),
                                    CGPointMake(CGRectGetMidX(oval26Rect), CGRectGetMaxY(oval26Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 27 Drawing
        CGRect oval27Rect = CGRectMake(CGRectGetMinX(group4) + floor(CGRectGetWidth(group4) * 0.00000 + 0.5), CGRectGetMinY(group4) + floor(CGRectGetHeight(group4) * 0.60811 + 0.5), floor(CGRectGetWidth(group4) * 1.00000 + 0.5) - floor(CGRectGetWidth(group4) * 0.00000 + 0.5), floor(CGRectGetHeight(group4) * 0.70270 + 0.5) - floor(CGRectGetHeight(group4) * 0.60811 + 0.5));
        UIBezierPath* oval27Path = [UIBezierPath bezierPathWithOvalInRect: oval27Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval27Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval27Rect), CGRectGetMinY(oval27Rect)),
                                    CGPointMake(CGRectGetMidX(oval27Rect), CGRectGetMaxY(oval27Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 28 Drawing
        CGRect oval28Rect = CGRectMake(CGRectGetMinX(group4) + floor(CGRectGetWidth(group4) * 0.00000 + 0.5), CGRectGetMinY(group4) + floor(CGRectGetHeight(group4) * 0.90541 + 0.5), floor(CGRectGetWidth(group4) * 1.00000 + 0.5) - floor(CGRectGetWidth(group4) * 0.00000 + 0.5), floor(CGRectGetHeight(group4) * 1.00000 + 0.5) - floor(CGRectGetHeight(group4) * 0.90541 + 0.5));
        UIBezierPath* oval28Path = [UIBezierPath bezierPathWithOvalInRect: oval28Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval28Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval28Rect), CGRectGetMinY(oval28Rect)),
                                    CGPointMake(CGRectGetMidX(oval28Rect), CGRectGetMaxY(oval28Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
    
    
    //// Group 5
    {
    }
    
    
    //// Group
    {
        //// Oval 33 Drawing
        CGRect oval33Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00000 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.03204 + 0.5) - floor(CGRectGetWidth(group) * 0.00000 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval33Path = [UIBezierPath bezierPathWithOvalInRect: oval33Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval33Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval33Rect), CGRectGetMinY(oval33Rect)),
                                    CGPointMake(CGRectGetMidX(oval33Rect), CGRectGetMaxY(oval33Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 34 Drawing
        CGRect oval34Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.10755 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.13959 + 0.5) - floor(CGRectGetWidth(group) * 0.10755 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval34Path = [UIBezierPath bezierPathWithOvalInRect: oval34Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval34Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval34Rect), CGRectGetMinY(oval34Rect)),
                                    CGPointMake(CGRectGetMidX(oval34Rect), CGRectGetMaxY(oval34Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 35 Drawing
        CGRect oval35Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.21510 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.24714 + 0.5) - floor(CGRectGetWidth(group) * 0.21510 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval35Path = [UIBezierPath bezierPathWithOvalInRect: oval35Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval35Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval35Rect), CGRectGetMinY(oval35Rect)),
                                    CGPointMake(CGRectGetMidX(oval35Rect), CGRectGetMaxY(oval35Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 36 Drawing
        CGRect oval36Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.32265 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.35469 + 0.5) - floor(CGRectGetWidth(group) * 0.32265 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval36Path = [UIBezierPath bezierPathWithOvalInRect: oval36Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval36Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval36Rect), CGRectGetMinY(oval36Rect)),
                                    CGPointMake(CGRectGetMidX(oval36Rect), CGRectGetMaxY(oval36Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 37 Drawing
        CGRect oval37Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.43021 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.46224 + 0.5) - floor(CGRectGetWidth(group) * 0.43021 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval37Path = [UIBezierPath bezierPathWithOvalInRect: oval37Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval37Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval37Rect), CGRectGetMinY(oval37Rect)),
                                    CGPointMake(CGRectGetMidX(oval37Rect), CGRectGetMaxY(oval37Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 38 Drawing
        CGRect oval38Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.53776 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.56979 + 0.5) - floor(CGRectGetWidth(group) * 0.53776 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval38Path = [UIBezierPath bezierPathWithOvalInRect: oval38Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval38Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval38Rect), CGRectGetMinY(oval38Rect)),
                                    CGPointMake(CGRectGetMidX(oval38Rect), CGRectGetMaxY(oval38Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 39 Drawing
        CGRect oval39Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.64531 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.67735 + 0.5) - floor(CGRectGetWidth(group) * 0.64531 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval39Path = [UIBezierPath bezierPathWithOvalInRect: oval39Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval39Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval39Rect), CGRectGetMinY(oval39Rect)),
                                    CGPointMake(CGRectGetMidX(oval39Rect), CGRectGetMaxY(oval39Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 40 Drawing
        CGRect oval40Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.75286 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.78490 + 0.5) - floor(CGRectGetWidth(group) * 0.75286 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval40Path = [UIBezierPath bezierPathWithOvalInRect: oval40Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval40Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval40Rect), CGRectGetMinY(oval40Rect)),
                                    CGPointMake(CGRectGetMidX(oval40Rect), CGRectGetMaxY(oval40Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 41 Drawing
        CGRect oval41Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.86041 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 0.89245 + 0.5) - floor(CGRectGetWidth(group) * 0.86041 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval41Path = [UIBezierPath bezierPathWithOvalInRect: oval41Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval41Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval41Rect), CGRectGetMinY(oval41Rect)),
                                    CGPointMake(CGRectGetMidX(oval41Rect), CGRectGetMaxY(oval41Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 42 Drawing
        CGRect oval42Rect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.96796 + 0.5), CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00000 + 0.5), floor(CGRectGetWidth(group) * 1.00000 + 0.5) - floor(CGRectGetWidth(group) * 0.96796 + 0.5), floor(CGRectGetHeight(group) * 1.00000 + 0.5) - floor(CGRectGetHeight(group) * 0.00000 + 0.5));
        UIBezierPath* oval42Path = [UIBezierPath bezierPathWithOvalInRect: oval42Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval42Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval42Rect), CGRectGetMinY(oval42Rect)),
                                    CGPointMake(CGRectGetMidX(oval42Rect), CGRectGetMaxY(oval42Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
    
    
    //// Group 7
    {
        //// Oval 43 Drawing
        CGRect oval43Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.00000 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.03204 + 0.5) - floor(CGRectGetWidth(group7) * 0.00000 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval43Path = [UIBezierPath bezierPathWithOvalInRect: oval43Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval43Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval43Rect), CGRectGetMinY(oval43Rect)),
                                    CGPointMake(CGRectGetMidX(oval43Rect), CGRectGetMaxY(oval43Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 44 Drawing
        CGRect oval44Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.10755 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.13959 + 0.5) - floor(CGRectGetWidth(group7) * 0.10755 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval44Path = [UIBezierPath bezierPathWithOvalInRect: oval44Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval44Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval44Rect), CGRectGetMinY(oval44Rect)),
                                    CGPointMake(CGRectGetMidX(oval44Rect), CGRectGetMaxY(oval44Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 45 Drawing
        CGRect oval45Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.21510 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.24714 + 0.5) - floor(CGRectGetWidth(group7) * 0.21510 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval45Path = [UIBezierPath bezierPathWithOvalInRect: oval45Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval45Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval45Rect), CGRectGetMinY(oval45Rect)),
                                    CGPointMake(CGRectGetMidX(oval45Rect), CGRectGetMaxY(oval45Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 46 Drawing
        CGRect oval46Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.32265 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.35469 + 0.5) - floor(CGRectGetWidth(group7) * 0.32265 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval46Path = [UIBezierPath bezierPathWithOvalInRect: oval46Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval46Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval46Rect), CGRectGetMinY(oval46Rect)),
                                    CGPointMake(CGRectGetMidX(oval46Rect), CGRectGetMaxY(oval46Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 47 Drawing
        CGRect oval47Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.43021 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.46224 + 0.5) - floor(CGRectGetWidth(group7) * 0.43021 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval47Path = [UIBezierPath bezierPathWithOvalInRect: oval47Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval47Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval47Rect), CGRectGetMinY(oval47Rect)),
                                    CGPointMake(CGRectGetMidX(oval47Rect), CGRectGetMaxY(oval47Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 48 Drawing
        CGRect oval48Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.53776 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.56979 + 0.5) - floor(CGRectGetWidth(group7) * 0.53776 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval48Path = [UIBezierPath bezierPathWithOvalInRect: oval48Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval48Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval48Rect), CGRectGetMinY(oval48Rect)),
                                    CGPointMake(CGRectGetMidX(oval48Rect), CGRectGetMaxY(oval48Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 49 Drawing
        CGRect oval49Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.64531 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.67735 + 0.5) - floor(CGRectGetWidth(group7) * 0.64531 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval49Path = [UIBezierPath bezierPathWithOvalInRect: oval49Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval49Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval49Rect), CGRectGetMinY(oval49Rect)),
                                    CGPointMake(CGRectGetMidX(oval49Rect), CGRectGetMaxY(oval49Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 50 Drawing
        CGRect oval50Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.75286 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.78490 + 0.5) - floor(CGRectGetWidth(group7) * 0.75286 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval50Path = [UIBezierPath bezierPathWithOvalInRect: oval50Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval50Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval50Rect), CGRectGetMinY(oval50Rect)),
                                    CGPointMake(CGRectGetMidX(oval50Rect), CGRectGetMaxY(oval50Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 51 Drawing
        CGRect oval51Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.86041 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 0.89245 + 0.5) - floor(CGRectGetWidth(group7) * 0.86041 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval51Path = [UIBezierPath bezierPathWithOvalInRect: oval51Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval51Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval51Rect), CGRectGetMinY(oval51Rect)),
                                    CGPointMake(CGRectGetMidX(oval51Rect), CGRectGetMaxY(oval51Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 52 Drawing
        CGRect oval52Rect = CGRectMake(CGRectGetMinX(group7) + floor(CGRectGetWidth(group7) * 0.96796 + 0.5), CGRectGetMinY(group7) + floor(CGRectGetHeight(group7) * 0.00000 + 0.5), floor(CGRectGetWidth(group7) * 1.00000 + 0.5) - floor(CGRectGetWidth(group7) * 0.96796 + 0.5), floor(CGRectGetHeight(group7) * 1.00000 + 0.5) - floor(CGRectGetHeight(group7) * 0.00000 + 0.5));
        UIBezierPath* oval52Path = [UIBezierPath bezierPathWithOvalInRect: oval52Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval52Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval52Rect), CGRectGetMinY(oval52Rect)),
                                    CGPointMake(CGRectGetMidX(oval52Rect), CGRectGetMaxY(oval52Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
    
    
    //// Group 6
    {
        //// Oval 29 Drawing
        CGRect oval29Rect = CGRectMake(CGRectGetMinX(group6) + floor(CGRectGetWidth(group6) * 0.00000 + 0.5), CGRectGetMinY(group6) + floor(CGRectGetHeight(group6) * 0.00000 + 0.5), floor(CGRectGetWidth(group6) * 1.00000 + 0.5) - floor(CGRectGetWidth(group6) * 0.00000 + 0.5), floor(CGRectGetHeight(group6) * 0.09459 + 0.5) - floor(CGRectGetHeight(group6) * 0.00000 + 0.5));
        UIBezierPath* oval29Path = [UIBezierPath bezierPathWithOvalInRect: oval29Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval29Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval29Rect), CGRectGetMinY(oval29Rect)),
                                    CGPointMake(CGRectGetMidX(oval29Rect), CGRectGetMaxY(oval29Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 31 Drawing
        CGRect oval31Rect = CGRectMake(CGRectGetMinX(group6) + floor(CGRectGetWidth(group6) * 0.00000 + 0.5), CGRectGetMinY(group6) + floor(CGRectGetHeight(group6) * 0.30405 + 0.5), floor(CGRectGetWidth(group6) * 1.00000 + 0.5) - floor(CGRectGetWidth(group6) * 0.00000 + 0.5), floor(CGRectGetHeight(group6) * 0.39865 + 0.5) - floor(CGRectGetHeight(group6) * 0.30405 + 0.5));
        UIBezierPath* oval31Path = [UIBezierPath bezierPathWithOvalInRect: oval31Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval31Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval31Rect), CGRectGetMinY(oval31Rect)),
                                    CGPointMake(CGRectGetMidX(oval31Rect), CGRectGetMaxY(oval31Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 32 Drawing
        CGRect oval32Rect = CGRectMake(CGRectGetMinX(group6) + floor(CGRectGetWidth(group6) * 0.00000 + 0.5), CGRectGetMinY(group6) + floor(CGRectGetHeight(group6) * 0.60811 + 0.5), floor(CGRectGetWidth(group6) * 1.00000 + 0.5) - floor(CGRectGetWidth(group6) * 0.00000 + 0.5), floor(CGRectGetHeight(group6) * 0.70270 + 0.5) - floor(CGRectGetHeight(group6) * 0.60811 + 0.5));
        UIBezierPath* oval32Path = [UIBezierPath bezierPathWithOvalInRect: oval32Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval32Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval32Rect), CGRectGetMinY(oval32Rect)),
                                    CGPointMake(CGRectGetMidX(oval32Rect), CGRectGetMaxY(oval32Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
        
        //// Oval 55 Drawing
        CGRect oval55Rect = CGRectMake(CGRectGetMinX(group6) + floor(CGRectGetWidth(group6) * 0.00000 + 0.5), CGRectGetMinY(group6) + floor(CGRectGetHeight(group6) * 0.90541 + 0.5), floor(CGRectGetWidth(group6) * 1.00000 + 0.5) - floor(CGRectGetWidth(group6) * 0.00000 + 0.5), floor(CGRectGetHeight(group6) * 1.00000 + 0.5) - floor(CGRectGetHeight(group6) * 0.90541 + 0.5));
        UIBezierPath* oval55Path = [UIBezierPath bezierPathWithOvalInRect: oval55Rect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [oval55Path addClip];
        CGContextDrawLinearGradient(context, luci,
                                    CGPointMake(CGRectGetMidX(oval55Rect), CGRectGetMinY(oval55Rect)),
                                    CGPointMake(CGRectGetMidX(oval55Rect), CGRectGetMaxY(oval55Rect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
    }
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGGradientRelease(luci);
    CGColorSpaceRelease(colorSpace);}


@end
