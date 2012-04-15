//
//  GameBoard.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBoard.h"


@implementation GameBoard

@synthesize pool, players, market, activePlayerIndex;


-(int) nextPlayer {
    activePlayerIndex = (activePlayerIndex + 1) % [players count];
    return activePlayerIndex;
}

@end
