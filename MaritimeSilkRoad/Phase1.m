//
//  Phase1.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Phase1.h"
#import "Phase2.h"
#import "AI.h"
#import "ChangeGoodFromPool.h"

@implementation Phase1


-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseForPhase1];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseForPhase1];
            [self handle];
        }
    } else {
        [_observer.stateStack change:[[[Phase2 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
    }
    
}


-(void) handle {
    DLog(@"%d", _gameBoard.chosenOption);
    GameState *next;
    switch (_gameBoard.chosenOption) {
        case 0:
            next = [[[ChangeGoodFromPool alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease];
            break;
        case 1:
            next = [[[ChangeGoodFromPool alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease];            
            break;
        case 2:
            [_gameBoard nextPlayer];
            _gameBoard.remainingTurns -= 1;
            next = [[[Phase1 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease];
            break;
    }
    
//    [_gameBoard.pool fetchAToken:_gameBoard.chosenOption];
//    [[_gameBoard currentPlayer] loadGoodToShip:_gameBoard.chosenOption atIndex:((_gameBoard.remainingTurns - 1) / _gameBoard.playerCount)];    
//    

    
    [_observer.stateStack change:next];
}



-(void) exit {

}




@end
