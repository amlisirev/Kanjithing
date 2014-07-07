//
//  StrokeCollection.m
//  Kanjister
//
//  Created by Sakari Ikonen on 07/07/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "StrokeCollection.h"

@implementation StrokeCollection {
    NSMutableArray *strokepoints;
    NSDate *strokestart;
    NSDate *laststroke;
    NSUInteger brushwidth;
}

- (id)initWithBrush:(NSUInteger)brush
{
    self = [super init];
    if (self) {
        [self clear];
        brushwidth = brush;
    }
    return self;
}

-(void)addStroke:(CGPoint)point {
    [strokepoints addObject:[NSValue valueWithCGPoint:point]];
    if (strokestart) {
        laststroke = [NSDate date];
    } else {
        strokestart = [NSDate date];
    }
    
}

-(NSInteger)strokeCount {
    return strokepoints.count/2;
}
-(NSTimeInterval)duration {
    return [laststroke timeIntervalSince1970] - [strokestart timeIntervalSince1970];
}

-(void)clear {
    strokepoints = [[NSMutableArray alloc] init];
    strokestart = nil;
    laststroke = nil;
}
@end
