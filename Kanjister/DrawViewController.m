//
//  DrawViewController.m
//  Kanjister
//
//  Created by Sakari Ikonen on 12/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "DrawViewController.h"
#import "TextSpeaker.h"
#import "TextRecognizer.h"
#import "CharacterCollection.h"

@interface DrawViewController ()

@end

@implementation DrawViewController
{
    uint repetitions;
    CharacterCollection *character;
    BOOL recent_eval;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mainImage.delegate = self;
    recent_eval=YES;
    character = [[CharacterCollection alloc] initWithCoder:nil];
    [self updateCurrentChar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mainImageDidChange
{
    recent_eval = NO;
    [self evaluateResult];
}

-(void)evaluateResult {
    if (recent_eval) return;
    if (self.mainImage.image) {
        NSString *text = [self translateImage:self.mainImage.image];
        if ([self isTextMatching:text], self.mainImage.strokes==3) {
            self.translatedText.text = @"correct!";
            recent_eval = YES;
            if (repetitions > 2) {
                [character next];
                [self updateCurrentChar];
                repetitions = 0;
            } else {
                repetitions++;
            }
        } else {
            return;
        }
    }
}

-(BOOL)isTextMatching:(NSString *)text
{
    if ([text isEqualToString:[character currentCharacter]]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)translateImage:(UIImage *)image {
    TextRecognizer *recon = [[TextRecognizer alloc] initWithLanguage:@"jpn"
                                                    andCharacterList:[character currentCharacter]];
    NSString *text = [recon recognizeText:image];
    return text;
    NSLog(@"%d, %@", text.length, text);
}

- (IBAction)speakText:(id)sender {
    TextSpeaker *speaker = [[TextSpeaker alloc] initWithLanguage:@"ja-JP"];
    [speaker speakText:[character currentCharacter]];
}
-(void)updateCurrentChar {
    self.currentChar.text = [character romaji];
    [self.speakTextButton setTitle:[character currentCharacter] forState:UIControlStateNormal];
}

- (IBAction)skipCharacter:(id)sender {
    [character next];
    [self updateCurrentChar];
}
- (IBAction)imageClear:(id)sender {
    self.mainImage.image = nil;
}
@end