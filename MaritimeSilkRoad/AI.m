//
//  AI.m
//  MaritimeSilkRoad
//
//  Created by  on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AI.h"


@implementation AI

GameBoard *_gameBoard;

-(id) initWithGameBoard:(GameBoard*) gameBoard {
    if (self = [super init]) {
        _gameBoard = gameBoard;
    }
    return self;
}

- (void) chooseAGoodFromPool {
    //stupid AI start >>>>
	GoodTypeEnum rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * GOOD_TYPE_COUNT);
    } while (_gameBoard.pool.token[rnd] <= 0);
    //stupid AI end <<<<
    
    _gameBoard.chosenOption = rnd;
}

-(void) chooseForPhase1 {
	//stupid AI start >>>>
	ActionEnum rnd;
    rnd = (NSInteger) (CCRANDOM_0_1() * 2);
    //stupid AI end <<<<
    
    _gameBoard.chosenOption = rnd;    
}


- (void) chooseAShipFromHand {
    //stupid AI start >>>>
	GoodTypeEnum rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * [_gameBoard currentPlayer].specials[kSpecialShip]);
    } while (_gameBoard.pool.token[rnd] <= 0);
    //stupid AI end <<<<
    
    _gameBoard.chosenOption = rnd;
}

-(void) chooseASpecialFromPool {
    //stupid AI start >>>>
	int rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * SPECIAL_TYPE_COUNT);
    } while (_gameBoard.pool.specialCards[rnd] <= 0);
    //stupid AI end <<<<
    
    _gameBoard.chosenOption = rnd;    

}

-(void) chooseForPhase2 {
	//stupid AI start >>>>
	ActionEnum rnd;
    rnd = (NSInteger) (CCRANDOM_0_1() * 1);
    //stupid AI end <<<<
    
    _gameBoard.chosenOption = rnd;    
}

-(void) chooseToSell {
    //stupid AI start >>>>
	GoodTypeEnum rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * [_gameBoard currentPlayer].specials[kSpecialShip]);
    } while ([_gameBoard currentPlayer].ships[rnd] <= 0);
    int rndMarket = (NSInteger) (CCRANDOM_0_1() * MARKET_SIZE);
    //stupid AI end <<<<
    
    _gameBoard.chosenFrom = rnd;
    //TODO
    _gameBoard.chosenOption = 1;
    _gameBoard.chosenTo = rndMarket;
}


@end
