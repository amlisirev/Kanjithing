//
//  CharacterModel.m
//  Kanjister
//
//  Created by Sakari Ikonen on 19/06/14.
//  Copyright (c) 2014 Sakari Ikonen. All rights reserved.
//

#import "CharacterCollection.h"

@implementation CharacterCollection
{
    int currentcharidx;
    NSArray *hiragana;
    NSArray *katakana;
    NSArray *romaji;
    NSArray *repetitions;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    currentcharidx = 0;
    hiragana = [NSArray arrayWithObjects:@"あ", @"い", @"う", @"え", @"お", @"や", @"ゆ", @"よ", @"か", @"き", @"く",@"け", @"こ", @"きゃ", @"きゅ", @"きょ", @"が", @"ぎ", @"ぐ",@"げ", @"ご", @"ぎゃ", @"ぎゅ", @"ぎょ", @"さ", @"し", @"す",@"せ", @"そ", @"しゃ", @"しゅ", @"しょ", @"ざ", @"じ",@"ず", @"ぜ", @"ぞ", @"じゃ", @"じゅ", @"じょ", @"た", @"ち", @"つ", @"て", @"と", @"ちゃ", @"ちゅ", @"ちょ", @"だ", @"ぢ", @"づ", @"で", @"ど", @"ぢゃ", @"ぢゅ", @"ぢょ", @"な", @"に", @"ぬ", @"ね", @"の", @"にゃ", @"にゅ", @"にょ", @"ま", @"み", @"む", @"め", @"も", @"みゃ", @"みゅ", @"みょ", @"は", @"ひ", @"ふ", @"へ", @"ほ", @"ひゃ", @"ひゅ", @"ひょ", @"ば", @"び", @"ぶ", @"べ", @"ぼ", @"びゃ", @"びゅ", @"びょ", @"ぱ", @"ぴ", @"ぷ", @"ぺ", @"ぽ", @"ぴゃ", @"ぴゅ", @"ぴょ", @"ら", @"り", @"る", @"れ", @"ろ", @"りゃ", @"りゅ", @"りょ", @"わ", @"を", @"ん",  nil];
    
    katakana = [NSArray arrayWithObjects:@"ア",@"イ", @"ウ", @"エ", @"オ", @"ヤ", @"ユ", @"ヨ", @"カ", @"キ", @"ク", @"ケ", @"コ", @"キャ", @"キュ", @"キョ", @"ガ", @"ギ", @"グ", @"ゲ", @"ゴ", @"ギャ", @"ギュ", @"ギョ", @"サ", @"シ", @"ス", @"セ", @"ソ", @"シャ", @"シュ", @"ショ", @"ザ", @"ジ", @"ズ", @"ゼ", @"ゾ", @"ジャ", @"ジュ", @"ジョ", @"タ", @"チ", @"ツ", @"テ", @"ト", @"チャ", @"チュ", @"チョ", @"ダ", @"ヂ", @"ヅ", @"デ", @"ド", @"ヂャ", @"ヂュ", @"ヂョ", @"ナ", @"ニ", @"ヌ", @"ネ", @"ノ", @"ニャ", @"ニュ", @"ニョ", @"マ", @"ミ", @"ム", @"メ", @"モ", @"ミャ", @"ミュ", @"ミョ", @"ハ", @"ヒ", @"フ", @"ヘ", @"ホ", @"ヒャ", @"ヒュ", @"ヒョ", @"バ", @"ビ", @"ブ", @"ベ", @"ボ", @"ビャ", @"ビュ", @"ビョ", @"パ", @"ピ", @"プ", @"ペ", @"ポ", @"ピャ", @"ピュ", @"ピョ", @"ラ", @"リ", @"ル", @"レ", @"ロ", @"リャ", @"リュ", @"リョ", @"ワ", @"ヲ", @"ン", nil];
    
    romaji = [NSArray arrayWithObjects:@"a", @"i", @"u", @"e", @"o", @"ya", @"yu", @"yo", @"ka", @"ki", @"ku", @"ke", @"ko", @"kya", @"kyu", @"kyo", @"ga", @"gi", @"gu", @"ge", @"go", @"gya", @"gyu", @"gyo", @"sa", @"shi", @"su", @"se", @"so", @"shya", @"shyu", @"shyo", @"za", @"ji", @"zu", @"ze", @"zo", @"zya", @"zyu", @"zyo", @"ta", @"chi", @"tsu", @"te", @"to", @"cha", @"chu", @"cho", @"da", @"ji", @"zu", @"de", @"do", @"dya", @"dyu", @"dyo", @"na", @"ni", @"nu", @"ne", @"no", @"nya", @"nyu", @"nyo", @"ma", @"mi", @"mu", @"me", @"mo", @"mya", @"myu", @"myo", @"ha", @"hi", @"fu", @"he", @"ho", @"hya", @"hyu", @"hyo", @"ba", @"bi", @"bu", @"be", @"bo", @"bya", @"byu", @"byo", @"pa", @"pi", @"pu", @"pe", @"po", @"pya", @"pyu", @"pyo", @"wa", @"wo", @"n", nil];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
}

-(NSInteger)repetitions{
    return 0;
}
-(void)upRepetitions {
    
}

-(NSString *)currentCharacter {
    return hiragana[currentcharidx];
}

-(void)next {
    currentcharidx++;
}
-(void)previous {
    currentcharidx--;
}

-(NSString *)romaji {
    return romaji[currentcharidx];
}
@end
