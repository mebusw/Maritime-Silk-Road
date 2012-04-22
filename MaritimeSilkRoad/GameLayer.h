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
#import "GameBoard.h"


@class ShipsPanel;
@class GameState;

@interface GameLayer : CCLayer {
	int _loadGoodsTurns;
    int _phaseTurns;
    int _chosenShip;
	
	CCLabelTTF *labelDeck;
	CCLabelTTF *labelSpecials;
	CCLabelTTF *labelYourCoin;
	CCLabelTTF *labelYourSpecials;
	CCLabelTTF *lableYourShips[SHIP_COUNT];
	CCLabelTTF *labelTokens[GOOD_TYPE_COUNT];
    CCLabelTTF *labelPlayers[MAX_PLAYER];
    ShipsPanel *shipsPanel;
    HandMarketPanel *handMarketPanel;

    
    GameBoard *_gameBoard;
    GameState *_stateHandler;
    int _playerCount;
    Player *_activePlayer;
}
@property BOOL isDialoging; //if dialog is open, then no need to schedule for next state
@property GameStateEnum gameState;



+(CCScene *) sceneWithPlayerNumber: (NSUInteger) playerNbr;
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
