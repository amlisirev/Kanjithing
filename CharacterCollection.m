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
    NSArray *repetitions;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    currentcharidx = 0;
    NSString *hiraganafile = [[NSBundle mainBundle] pathForResource:@"HiraganaCharacters" ofType:@"plist"];
    NSString *katakanafile = [[NSBundle mainBundle] pathForResource:@"HiraganaCharacters" ofType:@"plist"];
    hiragana = [NSArray arrayWithContentsOfFile:hiraganafile];
    katakana = [NSArray arrayWithContentsOfFile:katakanafile];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
}

-(NSInteger)currentCharRepetitions{
    return 0;
}
-(NSInteger)currentCharStrokes {
    return [StrokeCollection countStrokes:[hiragana[currentcharidx] valueForKey:@"strokes"]];
}

-(void)upRepetitions {
    
}

-(NSString *)currentCharacter {
    return [hiragana[currentcharidx] valueForKey:@"character"];
}

-(void)next {
    currentcharidx++;
}
-(void)previous {
    currentcharidx--;
}

-(NSString *)romaji {
    return [hiragana[currentcharidx] valueForKey:@"romaji"];
}
@end
