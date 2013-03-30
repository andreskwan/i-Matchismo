//
//  PlayingCard.h
//  Matchismo
//
//  Created by Andres Kwan on 2/22/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface PlayingCard : Card

@property (strong, nonatomic)NSString   *suit;
//same as weak?
@property (nonatomic)NSUInteger         rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
