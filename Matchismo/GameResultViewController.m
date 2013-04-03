//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Andres Kwan on 4/1/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()
@property (strong, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

-(void)setup
{
    
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
