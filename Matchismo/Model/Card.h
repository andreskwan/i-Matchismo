//
//  Card.h
//  Matchismo
//
//  Created by Andres Kwan on 2/19/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic)NSString * contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;

//TODO what makes that a card is playable or not?
@property (nonatomic, getter = isUnplayable) BOOL unpleyable;

- (int)match:(NSArray *)otherCards; 



@end
