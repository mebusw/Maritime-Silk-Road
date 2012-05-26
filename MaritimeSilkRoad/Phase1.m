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
#import "BuySpecial.h"
#import "JustPass.h"

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
        _gameBoard.remainingTurns = _gameBoard.playerCount;
        [_gameBoard.stateStack change:[[[Phase2 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
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
            next = [[[BuySpecial alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease];            
            break;
        case 2:
            next = [[[JustPass alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]; 
            break;
    }
    
   
    [_gameBoard.stateStack change:next];
}



-(void) exit {

}




@end
