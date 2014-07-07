//
//  scribbleView.m
//  Kanjister
//
//  Created by Sakari Ikonen on 14/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "scribbleView.h"
#import "StrokeCollection.h"


@implementation scribbleView
{
    StrokeCollection *strokes;
    UIBezierPath *path;
    UIImage *cachedImage;
    uint counter;
    CGPoint points[5];
    CGPoint pointsBuffer[100];
    uint bufferIndex;
    dispatch_queue_t drawingQueue;
}
@synthesize delegate = _delegate;

- (id)initWithCoder:(NSCoder *) aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.image = nil;
        self.delegate = nil;
        self.background = nil;
        strokes = [[StrokeCollection alloc] initWithBrush:10.0];
        [self setMultipleTouchEnabled:NO];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eraseDrawing:)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        drawingQueue = dispatch_queue_create("drawingQueue", NULL);
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
    [strokes addStroke:[touch locationInView:self]];
    counter = 0;
    bufferIndex = 0;
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
        pointsBuffer[bufferIndex] = points[0];
        pointsBuffer[bufferIndex + 1] = points[1];
        pointsBuffer[bufferIndex + 2] = points[2];
        pointsBuffer[bufferIndex + 3] = points[3];
        bufferIndex +=4;
        dispatch_async(drawingQueue, ^{
            if (bufferIndex == 0) return;
            path = [UIBezierPath bezierPath];
            for ( int i = 0; i < bufferIndex; i += 4)
            {
                [path moveToPoint:pointsBuffer[i]];
                [path addCurveToPoint:pointsBuffer[i+3] controlPoint1:pointsBuffer[i+1] controlPoint2:pointsBuffer[i+2]];
            }
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
            if (!cachedImage)
            {
                UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
                [[UIColor whiteColor] setFill];
                [rectpath fill];
            }
            [cachedImage drawAtPoint:CGPointZero];
            [[UIColor blackColor] setStroke];
            [path setLineWidth:10.0];
            [path stroke];
            cachedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            dispatch_async(dispatch_get_main_queue(), ^{
                bufferIndex=0;
                [self setNeedsDisplay];
            });
        });
        points[0] = points[3];
        points[1] = points[4];
        counter = 1;
    }
}

- (void)drawRect:(CGRect)rect
{
    [cachedImage drawInRect:rect];
    // [self.background drawInRect:rect blendMode:kCGBlendModeOverlay alpha:0.8];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [strokes addStroke:[touch locationInView:self]];
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
    [strokes clear];
    cachedImage = image;
    [self setNeedsDisplay];
    [self.delegate mainImageDidChange];
}
-(NSInteger)strokes {
    return strokes.strokeCount;
}

@end