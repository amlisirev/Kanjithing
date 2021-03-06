//
//  CharacterModel.h
//  Kanjister
//
//  Created by Sakari Ikonen on 19/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterCollection : NSObject

-(void)next;
-(void)previous;
-(NSString *)currentCharacter;
-(NSString *)romaji;
-(NSInteger)currentCharRepetitions;
-(NSInteger)currentCharStrokes;
-(NSArray*)currentCharStrokeList;
-(void)upRepetitions;
-(NSUInteger)repetitions;
@end
