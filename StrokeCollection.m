//
//  StrokeCollection.m
//  Kanjister
//
//  Created by Sakari Ikonen on 07/07/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//
// code for describing stroke order of symbols, as an array.
//
// output consists of S#, E#, L#, D#, where S denotes starting point, E the Ending point,
// L a loop. and D a dakuten mark.
// # is the absolute number of the stroke, not the index in the strokearray. for the dakuten, the index should be the last stroke.

#import "StrokeCollection.h"
#define FUDGE 5
@implementation StrokeCollection {
    NSMutableArray *strokepoints;
    NSDate *strokestart;
    NSDate *laststroke;
    NSUInteger brushwidth;
    NSMutableArray *labeledstrokes;
    NSUInteger strokecount;
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
    if (strokecount==0) {
        strokecount = [StrokeCollection countStrokes:[self sortedLabels]];
    }
    return strokecount;
}
-(NSTimeInterval)duration {
    return [laststroke timeIntervalSince1970] - [strokestart timeIntervalSince1970];
}

-(void)clear {
    [strokepoints removeAllObjects];
    [labeledstrokes removeAllObjects];
    strokestart = nil;
    laststroke = nil;
    strokecount = 0;
}

-(void)updateStrokeLabels {
    [labeledstrokes removeAllObjects];
    for (NSValue *item in strokepoints) {
        NSUInteger index = [strokepoints indexOfObject:item];
        NSString *label;
        bool loop = FALSE;
        bool daku = FALSE;
        bool currenttopdown = FALSE;
        bool lasttopdown = FALSE;
        if (index%2) {
            if ([StrokeCollection distanceBetween:[item CGPointValue] and:[[strokepoints objectAtIndex:(index-1)] CGPointValue]] < brushwidth*2) {loop = TRUE; }
            if (index >=3) {
                lasttopdown = [StrokeCollection isAbove:[strokepoints objectAtIndex:index-2] of:[strokepoints objectAtIndex:index-3]];
                currenttopdown = [StrokeCollection isAbove:item of:[strokepoints objectAtIndex:index-1]];
                NSUInteger distbetweenstarts = [StrokeCollection distanceBetween:[[strokepoints objectAtIndex:index-1] CGPointValue] and:[[strokepoints objectAtIndex:index-3] CGPointValue]];
                NSUInteger distbetweenends = [StrokeCollection distanceBetween:[item CGPointValue] and:[[strokepoints objectAtIndex:index-2] CGPointValue]];
                NSLog(@"%d and %d, true? %d, %d, %d, %d", distbetweenends, distbetweenstarts, lasttopdown, currenttopdown, distbetweenends < brushwidth*FUDGE, distbetweenstarts < brushwidth*FUDGE);
                if (lasttopdown && currenttopdown && (distbetweenends < brushwidth*FUDGE) && (distbetweenstarts < brushwidth*FUDGE)){daku=TRUE;loop=FALSE;}
            }
            label = [NSString stringWithFormat:@"%@%d",(loop ? @"L": (daku ? @"D": @"E")), index/2];
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

-(NSArray *)sortStrokes:(NSArray *)strokes {
    NSMutableArray *trimmedlabels = [[NSMutableArray alloc] initWithArray:labeledstrokes]; //remove the starting point of loops and previous strokes of dakuten
    NSMutableIndexSet *removeindexes = [[NSMutableIndexSet alloc] init];
    for (NSDictionary *item in labeledstrokes){
        if ([[[item valueForKey:@"label"] substringToIndex:1] isEqualToString:@"L"]) {
            [removeindexes addIndex:[labeledstrokes indexOfObject:item]-1];
        }
        if ([[[item valueForKey:@"label"] substringToIndex:1] isEqualToString:@"D"]) {
            [removeindexes addIndex:[labeledstrokes indexOfObject:item]-1];
            [removeindexes addIndex:[labeledstrokes indexOfObject:item]-2];
            [removeindexes addIndex:[labeledstrokes indexOfObject:item]-3];
        }
    };
    [trimmedlabels removeObjectsAtIndexes:removeindexes];
    NSArray *sorted = [trimmedlabels sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint point1 = [[obj1 valueForKey:@"point"] CGPointValue];
        CGPoint point2 = [[obj2 valueForKey:@"point"] CGPointValue];
        if (point1.y < point2.y) return NSOrderedAscending;
        if (point1.y == point2.y & point1.x < point2.x) return NSOrderedAscending;
        return NSOrderedDescending;
    }];
    return sorted;
}

+(NSUInteger)countStrokes:(NSArray *)array {
    NSUInteger count = 0;
    for (NSString *item in array) {
        if ([[item substringToIndex:1] isEqualToString:@"S"]) {count++;}
        if ([[item substringToIndex:1] isEqualToString:@"L"]) {count++;}
        if ([[item substringToIndex:1] isEqualToString:@"D"]) {count+=2;}
        }
    return count;
}
+(bool)isAbove:(NSValue *)point1 of:(NSValue *)point2 {
    if ([point1 CGPointValue].y > [point2 CGPointValue].y) {return true;}
    return false;
}
+(NSUInteger)distanceBetween:(CGPoint)point1 and:(CGPoint)point2{
    NSUInteger xD= point1.x-point2.x;
    NSUInteger yD= point1.y-point2.y;
    NSUInteger dist = sqrt(xD*xD+yD*yD);
    return dist;
}
@end