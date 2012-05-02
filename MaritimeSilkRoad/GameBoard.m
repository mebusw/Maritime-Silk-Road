//
//  GameBoard.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBoard.h"


@implementation GameBoard

@synthesize pool, players, market;
@synthesize playerCount, startPlayerIndex, activePlayerIndex;
@synthesize chosenAction, chosenMarket, chosenGoodType, chosenSpecialType;
@synthesize remainingTurns, isDialogging, isInfoboxing;

- (id) initWithPlayerNumber: (NSUInteger) playerNbr {
    if (self = [super init]) {
        playerCount = playerNbr;
        startPlayerIndex = (int) (CCRANDOM_0_1() * playerCount);
        activePlayerIndex = startPlayerIndex;
    }
    
    return self;
}

-(int) nextPlayer {
    activePlayerIndex = (activePlayerIndex + 1) % [players count];
    return activePlayerIndex;
}

-(Player*) currentPlayer {
    return [players objectAtIndex:activePlayerIndex];
}


@end
