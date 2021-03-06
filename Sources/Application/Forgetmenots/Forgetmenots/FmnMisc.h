//
//  FmnMisc.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 28.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FmnMisc : NSObject

+ (BOOL)isToday:(NSDate *)date;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageToGreyImage:(UIImage *)image;

@end
