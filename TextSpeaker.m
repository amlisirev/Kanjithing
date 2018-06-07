//
//  TextSpeaker.m
//  Kanjister
//
//  Created by Sakari Ikonen on 17/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "TextSpeaker.h"

@implementation TextSpeaker
{
    NSString *_lang;
}
@synthesize player;

-(id)initWithLanguage:(NSString *)language
{
    if (self = [super init])
    {
        _lang = language;
    }
    return self;
}


-(void)speakText:(NSString *)text
{
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:_lang];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    utterance.voice = voice;
    AVSpeechSynthesizer *speaker = [AVSpeechSynthesizer alloc];
    [speaker speakUtterance:utterance];
}

-(void)playSound:(NSString *)soundname {
    NSString *bundlepath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"audioclips"];
    NSString *soundpath = [bundlepath stringByAppendingPathComponent:soundname];
    NSLog(@"%@", soundpath);
    if (soundpath) {
        NSURL *soundURL = [NSURL fileURLWithPath:soundpath];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        [player play];
        NSLog(@"PLAY SOUND GODDAMN");
    }
}

@end



