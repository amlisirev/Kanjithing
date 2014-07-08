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
    NSMutableArray *labeledstrokes;
}

- (id)initWithBrush:(NSUInteger)brush
{
    self = [super init];
    if (self) {
        [self clear];
        brushwidth = brush;
        strokepoints = [[NSMutableArray alloc] init];
        labeledstrokes = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addStroke:(CGPoint)point {
    [strokepoints addObject:[NSValue valueWithCGPoint:point]];
    [self updateStrokeLabels];
    if (strokestart) {
        laststroke = [NSDate date];
    } else {
        strokestart = [NSDate date];
    }
}

-(NSInteger)strokeCount {
    NSLog(@"labels %@", [self sortedLabels]);
    return strokepoints.count/2;
}
-(NSTimeInterval)duration {
    return [laststroke timeIntervalSince1970] - [strokestart timeIntervalSince1970];
}

-(void)clear {
    [strokepoints removeAllObjects];
    [labeledstrokes removeAllObjects];
    strokestart = nil;
    laststroke = nil;
}

-(void)updateStrokeLabels {
    [labeledstrokes removeAllObjects];
    for (NSValue *item in strokepoints) {
        NSUInteger index = [strokepoints indexOfObject:item];
        NSString *label;
        bool loop = FALSE;
        if (index%2) {
            if ([self distanceBetween:[item CGPointValue] and:[[strokepoints objectAtIndex:(index-1)] CGPointValue]] < brushwidth) {loop = TRUE;}
            label = [NSString stringWithFormat:@"%@%d",(loop ? @"*E": @"E"), index/2];
        } else {
            label = [NSString stringWithFormat:@"S%d", index/2];
        }
        NSDictionary *dict = @{@"label": label, @"point": item};
        [labeledstrokes addObject:dict];
    }
}
-(NSArray *)sortedLabels {
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for (NSDictionary *item in [self sortStrokes:labeledstrokes]) {
        [labels addObject:[item valueForKey:@"label"]];
    }
    return labels;
}

-(NSUInteger)distanceBetween:(CGPoint)point1 and:(CGPoint)point2{
    NSUInteger xD= point1.x-point2.x;
    NSUInteger yD= point1.y-point2.y;
    NSUInteger dist = sqrt(xD*xD+yD*yD);
    return dist;
}

-(NSArray *)sortStrokes:(NSArray *)strokes {
    NSArray *sorted = [strokes sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint point1 = [[obj1 valueForKey:@"point"] CGPointValue];
        CGPoint point2 = [[obj2 valueForKey:@"point"] CGPointValue];
        if (point1.y < point2.y) return NSOrderedAscending;
        if (point1.y == point2.y & point1.x < point2.x) return NSOrderedAscending;
        return NSOrderedDescending;
    }];
    return sorted;
}
@end