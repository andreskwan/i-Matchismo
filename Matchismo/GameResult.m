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

//name space the class, identify all_results_key for this one
#define ALL_RESULTS_KEY     @"GameReusults_ALL"
#define START_KEY           @"StartDate"
#define END_KEY             @"EndDate"
#define SCORE_KEY           @"Score"

#pragma mark - initializers
//designed initilizer
-(id)init
{
    self = [super init];
    if (self){
        _start = [NSDate date];
        _end   = _start;
    }
    return self;
}

//convenience initializer
-(id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end   = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}


- (void)synchronize
{
    //store game results in a dictionary
    //key unique identifier for game results
    //value a property list that allows to recreate game results
    NSMutableDictionary * mutableGameResultsFromUserDefaults =
    [[[NSUserDefaults standardUserDefaults]
      dictionaryForKey:ALL_RESULTS_KEY]
     mutableCopy];
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc]init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(id)asPropertyList
{
    return @{START_KEY :self.start, END_KEY :self.end, SCORE_KEY : @(self.score)};
}

+(NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc]init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult * result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return allGameResults;
    
}


-(NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}
@end
