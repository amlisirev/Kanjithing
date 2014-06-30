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
#import "CharacterCollection.h"

@interface DrawViewController ()

@end

@implementation DrawViewController
{
    uint repetitions;
    CharacterCollection *characters;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mainImage.delegate = self;
    characters = [[CharacterCollection alloc] initWithCoder:nil];
    [self updateCurrentChar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)translateImage:(UIImage *)image {
    TextRecognizer *recon = [[TextRecognizer alloc] initWithLanguage:@"jpn"
                                                    andCharacterList:[characters currentCharacter]];
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
    if ([text isEqualToString:[characters currentCharacter]]) {
        self.translatedText.text = @"correct!";
        NSLog(@"YESSSSSSSS SLITHERIN");
        if (repetitions > 2 ) {
            [characters next];
            repetitions = 0;
            [self updateCurrentChar];
        } else {
            repetitions++;
        }
    } else {
        self.translatedText.text = nil;
    }
}

- (IBAction)imageClear:(id)sender {
    self.mainImage.image = nil;
}
- (IBAction)speakText:(id)sender {
    TextSpeaker *speaker = [[TextSpeaker alloc] initWithLanguage:@"ja-JP"];
    [speaker speakText:[characters currentCharacter]];
}
-(void)updateCurrentChar {
    self.currentChar.text = [characters romaji];
    [self.speakTextButton setTitle:[characters currentCharacter] forState:UIControlStateNormal];
}

- (IBAction)skipCharacter:(id)sender {
    [characters next];
    [self updateCurrentChar];
}

@end
