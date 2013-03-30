//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andres Kwan on 3/5/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.


#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray * cards;
@property (nonatomic) int score;
@end

@implementation CardMatchingGame

//this game will use just this amount of cards "count"
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }else{
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}


- (Card *) cardAtIndex:(NSUInteger)index
{
    //just validate that the index is valid, not if is the same?
    return (index < self.cards.count) ? self.cards[index]: nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    //what makes a card unplayable??? NO means playable 
    if (!card.isUnplayable) {
        for (Card *otherCard in self.cards) {
//            if (card != otherCard && (otherCard.isFaceUp && !otherCard.isUnplayable)) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                int matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    otherCard.unpleyable = YES;
                    card.unpleyable = YES;
                    self.score += matchScore * MATCH_BONUS;
                }else{
                    otherCard.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                }
            }
            self.score -= FLIP_COST;    
        }
        card.faceUp = !card.isFaceUp;
    }
}
@end
