//
//  GameLayer.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Pool.h"
#import "Player.h"
#import "Dialog.h"
#import "ShipsPanel.h"
#import "HandMarketPanel.h"
#import "GameState.h"

@class ShipsPanel;
@class GameState;

@interface GameLayer : CCLayer {
	int _loadGoodsTurns;
    int _phaseTurns;
    int _chosenShip;
	
	int market[MARKET_SIZE];
	CCLabelTTF *labelDeck;
	CCLabelTTF *labelSpecials;
	CCLabelTTF *labelYourCoin;
	CCLabelTTF *labelYourSpecials;
	CCLabelTTF *lableYourShips[SHIP_COUNT];
	CCLabelTTF *labelTokens[GOOD_TYPE_COUNT];
    CCLabelTTF *labelPlayers[MAX_PLAYER];
    ShipsPanel *shipsPanel;
    HandMarketPanel *handMarketPanel;
    Human *human;
    
    GameState* _stateHandler;
}
@property BOOL isDialoging; //if dialog is open, then no need to schedule for next state
@property GameStateEnum gameState;
@property (nonatomic, retain) Pool *pool;
@property (nonatomic, retain) Player *activePlayer;
@property (nonatomic, retain) NSMutableArray *players;
@property (readonly) int *market;
@property (readonly) int playerNbr;
@property (readonly) int activePlayerIndex;
@property (readonly) int startPlayerIndex;

+(CCScene *) sceneWithPlayerNumber: (NSUInteger) _playerNbr;
- (void) setupMenus;
- (id) initWithPlayerNumber: (NSUInteger) playerNbr;
- (void) loadGoods;
- (void) prepareGame;
- (void) phase1;
- (void) p11ChangeGood;
- (void) p12BuySpecial;
- (void) p13Pass;
- (void) phase2;
- (void) gameOver;

-(void) didChooseAShip: (NSNumber*) num;
-(void) didChooseASpecial: (NSNumber *)num;

-(void) handleRequest; 
-(void) changeState:(GameState*) newState;

@end
