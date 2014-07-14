//
//  CharacterModel.m
//  Kanjister
//
//  Created by Sakari Ikonen on 19/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "CharacterCollection.h"
#import "StrokeCollection.h"

@implementation CharacterCollection
{
    int currentcharidx;
    NSArray *hiragana;
    NSArray *katakana;
    NSUInteger repetitions;
}

-(id)init {
    if (self = [super init]) {
        currentcharidx = 0;
        repetitions = 0;
        NSString *hiraganafile = [[NSBundle mainBundle] pathForResource:@"HiraganaCharacters" ofType:@"plist"];
        NSString *katakanafile = [[NSBundle mainBundle] pathForResource:@"HiraganaCharacters" ofType:@"plist"];
        hiragana = [NSArray arrayWithContentsOfFile:hiraganafile];
        katakana = [NSArray arrayWithContentsOfFile:katakanafile];    
    }
    return self;
}

-(NSInteger)currentCharRepetitions{
    return 0;
}
-(NSInteger)currentCharStrokes {
    return [StrokeCollection countStrokes:[hiragana[currentcharidx] valueForKey:@"strokes"]];
}
-(NSArray *)currentCharStrokeList {
    return [hiragana[currentcharidx] valueForKeyPath:@"strokes"];
}

-(NSUInteger)repetitions {
    return repetitions;
}
-(void)upRepetitions {
    repetitions++;
}

-(NSString *)currentCharacter {
    return [hiragana[currentcharidx] valueForKey:@"character"];
}

-(void)next {
    currentcharidx++;
    repetitions=0;
}
-(void)previous {
    currentcharidx--;
    repetitions=0;
}

-(NSString *)romaji {
    return [hiragana[currentcharidx] valueForKey:@"romaji"];
}
@end
