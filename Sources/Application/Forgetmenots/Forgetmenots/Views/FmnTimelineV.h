//
//  FmnTimelineV.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 04.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flower+Defaults.h"

@interface FmnTimelineV : UIView

@property (nonatomic, strong) NSDateFormatter * dateFormatter;

@property (nonatomic, strong) NSArray * scheduledEvents;

@property (nonatomic) int focusedEvent;

@property (nonatomic) CGFloat step;

@end