//
//  AskingForLoadGood.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AskingForLoadGood.h"

@implementation AskingForLoadGood


-(void) enter {
    DLog(@"");
}


-(void) handle:(GameLayer*)observer gameBoard:(GameBoard*)gameBoard {
    DLog(@"");
    _observer = observer;
    _gameBoard = gameBoard;
    
    _gameBoard.isDialogging = NO;
    DLog(@"%d", _gameBoard.chosenGoodType);
    [_gameBoard.pool fetchAToken:_gameBoard.chosenGoodType];
    [[_gameBoard currentPlayer] loadGoodToShip:_gameBoard.chosenGoodType atIndex:((_gameBoard.remainingTurns - 1) / _gameBoard.playerCount)];    
      
    [_gameBoard nextPlayer];
    _gameBoard.remainingTurns -= 1;
    
    [observer.stateStack pop];
    
}

-(void) exit {
    DLog(@"");
}

@end
