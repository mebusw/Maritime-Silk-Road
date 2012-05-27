//
//  Player.h
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-6.
//  Copyright 2011Äê __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "states.h"
#import <Foundation/Foundation.h>
#import "Pool.h"

@class GameLayer;

/**
 * An abstract class for game player.
 */
@interface Player : NSObject {
    int cardHand[GOOD_TYPE_COUNT];
	int ships[SHIP_COUNT];
	int specials[SPECIAL_TYPE_COUNT];
    id _delegate;
}


@property (nonatomic, retain) NSString *name;
@property (readonly) int* ships;
@property (readonly) int* specials;
@property (readonly) int* cardHand;
@property (nonatomic, assign) int coin;

- (id)initWithDelegate:(id) delegate;
- (bool) addCardToHand: (GoodTypeEnum)goodType;
- (bool) playCardOfType: (GoodTypeEnum)goodType quantity:(int)quantity;
- (bool) addSpecial: (SpecialTypeEnum)specialType;
- (bool) loadGoodToShip: (GoodTypeEnum)goodType atIndex:(NSUInteger)ship;
- (int) cardHandCount;

/** Abstract Methods */
- (void) chooseAGoodTypeFromPool:(Pool*)pool;

- (void) chooseToUseAbility;

- (void) chooseSpecialType;

- (void) chooseCardFromHand;

- (void) chooseCardFromMarket;

- (void) chooseActionForPhase1;

- (void) chooseAShipForAction11;

- (void) chooseASpecialForAction12FromPool:(Pool*)pool;

- (void) chooseActionForPhase2;
@end

/**
 * The AI player.
 */
@interface NPC : Player {

}
@property (nonatomic, retain) id AI;

@end

/**
 * The human player.
 */
@interface Human : Player {

}

@end
