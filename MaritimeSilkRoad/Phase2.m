//
//  Phase2.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Phase2.h"
#import "AI.h"
#import "Phase1.h"
#import "TakeCard.h"
#import "Sell.h"

@implementation Phase2

-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        if ([_gameBoard.currentPlayer isKindOfClass:[Human class]]) {
            [_observer chooseForPhase2];
        } else {
            AI *ai = [[[AI alloc] initWithGameBoard:_gameBoard] autorelease];
            [ai chooseForPhase2];
            [self handle];
        }
    } else {
        _gameBoard.remainingTurns = _gameBoard.playerCount;
        [_gameBoard.stateStack change:[[[Phase1 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
    }
    
}

-(void) handle {
    DLog(@"%d", _gameBoard.chosenOption);
    GameState *next;
    switch (_gameBoard.chosenOption) {
        case 0:
            next = [[[Sell alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease];
            break;
        case 1:
            next = [[[TakeCard alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease];            
            break;
    }
    [_gameBoard.stateStack change:next];
} 
@end
