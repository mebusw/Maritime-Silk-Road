//
//  LoadGoods.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadGoods.h"
#import "ChangeGood.h"

@implementation LoadGoods


-(void) enter {
    _gameBoard.remainingTurns = 2 * _gameBoard.playerCount;
    _gameBoard.isDialogging = NO;
    _gameBoard.isInfoboxing = NO;
}


-(void) handle:(GameLayer*)observer gameBoard:(GameBoard*)gameBoard {
    DLog(@"");
    _observer = observer;
    _gameBoard = gameBoard;
    
    if (gameBoard.isDialogging) {
        [self afterDialog];
    } else if(gameBoard.isInfoboxing) {
        [self afterInfobox];
    } else {
        [self lookAtNewTurn];
    }
    
}

-(void) lookAtNewTurn {
    if (_gameBoard.remainingTurns > 0) {
        _gameBoard.isDialogging = YES;
        [_observer chooseAGoodType];
    } else {
        [_observer.stateStack change:[[[ChangeGood alloc] init] autorelease]];
    }
    
}

-(void) afterDialog {
    _gameBoard.isDialogging = NO;
    DLog(@"%d", _gameBoard.chosenGoodType);
    [_gameBoard.pool fetchAToken:_gameBoard.chosenGoodType];
    [[_gameBoard currentPlayer] loadGoodToShip:_gameBoard.chosenGoodType atIndex:((_gameBoard.remainingTurns - 1) / _gameBoard.playerCount)];    
    

    
//    InfoBox *ib = [InfoBox infoBox:STR(@"%@ chooses good type %d", _activePlayer.name, goodType)];
//    [ib show:self];
//    gameBoard.isInfoboxing = NO;
//    
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    
    [self lookAtNewTurn];
    
}

-(void) afterInfobox {
    _gameBoard.isInfoboxing = YES;
    
}




@end
