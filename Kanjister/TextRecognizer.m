//
//  TextRecognition.m
//  Kanjister
//
//  Created by Sakari Ikonen on 17/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "TextRecognizer.h"


@implementation TextRecognizer
{
    NSString *_language;
    NSString *_characters;
}

-(id)initWithLanguage:(NSString *)language andCharacterList:(NSString *)characters
{
    if (self = [super init])
    {
        _language = language;
        _characters = characters;
    }
    return self;
}


-(NSString *)recognizeText:(UIImage *)image
{
    Tesseract *tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:_language];
    [tesseract setImage:image];
    [tesseract setVariableValue:_characters forKey:@"tessedit_char_whitelist"];
    [tesseract setVariableValue:@"FALSE" forKey:@"force_word_assoc"];
    [tesseract recognize];
    self.translatedText = [[tesseract recognizedText] stringByReplacingOccurrencesOfString:@"\n" withString:@""]; //had to remove whitespace because tesseract is an asshole.
    [tesseract clear];
    return self.translatedText;
}

@end