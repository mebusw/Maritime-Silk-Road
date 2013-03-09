//
//  LoadGoods.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadGoods.h"
#import "Player.h"
#import "AI.h"
#import "Phase1.h"

@implementation LoadGoods


-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);

    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseAGoodFromPool];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseAGoodFromPool];
            [self handle];
        }
    } else {
        _gameBoard.remainingTurns = _gameBoard.playerCount;
        [_gameBoard.stateStack change:[[[Phase1 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
    }

}


-(void) handle {
    DLog(@"%d", _gameBoard.chosenOption);
    [_gameBoard.pool fetchAToken:_gameBoard.chosenOption];
    
    //TODO should load to an empty ship
    [[_gameBoard currentPlayer] loadGoodToShip:_gameBoard.chosenOption atIndex:((_gameBoard.remainingTurns - 1) / _gameBoard.playerCount)];    
    
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    
    

    [_gameBoard.stateStack change:[[[LoadGoods alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
}



-(void) exit {
    DLog(@"");
}




@end
