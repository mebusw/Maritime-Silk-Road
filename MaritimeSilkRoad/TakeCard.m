//
//  TakeCard.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TakeCard.h"
#import "Phase2.h"
#import "Player.h"


@implementation TakeCard


-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        [self handle];
    }


}


-(void) handle {
    
    
    for (int i = 0; i < 57; i++) {
        GoodTypeEnum good = [_gameBoard.pool fetchAGood];
        if (kGoodNone == good) {
            break;
        }
        DLog(@"player %@ got good card %d", [_gameBoard currentPlayer], good);
        [[_gameBoard currentPlayer] addCardToHand:good];
    }
    if ([self checkForWin]) {
        
        [_observer displayFinalScore];
        
        
    } else {
        [_gameBoard nextPlayer];
        _gameBoard.remainingTurns--;
        
        [_gameBoard.stateStack change:[[[Phase2 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];    
    
    }
    
    
}

-(bool) checkForWin {
    DLog(@"checkForWin");
    int maxCoin = 0;
    Player *winner;
    if (_gameBoard.pool.remainingCards <= 0) {
        for (Player *player in _gameBoard.players) {
            if (player.coin > maxCoin) {
                maxCoin = player.coin;
                winner = player;
            }
        }
        _gameBoard.winner = winner;
        return YES;
    } else {
        return NO;
    }
}

-(void) exit {
    
}

@end
