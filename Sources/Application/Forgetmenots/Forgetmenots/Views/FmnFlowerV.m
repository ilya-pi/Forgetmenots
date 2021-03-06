//
//  FlowerView.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.04.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnFlowerV.h"
#import "FmnFlowers.h"
#include <math.h>
#include "FmnMisc.h"

@implementation FmnFlowerV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFlower:(Flower *)flower
{
    _flower = flower;
    [self setNeedsDisplay];
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark Drawing

#define CAPTION_OFFSET 10
#define CAPTION_SIZE 30
#define CAPTION_LINE_HEIGHT (CAPTION_OFFSET + CAPTION_SIZE)

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Drawing everything to memmory and then rendering it (to apply filters, night we want to)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width, rect.size.height), NO, 0.0);
    CGContextRef wrapperContext = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(wrapperContext);

    CGRect flowerRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - CAPTION_LINE_HEIGHT);
    [FmnFlowers drawBullseyeFlowerInRect:flowerRect withFlower:self.flower];
    
    // Drawing complete, grab the image now
    UIGraphicsPopContext();
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (! self.selected)
    {
        outputImage = [FmnMisc imageToGreyImage:outputImage];
    }
    [outputImage drawInRect:rect];

    CGRect captionRect = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height - CAPTION_SIZE, rect.size.width, CAPTION_SIZE);
    [self drawNameInRect:captionRect];
}

- (void)drawNameInRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    NSAttributedString *titleText = [[NSAttributedString alloc]
                                     initWithString : self.flower.name
                                     attributes : @{NSFontAttributeName : titleFont,
                                                    NSParagraphStyleAttributeName : paragraphStyle,
                                                    NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [titleText drawInRect:rect];
}

@end
