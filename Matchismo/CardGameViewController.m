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
@end

@implementation CardGameViewController

//- (Deck *) deck
//{
//    if (!_deck) {
//        _deck = [[PlayingCardDeck alloc]init];
//    }
//    return  _deck;
//}

- (IBAction)newGame {
    //[self setCardButtons:<#(NSArray *)#>]
    //elimino juego anterior
    self.game = nil;
    //creo nuevo juego
    [self game];
    [self updateUI];
    
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
        //[cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        //view attributes of the card
        cardButton.selected = card.isFaceUp;
        cardButton.enabled  = !card.isUnplayable;
        cardButton.alpha    = card.isUnplayable ? 0.3: 1.0;
    }
    //this should be set in the game part, because we don't know the game
    //just one card shouldn't add score
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    //verify if not nil, is that a problem?
    self.machedCardsLabel.text = [NSString stringWithFormat:@"Flipped up %@",self.flipedCard.contents];
}


- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d",self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender
{//  sender.selected = !sender.isSelected;
    
    //the price to play that selected card
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    self.flipedCard = [self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    NSLog(@"self.flipedCard: %@",self.flipedCard.contents);
    
    self.flipCount++;
    [self updateUI];
    
}

- (void)setMachedCards:(NSString *)machedCards{
    
}



@end
