//
//  scribbleView.h
//  Kanjister
//
//  Created by Sakari Ikonen on 14/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class scribbleView;
@protocol scribbleViewDelegate <NSObject>

-(void)mainImageDidChange;
-(void)strokeDidFinish;
@end

@interface scribbleView : UIView
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *background;
@property (weak) id <scribbleViewDelegate> delegate;

-(NSInteger)strokes;
-(NSArray*)strokelist;
@end
