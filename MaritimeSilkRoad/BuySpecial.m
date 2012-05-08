//
//  BuySpecial.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BuySpecial.h"
#import "AI.h"
#import "Phase1.h"

@implementation BuySpecial

-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseASpecialFromPool];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseASpecialFromPool];
            [self handle];
        }
    }
    
}


-(void) handle {
    DLog(@"%d", _gameBoard.chosenOption);
    GameState *next;

    
    //    [_gameBoard.pool fetchAToken:_gameBoard.chosenOption];
    //    [[_gameBoard currentPlayer] loadGoodToShip:_gameBoard.chosenOption atIndex:((_gameBoard.remainingTurns - 1) / _gameBoard.playerCount)];    
    //    
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    
    [_observer.stateStack change:[[[Phase1 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
}



-(void) exit {
    
}

@end
