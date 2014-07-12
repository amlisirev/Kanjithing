//
//  StrokeCollection.h
//  Kanjister
//
//  Created by Sakari Ikonen on 07/07/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrokeCollection : NSObject
-(id)initWithBrush:(NSUInteger)brush;
-(void)addStroke:(CGPoint)point;
-(NSInteger)strokeCount;
-(NSArray*)sortedLabels;
-(NSTimeInterval)duration;
-(void)clear;
+(NSUInteger)countStrokes:(NSArray *)array;
+(bool)compare:(NSArray*)array1 to:(NSArray*)array2;
@end
