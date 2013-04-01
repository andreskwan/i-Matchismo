//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andres Kwan on 2/22/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString * )contents
{
    //1
    //NSLog(@"using the object @: %@",[NSString stringWithFormat:@"%d%@", self.rank, self.suit]);

    //2
    //NSArray *rankStrings = nil;
    //rankStrings = @[@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"J",@"Q",@"K"];
    //NSLog(@"rankStrings[self.rank]: %@", rankStrings[self.rank]);
    

    //NSLog(@"Rank value: %d",self.rank);
    //NSLog(@"Rank value: %@",[PlayingCard rankStrings][self.rank]);
    
    //3
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

//getter
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

//setter
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSUInteger)maxRank { return [self rankStrings].count - 1;}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

//- (int)match:(NSArray *)otherCards
//{
//    NSLog(@"----------------------------------");
//    NSLog(@"PlayingCard.match");
//    int score = 0;    
//    if (otherCards.count == 1) {
//        PlayingCard *otherCard = [otherCards lastObject];
//        if ([otherCard.suit isEqualToString:self.suit]) {
//            score = 1;
//            
//        }else if (otherCard.rank == self.rank){
//            score = 4;
//            
//        }
//    }
//    return score;
//}

- (int)match:(NSArray *)otherCards
{
    NSLog(@"----------------------------------");
    NSLog(@"PlayingCard.match");
    NSLog(@"otherCards.count: %i",otherCards.count);
    int score = 0;
    for (PlayingCard * otherCard in otherCards) {
        NSLog(@"otherCard: %@", otherCard.contents);
        if ([otherCard.suit isEqualToString:self.suit]) {
            score += 1;
            self.matchedCardAttribute = self.suit;
        }else if (otherCard.rank == self.rank){
            score += 4;
            self.matchedCardAttribute = @"#";
        }
        NSLog(@"self.matchedCardAttribute: %@",self.matchedCardAttribute );
    }
    return score;
}

-(int) verfyMatch:(NSMutableArray *)matchedCards {
    int score = 0;
    if (![self.matchedCardAttribute compare:@"#"]) {
        for (PlayingCard * playingCard in matchedCards) {
            if ([playingCard.suit isEqualToString:self.suit]) {
                score += 8;
                NSLog(@"♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣♣");
                NSLog(@"Matched by suit");
                NSLog(@"self.matchedCardAttribute: %@",self.matchedCardAttribute );
            }
        }
    }else{
        for (PlayingCard * playingCard in matchedCards) {
            if (playingCard.rank == self.rank) {
                score += 16;
                NSLog(@"#########################################################");
                NSLog(@"Mached by rank");
                NSLog(@"self.matchedCardAttribute: %@",self.matchedCardAttribute );
            }
        }
    }
    NSLog(@"score: %i",score);
    return  score;
}

#pragma mark Static Methods
+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) {
        validSuits = @[@"♥", @"♦",@"♠",@"♣"];
    }
    return validSuits;
}

+ (NSArray *)rankStrings
{
    //everytime this method is called a nsarray is created!!!
    //can be create as constant, you have to use static
    static NSArray *rankStrings = nil;
    if (!rankStrings) {
        rankStrings = @[@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"J",@"Q",@"K"];
    }
    return rankStrings;
}

+ (NSString *)matchedAttribute:(NSString*)attribute
{
    static  NSString * matchedCardsAttribute = nil;
    matchedCardsAttribute = attribute;
    return matchedCardsAttribute;
}

@end
