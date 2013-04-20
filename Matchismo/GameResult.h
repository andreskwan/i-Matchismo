//
//  GameResult.h
//  Matchismo
//
//  Created by Andres Kwan on 4/1/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject
//can be read from the outside but not modified
@property (readonly,nonatomic)NSDate            *start;
@property (readonly,nonatomic)NSDate            *end;
@property (nonatomic)int                        score;

@property (readonly,nonatomic)NSTimeInterval    duration;

+(NSArray * )allGameResults;//of Game results

@end
