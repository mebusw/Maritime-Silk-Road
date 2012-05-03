//
//  LoadGoods.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadGoods.h"
#import "ChangeGood.h"
#import "AskingForLoadGood.h"


@implementation LoadGoods


-(void) enter {
    DLog(@"%d", _gameBoard.remainingTurns);

    _gameBoard.isDialogging = NO;
    _gameBoard.isInfoboxing = NO;
    
    [self lookAtNewTurn];
}


-(void) handle:(GameLayer*)observer gameBoard:(GameBoard*)gameBoard {
    DLog(@"");
    _observer = observer;
    _gameBoard = gameBoard;
    
}

-(void) lookAtNewTurn {
    if (_gameBoard.remainingTurns > 0) {
        _gameBoard.isDialogging = YES;
        
        [_observer.stateStack push:[[AskingForLoadGood alloc] initWithObserver:_observer gameBoard:_gameBoard]];
        
        [_observer chooseAGoodType];
    } else {
        [_observer.stateStack change:[[[ChangeGood alloc] init] autorelease]];
    }
    
}


-(void) exit {
    DLog(@"");
}




@end
