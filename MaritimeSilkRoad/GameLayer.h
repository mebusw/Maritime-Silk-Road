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

}
@property BOOL isDialoging; //if dialog is open, then no need to schedule for next state
@property GameStateEnum gameState;



+(CCScene *) sceneWithPlayerNumber: (NSUInteger) playerNbr;
- (void) createViews;
- (void) updateViews;
- (id) initWithPlayerNumber: (NSUInteger) playerNbr;
- (void) loadGoods;
- (void) phase1;
- (void) p11ChangeGood;
- (void) p12BuySpecial;

- (void) chooseAGoodType;


-(void) didChooseAShip:(int)shipIndex;
-(void) didChooseASpecial: (NSNumber *)num;

-(void) handleRequest; 
-(void) changeState:(GameState*) newState;

@end
