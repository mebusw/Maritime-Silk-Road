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

-(void) enter {
    DLog(@">>>");
}

-(void) handle {
    DLog(@"");
    
    _gameBoard.pool = [[Pool alloc] init];
    _gameBoard.market = [[Market alloc] init];
    
	// create Human player
	_gameBoard.players = [[NSMutableArray alloc] initWithCapacity:_gameBoard.playerCount];
	Human *human = [[Human alloc] initWithDelegate:self];
	[_gameBoard.players addObject:human];
	
	// create AI players
	for (int i = 1; i < _gameBoard.playerCount; i++) {
		NPC *npc = [[NPC alloc] initWithDelegate:self];
		[_gameBoard.players addObject:npc];
	}
	
	// distribute 3 good cards and 2 ships to every player
	for (Player *player in _gameBoard.players) {
		for (int i = 0; i < 3; i++) {
			GoodTypeEnum good = [_gameBoard.pool fetchAGood];
			DLog(@"player %@ got good card %d", player, good);
			[player addCardToHand:good];
		}
		for (int i = 0; i < 2; i++) {
            [_gameBoard.pool fetchASpecial:kSpecialShip];
			[player addSpecial:kSpecialShip];			
		}
	}
    
	// distribute 6 good cards to market
	for (int i = 0; i < MARKET_SIZE; i++) {
		GoodTypeEnum good = [_gameBoard.pool fetchAGood];
		DLog(@"market got good card %d",  good);
        [_gameBoard.market changeGood:good atIndex:i];
	}
    
    
    _gameBoard.remainingTurns = 2 * _gameBoard.playerCount;
    [_observer.stateStack change:[[[LoadGoods alloc] initWithObserver:_observer gameBoard:_gameBoard] autorelease]];
}

@end
