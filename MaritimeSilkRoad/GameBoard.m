//
//  GameBoard.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBoard.h"
#import "Preparing.h"

@implementation GameBoard

#define INIT_GOOD_AMOUNT 3
#define INIT_SHIP_AMOUNT 2

@synthesize pool, players, market, stateStack, winner;
@synthesize playerCount, startPlayerIndex, activePlayerIndex;
@synthesize chosenAction, chosenMarket, chosenOption, chosenSpecialType, chosenTo, chosenFrom;
@synthesize remainingTurns, isDialogging, isInfoboxing;


-(int) nextPlayer {
    activePlayerIndex = (activePlayerIndex + 1) % [players count];
    return activePlayerIndex;
}

-(Player*) currentPlayer {
    return [players objectAtIndex:activePlayerIndex];
}

- (void) prepareForPlayerNumber: (NSUInteger) playerNbr {
    DLog(@"");
    pool = [[Pool alloc] init];
    market = [[Market alloc] init];
    
    [self buildGameBoardWithPlayerNumber:playerNbr];
    [self prepareGoodAndShipToEachPlayer];
    [self prepareGoodsToMarket];
}

-(void) buildGameBoardWithPlayerNumber: (NSUInteger) playerNbr {
    playerCount = playerNbr;
    startPlayerIndex = (int) (CCRANDOM_0_1() * playerCount);
    activePlayerIndex = startPlayerIndex;
    
	// create Human player
	players = [[NSMutableArray alloc] initWithCapacity:playerCount];
	Human *human = [[Human alloc] initWithDelegate:self];
	[players addObject:human];
	
	// create AI players
	for (int i = 1; i < playerCount; i++) {
		NPC *npc = [[NPC alloc] initWithDelegate:self];
		[players addObject:npc];
	}
}

- (void)prepareGoodAndShipToEachPlayer {
    for (Player *player in players) {
		for (int i = 0; i < INIT_GOOD_AMOUNT; i++) {
			GoodTypeEnum good = [pool fetchAGood];
			DLog(@"player %@ got good card %d", player, good);
			[player addCardToHand:good];
		}
		for (int i = 0; i < INIT_SHIP_AMOUNT; i++) {
            [pool fetchASpecial:kSpecialShip];
			[player addSpecial:kSpecialShip];			
		}
        player.coin = 11;
	}
}

- (void)prepareGoodsToMarket {
	// distribute 6 good cards to market
    for (int i = 0; i < MARKET_SIZE; i++) {
		GoodTypeEnum good = [pool fetchAGood];
		DLog(@"market got good card %d",  good);
        [market changeGood:good atIndex:i];
	}
}



-(void) startGameLogic:(id<PlayerInputProtocol>) gameLayer {
    stateStack = [[StateStack alloc] init];
    [stateStack push:[[Preparing alloc] initWithObserver:gameLayer gameBoard:self]];

}

@end
