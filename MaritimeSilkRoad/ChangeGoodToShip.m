//
//  ChangeGoodToShip.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChangeGoodToShip.h"
#import "AI.h"
#import "Phase1.h"

@implementation ChangeGoodToShip


-(void) enter {   
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseAShipFromHand];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseAShipFromHand];
            [self handle];
        }
    }
}

-(void) handle {
    int targetShip = _gameBoard.chosenOption;
    GoodTypeEnum newGood = _gameBoard.chosenFrom;
    GoodTypeEnum oldGood = _gameBoard.currentPlayer.ships[targetShip];
    DLog(@"want good %d to good %d on ship[%d]", newGood, oldGood, targetShip);    
    
    [_gameBoard.pool fetchAToken:newGood];
    [[_gameBoard currentPlayer] loadGoodToShip:newGood atIndex:targetShip];    
    [_gameBoard.pool putAToken:oldGood];

    
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    
    [_observer.stateStack change:[[[Phase1 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
}



-(void) exit {
    
}
@end
