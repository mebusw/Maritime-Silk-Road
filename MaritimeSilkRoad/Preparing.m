//
//  Setup.m
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Preparing.h"
#import "LoadGoods.h"
#import "Player.h"

@implementation Preparing



-(void) handle:(GameLayer*)observer gameBoard:(GameBoard*)gameBoard {
    DLog(@"");
    
    gameBoard.pool = [[Pool alloc] init];
    gameBoard.market = [[Market alloc] init];
    
	// create Human player
	gameBoard.players = [[NSMutableArray alloc] initWithCapacity:gameBoard.playerCount];
	Human *human = [[Human alloc] initWithDelegate:self];
	[gameBoard.players addObject:human];
	
	// create AI players
	for (int i = 1; i < gameBoard.playerCount; i++) {
		NPC *npc = [[NPC alloc] initWithDelegate:self];
		[gameBoard.players addObject:npc];
	}
	
	// distribute 3 good cards and 2 ships to every player
	for (Player *player in gameBoard.players) {
		for (int i = 0; i < 3; i++) {
			GoodTypeEnum good = [gameBoard.pool fetchAGood];
			DLog(@"player %@ got good card %d", player, good);
			[player addCardToHand:good];
		}
		for (int i = 0; i < 2; i++) {
            [gameBoard.pool fetchASpecial:kSpecialShip];
			[player addSpecial:kSpecialShip];			
		}
	}
    
	// distribute 6 good cards to market
	for (int i = 0; i < MARKET_SIZE; i++) {
		GoodTypeEnum good = [gameBoard.pool fetchAGood];
		DLog(@"market got good card %d",  good);
        [gameBoard.market changeGood:good atIndex:i];
	}
    
    

    [observer.stateStack change:[[[LoadGoods alloc] init] autorelease]];
}

@end
