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

- (void) chooseAGoodType {
    //stupid AI start >>>>
	GoodTypeEnum rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * GOOD_TYPE_COUNT);
    } while (_gameBoard.pool.token[rnd] <= 0);
    //stupid AI end <<<<
    
    _gameBoard.chosenGoodType = rnd;
}

@end
