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
#import "StateStack.h"
#import "GameState.h"
#import "GameBoard.h"
#import "PlayerInputProtocol.h"

@class ShipsPanel;
@class GameState;
@class StateStack;

@interface GameLayer : CCLayer <PlayerInputProtocol>{

}
@property BOOL isDialoging; //if dialog is open, then no need to schedule for next state


+(CCScene *) sceneWithPlayerNumber: (NSUInteger) playerNbr;


- (void) createViews;
- (void) updateViews;
- (id) initWithPlayerNumber: (NSUInteger) playerNbr;



-(void) handleRequest; 

@end
