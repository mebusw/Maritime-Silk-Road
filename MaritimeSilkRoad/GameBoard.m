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
@synthesize chosenAction, chosenMarket, chosenOption, chosenSpecialType, chosenTo, chosenFrom;
@synthesize remainingTurns, isDialogging, isInfoboxing;

-(void) buildGameBoardWithPlayerNumber: (NSUInteger) playerNbr {
    playerCount = playerNbr;
    startPlayerIndex = (int) (CCRANDOM_0_1() * playerCount);
    activePlayerIndex = startPlayerIndex;

}


-(int) nextPlayer {
    activePlayerIndex = (activePlayerIndex + 1) % [players count];
    return activePlayerIndex;
}

-(Player*) currentPlayer {
    return [players objectAtIndex:activePlayerIndex];
}

- (void)prepare {
    DLog(@"");
    pool = [[Pool alloc] init];
    market = [[Market alloc] init];
    
	// create Human player
	players = [[NSMutableArray alloc] initWithCapacity:playerCount];
	Human *human = [[Human alloc] initWithDelegate:self];
	[players addObject:human];
	
	// create AI players
	for (int i = 1; i < playerCount; i++) {
		NPC *npc = [[NPC alloc] initWithDelegate:self];
		[players addObject:npc];
	}
	
	// distribute 3 good cards and 2 ships to every player
	for (Player *player in players) {
		for (int i = 0; i < 3; i++) {
			GoodTypeEnum good = [pool fetchAGood];
			DLog(@"player %@ got good card %d", player, good);
			[player addCardToHand:good];
		}
		for (int i = 0; i < 2; i++) {
            [pool fetchASpecial:kSpecialShip];
			[player addSpecial:kSpecialShip];			
		}
	}
    
	// distribute 6 good cards to market
	for (int i = 0; i < MARKET_SIZE; i++) {
		GoodTypeEnum good = [pool fetchAGood];
		DLog(@"market got good card %d",  good);
        [market changeGood:good atIndex:i];
	}
}

@end
