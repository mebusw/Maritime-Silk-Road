//
//  GameBoard.h
//  MaritimeSilkRoad
//
//  Created by  on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "Pool.h"
#import "Player.h"
#import "Market.h"
#import "StateStack.h"
#import "PlayerInputProtocol.h"

@class StateStack;

@interface GameBoard : NSObject {

}
@property (nonatomic, retain) StateStack* stateStack;

@property (nonatomic, retain) Pool* pool;
@property (nonatomic, retain) NSMutableArray* players;
@property (nonatomic, retain) Market* market;
@property (nonatomic, retain) Player* winner;


@property (nonatomic, readonly) int activePlayerIndex;
@property (nonatomic, readonly) int playerCount;
@property (nonatomic, readonly) int startPlayerIndex;
@property (nonatomic) int chosenMarket;
@property (nonatomic) int chosenAction;
@property (nonatomic) int chosenOption;
@property (nonatomic) int chosenFrom;
@property (nonatomic) int chosenTo;
@property (nonatomic) int chosenSpecialType;
@property (nonatomic) int remainingTurns;

@property (nonatomic) BOOL isDialogging;
@property (nonatomic) BOOL isInfoboxing;

-(int) nextPlayer;
-(Player*) currentPlayer;
-(void) buildGameBoardWithPlayerNumber: (NSUInteger) playerNbr;

- (void)prepare;
- (void) startGameLogic:(id<PlayerInputProtocol>) gameLayer;

@end
