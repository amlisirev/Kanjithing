//
//  scribbleView.m
//  Kanjister
//
//  Created by Sakari Ikonen on 14/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "scribbleView.h"


@implementation scribbleView
{
    UIBezierPath *path;
    UIImage *cachedImage;
    uint counter;
    CGPoint points[5];
}
@synthesize delegate = _delegate;

- (id)initWithCoder:(NSCoder *) aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.image = nil;
        self.delegate = nil;
        [self setMultipleTouchEnabled:NO];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eraseDrawing:)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
        path = [UIBezierPath bezierPath];
        [path setLineWidth:10.0];
        
    }
    return self;
}

- (void)eraseDrawing:(UITapGestureRecognizer *)t
{
    self.image = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    counter = 0;
    points[0] = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    counter++;
    points[counter] = [touch locationInView:self];
    if (counter==4)
    {
        points[3] = CGPointMake((points[2].x + points[4].x)/2.0, (points[2].y + points[4].y)/2.0);
        [path moveToPoint:points[0]];
        [path addCurveToPoint:points[3] controlPoint1:points[1] controlPoint2:points[2]];
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
        if (!cachedImage)
        {
            UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
            [[UIColor whiteColor] setFill];
            [rectpath fill];
        }
        [cachedImage drawAtPoint:CGPointZero];
        [[UIColor blackColor] setStroke];
        [path stroke];
        cachedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setNeedsDisplay];
        [path removeAllPoints];
        points[0] = points[3];
        points[1] = points[4];
        counter = 1;
    }
}

- (void)drawRect:(CGRect)rect
{
    [cachedImage drawInRect:rect];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    [self.delegate mainImageDidChange];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}

-(UIImage *)image
{
    return cachedImage;
}
-(void)setImage:(UIImage *)image
{
    cachedImage = image;
    [self setNeedsDisplay];
    [self.delegate mainImageDidChange];
}

@end