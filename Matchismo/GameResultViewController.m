//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Andres Kwan on 4/1/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"
@interface GameResultViewController ()
@property (strong, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

- (void)updateUI
{
    NSString * displayText = @"";
    for (GameResult * result in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %@g)\n", result.score,
                       result.end, round(result.duration)];
    }
    self.display.text = displayText;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void)setup
{
//    initialization that can't wait until viewDidLoad
}

-(void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}


@end
