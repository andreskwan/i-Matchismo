//
//  Deck.h
//  Matchismo
//
//  Created by Andres Kwan on 2/19/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
