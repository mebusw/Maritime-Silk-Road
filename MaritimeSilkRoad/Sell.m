//
//  Sell.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Sell.h"
#import "AI.h"
#import "Phase2.h"
#import "Phase1.h"

@implementation Sell

-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseToSell];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseToSell];
            [self handle];
        }
    }
    
}


-(void) handle {
    
    [[_gameBoard currentPlayer] playCardOfType:_gameBoard.chosenFrom quantity:_gameBoard.chosenOption];
    [_gameBoard.market changeGood:_gameBoard.chosenFrom atIndex:_gameBoard.chosenTo];
    

    
    [_gameBoard currentPlayer].coin += _gameBoard.chosenOption * [_gameBoard.market countOfGood:_gameBoard.chosenFrom];
    
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    [_gameBoard.stateStack change:[[[Phase2 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
    
}



-(void) exit {
    
}

@end
