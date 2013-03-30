//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Andres Kwan on 2/23/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//
//PlayingCardDeck is simply a subclass of Deck
//￼￼￼￼whose array of Cards contains all 52 PlayingCard combinations
//(i.e. it’s a deck of playing cards).
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

//you just provide a deck of cards
//but you don't know at this level what game it's going to be played
//you just need the deck
//so you could create another game!!! whit the same playingDeck

@implementation PlayingCardDeck 

//TODO:
//PlayingCardDeck's initializer
//
//Explanation:
//always called when a PlayingCardDeck is created
//
//return:
//id "object of any (unkown) class
//
//init is the constructor
- (id)init
{
    self = [super init];
    if(self){
        //every suit
        for (NSString *suit in [PlayingCard validSuits]) {
            //every rank
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard * card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}



@end