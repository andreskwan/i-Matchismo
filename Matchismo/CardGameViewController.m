//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andres Kwan on 2/17/13.
//  Copyright (c) 2013 Andres Kwan O. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic)     IBOutlet UILabel        *flipsLabel;
@property (nonatomic)           int                     flipCount;

//@property (strong, nonatomic) Deck *deck;

@property (strong, nonatomic)   CardMatchingGame        *game;
@property (weak, nonatomic)     IBOutlet UILabel        *scoreLabel;
@property (strong, nonatomic)   IBOutlet UILabel        *machedCardsLabel;

@property (nonatomic)           NSString                *machedCards;
@property (weak, nonatomic)     Card                    *flipedCard;

@property (strong, nonatomic)   IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic)   NSString                *gameStateString;
@property (strong, nonatomic)   IBOutlet UISegmentedControl *gameSelector;
@property (nonatomic)           NSUInteger              *chooseGame;
@end

@implementation CardGameViewController

#define TWO_CARD_MODE   2
#define THREE_CARD_MODE 3
//- (Deck *) deck
//{
//    if (!_deck) {
//        _deck = [[PlayingCardDeck alloc]init];
//    }
//    return  _deck;
//}

- (IBAction)newGame {
    //[self setCardButtons:]
    //elimino juego anterior
    self.game = nil;
    self.flipCount = 0;
        //creo nuevo juego
    [self game];
    [self updateUI];
    //self.machedCardsLabel.text = @"New game started";
    self.machedCardsLabel.text = @"Iniciar nuevo juego";
//    [self.gameSelector setEnabled:YES];

    
}


- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:self.cardButtons.count
                         usingDeck:[[PlayingCardDeck alloc]init]];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    //set button titles
    _cardButtons = cardButtons;
    
    //commented CardMachingGame handle the initialization of the buttons
    //    for (UIButton *cardButton in self.cardButtons) {
    //        Card *card = [self.deck drawRandomCard];
    //        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    //    }
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        //obtain the card being played of flipped
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        //change the state of the card
        //if not set keep displaying card set value in the view
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        //if not set second card selected do not display its contents
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        //view attributes of the card
        cardButton.selected = card.isFaceUp;
        cardButton.enabled  = !card.isUnplayable;
        cardButton.alpha    = card.isUnplayable ? 0.3: 1.0;
    }
    //this should be set in the game part, because we don't know the game
    //just one card shouldn't add score
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.scoreLabel.text = [NSString stringWithFormat:@"Puntaje: %d", self.game.score];
    //verify if not nil, is that a problem?
    //self.machedCardsLabel.text = [NSString stringWithFormat:@"Flipped up %@",self.flipedCard.contents];
    NSLog(@"self.gameStateString: %@",self.gameStateString);
    self.machedCardsLabel.text = self.gameStateString;
}

//view modification
- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    //self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.flipsLabel.text = [NSString stringWithFormat:@"Giros: %d", self.flipCount];
    NSLog(@"flips updated to %d",self.flipCount);
}

//game behavior
- (IBAction)flipCard:(UIButton *)sender
{//  sender.selected = !sender.isSelected;
    
    //Game
    //the price to play that selected card
    //original game
//    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    //
//    self.gameStateString = [self.game twoCardGame:[self.cardButtons indexOfObject:sender]];
    self.gameStateString = [self.game twoCardGame:[self.cardButtons indexOfObject:sender]];
    //this is in the view
    self.flipedCard = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    NSLog(@"self.flipedCard: %@",self.flipedCard.contents);
    
    //
    self.flipCount++;
    [self updateUI];
    
}

- (void)setMachedCards:(NSString *)machedCards{
    
}

- (IBAction)selectedGame:(id)sender {
    NSLog(@"before");
    if (self.gameSelector.selectedSegmentIndex == 0) {        
        
    }
    if (self.gameSelector.selectedSegmentIndex == 1) {
        NSLog(@"selected two cards");
        [self.gameSelector removeSegmentAtIndex:2 animated:YES];
        //[self.gameSelector removeSegmentAtIndex:0 animated:YES];
        self.game.matchingCardGameMode = TWO_CARD_MODE;
    
    }
    if (self.gameSelector.selectedSegmentIndex == 2) {    
        //
        [self.gameSelector removeSegmentAtIndex:1 animated:YES];
        
//        NSLog(@"selected three cards");
        
        //[self.gameSelector removeSegmentAtIndex:0 animated:YES];
        NSLog(@"selected three cards");
        self.game.matchingCardGameMode = THREE_CARD_MODE;
    }
    
    NSLog(@"UISelectedSegment setEnalbe: No");
    for (NSUInteger i = 0; i < self.gameSelector.numberOfSegments; i++) {
        [self.gameSelector setEnabled:NO forSegmentAtIndex:i];
            NSLog(@"UISelectedSegment setEnalbe: No atIndex: %i",i);
    }
}


@end
