//
//  TextSpeaker.h
//  Kanjister
//
//  Created by Sakari Ikonen on 17/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TextSpeaker : NSObject

-(void)speakText:(NSString *)text;
-(id)initWithLanguage:(NSString *)language;

@end

