//
//  TakeCard.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TakeCard.h"
#import "Phase2.h"
@implementation TakeCard


-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);
    
    if (_gameBoard.remainingTurns > 0) {
        [self handle];
    }


}


-(void) handle {
    
    if (![self checkForWin]) {
        for (int i = 0; i < 2; i++) {
			GoodTypeEnum good = [_gameBoard.pool fetchAGood];
			DLog(@"player %@ got good card %d", [_gameBoard currentPlayer], good);
			[[_gameBoard currentPlayer] addCardToHand:good];
        }
        [_gameBoard nextPlayer];
        _gameBoard.remainingTurns--;
        
        [_gameBoard.stateStack change:[[[Phase2 alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];    
    };
    
}

-(bool) checkForWin {
    return (_gameBoard.pool.remainingCards <= 0);
}

-(void) exit {
    
}

@end
