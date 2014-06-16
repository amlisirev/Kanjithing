//
//  ViewController.m
//  Kanjister
//
//  Created by Sakari Ikonen on 12/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "DrawViewController.h"
#import "Tesseract.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mainImage.delegate = self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)translateImage:(UIImage *)image {
    Tesseract *tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"jpn"];
    [tesseract setImage:image];
    [tesseract setVariableValue:@"あえいおうやゆよかけきこくきゃきゅきょがげぎごぐぎゃぎゅぎょさせちつそちゃちゅちょ" forKey:@"tessedit_char_whitelist"];
    [tesseract recognize];
    self.translatedText.text = [tesseract recognizedText];
    [tesseract clear];
}

-(void)mainImageDidChange
{
    if (self.mainImage.image) {
     [self translateImage:self.mainImage.image];
    }
}

- (IBAction)imageClear:(id)sender {
    self.mainImage.image = nil;
}
- (IBAction)speakText:(id)sender {
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ja-JP"];
    AVSpeechUtterance *text = [AVSpeechUtterance speechUtteranceWithString:self.translatedText.text];
    text.voice = voice;
    AVSpeechSynthesizer *speaker = [AVSpeechSynthesizer alloc];
    [speaker speakUtterance:text];
}
@end
