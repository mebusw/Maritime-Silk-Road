//
//  LoadGoods.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadGoods.h"
#import "ChangeGood.h"
#import "Player.h"
#import "AI.h"
        
@implementation LoadGoods


-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);

    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseAGoodType];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseAGoodType];
            [self handle];
        }
    } else {
        [_observer.stateStack change:[[[ChangeGood alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
    }

}


-(void) handle {
    DLog(@"%d", _gameBoard.chosenGoodType);
    [_gameBoard.pool fetchAToken:_gameBoard.chosenGoodType];
    [[_gameBoard currentPlayer] loadGoodToShip:_gameBoard.chosenGoodType atIndex:((_gameBoard.remainingTurns - 1) / _gameBoard.playerCount)];    
    
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    
    [_observer.stateStack change:[[[LoadGoods alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
}



-(void) exit {
    DLog(@"");
}




@end
