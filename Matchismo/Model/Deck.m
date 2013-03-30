//
//  Deck.m
//  Matchismo
//
//  Created by Andres Kwan on 2/19/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

//is not the same if I want to despose the cards and after the cards
//has been played deal all left over again.

@implementation Deck

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        //self.cards initilized to nil
        //sending messages to nil does nothing
        [self.cards insertObject:card atIndex:0];
    }else if (card){
            [self.cards addObject:card];
    }else{
        NSLog(@"card is nil, can't be stored in the array!!");
    }
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    if (self.cards.count) {
        //NSLog(@"self.cards.count: %i", self.cards.count);
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        if (self.cards.count != 0) {
            [self.cards removeObjectAtIndex:index];
            //NSLog(@"self.cards.count: %i", self.cards.count);
        }
    
    }
    return randomCard;
}

@end
