//
//  TextRecognition.h
//  Kanjister
//
//  Created by Sakari Ikonen on 17/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TextRecognizer : NSObject
@property (weak, nonatomic) NSString *translatedText;

-(NSString *)recognizeText:(UIImage *)image;
-(id)initWithLanguage:(NSString *)language andCharacterList:(NSString *)characters;

@end
