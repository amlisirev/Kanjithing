//
//  DrawViewController.m
//  Kanjister
//
//  Created by Sakari Ikonen on 12/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "DrawViewController.h"
#import "Tesseract.h"
#import "TextSpeaker.h"
#import "TextRecognizer.h"

@interface DrawViewController ()

@end

@implementation DrawViewController
{
    uint currentcharidx;
    uint repetitions;
    NSArray *hiragana;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mainImage.delegate = self;
    hiragana = [NSArray arrayWithObjects:@"あ", @"え", @"い", @"お", @"う", @"や", @"ゆ", @"よ", @"か", @"け", nil];
    currentcharidx = 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)translateImage:(UIImage *)image {
    TextRecognizer *recon = [[TextRecognizer alloc] initWithLanguage:@"jpn"
                                                    andCharacterList:hiragana[currentcharidx]];
    NSString *text = [recon recognizeText:image];
    [self isTextMatching:text];
    NSLog(@"%d, %@", text.length, text);
}

-(void)mainImageDidChange
{
    if (self.mainImage.image) {
     [self translateImage:self.mainImage.image];
    }
}
-(void)isTextMatching:(NSString *)text
{
    if ([text isEqualToString:hiragana[currentcharidx]]) {
        self.translatedText.text = @"correct!";
        NSLog(@"YESSSSSSSS SLITHERIN");
        if (repetitions > 2 ) {
            currentcharidx++;
            repetitions = 0;
        } else {
            repetitions++;
        }
    } else {
        self.translatedText.text = @"still incorrect!";
    }
}

- (IBAction)imageClear:(id)sender {
    self.mainImage.image = nil;
}
- (IBAction)speakText:(id)sender {
    TextSpeaker *speaker = [[TextSpeaker alloc] initWithLanguage:@"ja-JP"];
    [speaker speakText:hiragana[currentcharidx]];
}
@end
