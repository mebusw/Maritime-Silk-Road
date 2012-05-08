//
//  ChangeGood.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChangeGoodFromPool.h"
#import "ChangeGoodToShip.h"
#import "AI.h"


@implementation ChangeGoodFromPool

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
    }
}

-(void) handle {
    DLog(@"%d", _gameBoard.chosenOption);
    _gameBoard.chosenFrom = _gameBoard.chosenOption;
    
    [_observer.stateStack change:[[[ChangeGoodToShip alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
}



-(void) exit {
    
}
@end
