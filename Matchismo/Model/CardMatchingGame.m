//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andres Kwan on 3/5/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.


#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray * cards;
@property (nonatomic) int                     score;
@property (strong,nonatomic) NSArray * matchedCards;

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

//I'll give to this card another name
//twoCardGame
//takes one card
//set the state in the playing deck
//
- (void)flipCardAtIndex:(NSUInteger)index{
    [self twoCardGame:index];
}

//- (NSString *)flipCardAtIndex:(NSUInteger)index{
//    return [self twoCardGame:index];
//}
//- (void)threeCardGame:(NSArray){
    
//}

-(NSString *)twoCardGame:(NSUInteger)index{

    //identify the card in the set of cards being played
    Card *card = [self cardAtIndex:index];
    //NSString * gameStateString = [NSString stringWithFormat:@"Flipped up %@", card.contents];
    NSString * gameStateString = [NSString stringWithFormat:@"Carta girada %@", card.contents];
    
 
        //what makes a card unplayable??? NO means playable
        //card can be played?
        if (!card.isUnplayable) {
            //iterate over all playing cards
            for (Card *otherCard in self.cards) {
                //playing with just one deck of cards
                //that is why card can't be equal to otherCard
                //to avoid to hava a match with the same card
                if (card != otherCard) {
                    //otherCard.isFaceUp
                    //  the card has been fliped and contents is visible
                    //!otherCard.isUnplayable
                    //  NO - has not beeing matched yet, you can play with it
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                                otherCard.unpleyable = YES;
                                card.unpleyable = YES;
                                self.score += matchScore * MATCH_BONUS;
                                NSLog(@"MATCH_BONUS: %d", MATCH_BONUS);
                                //gameStateString = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, MATCH_BONUS];
                                gameStateString = [NSString stringWithFormat:@"%@ & %@ (%d pts)", card.contents, otherCard.contents, MATCH_BONUS];
                                NSLog(@"%@",gameStateString);
                        }else{
                            //TWO CARD GAME
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            NSLog(@"MISMATCH_PENALTY: %d",MISMATCH_PENALTY);
                            //gameStateString = [NSString stringWithFormat:@"%@ & %@ Don't match! - %d", card.contents, otherCard.contents, MISMATCH_PENALTY];
                            gameStateString = [NSString stringWithFormat:@"%@ & %@ (-%d pts)", card.contents, otherCard.contents, MISMATCH_PENALTY];
                            NSLog(@"%@",gameStateString);
                        }
                    }
                    //NSLog(@"otherCard not matched: %@: ", otherCard.contents);
                }
            }
            self.score -= FLIP_COST;
            NSLog(@"FLIP_COST: %d",FLIP_COST);
            //for first time
            //set it as faceUp = YES
            //this card become one the otherCard whit this state set
            card.faceUp = !card.isFaceUp;
            //
            NSLog(@"%@",gameStateString);   
        }
    return gameStateString;
}



@end
