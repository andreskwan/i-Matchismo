//
//  GameResult.m
//  Matchismo
//
//  Created by Andres Kwan on 4/1/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic)NSDate *start;
@property (readwrite, nonatomic)NSDate *end;

@end


@implementation GameResult

//designed initilizer
-(id)init
{
    self = [super init];
    if (self){
        _start = [NSDate date];
        _end   = _start;
    }
}

@end
