//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andres Kwan on 3/5/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"    

@interface CardMatchingGame : NSObject

@property (assign,nonatomic) NSUInteger         matchingCardGameMode;

//designated initializer 
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (NSString *)twoCardGame:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

//has not setter only getter
@property (nonatomic,readonly) int score;

@end
