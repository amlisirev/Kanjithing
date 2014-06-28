//
//  DrawViewController.h
//  Kanjister
//
//  Created by Sakari Ikonen on 12/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scribbleView.h"

@interface DrawViewController : UIViewController <scribbleViewDelegate> {

}
- (IBAction)imageClear:(id)sender;
@property (weak, nonatomic) IBOutlet scribbleView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *translatedText;
@property (weak, nonatomic) IBOutlet UILabel *currentChar;
@property (weak, nonatomic) IBOutlet UIButton *speakTextButton;

@end
