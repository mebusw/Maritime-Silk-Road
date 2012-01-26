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
}

@property (nonatomic, retain) NSString *name;
@property (readonly) int* ships;
@property (readonly) int* specials;
@property (readonly) int* cardHand;
@property (nonatomic, assign) int coin;

- (bool) addCardToHand: (GoodTypeEnum)goodType;
- (bool) playCardofType: (GoodTypeEnum)goodType;
- (bool) addSpecial: (SpecialTypeEnum)specialType;
- (bool) loadGoodToShip: (GoodTypeEnum)goodType atIndex:(NSUInteger)ship;
- (int) cardHandCount;

/**
 * @abstract
 * open dialog to choose the type of good when load a token to ship
 */
- (void) chooseAGoodType:(id)delegate pool:(Pool*)pool;
 
/**
 * @abstract
 * open dialog to choose to use a special ability or not
 */
- (void) chooseToUseAbility: (id)delegate;

/**
 * @abstract
 * open dialog to choose the type of special in pool
 */
- (void) chooseSpecialType: (id)delegate;

/**
 * @abstract
 * open dialog to choose the index of card in hand
 */
- (void) chooseCardFromHand: (id)delegate;

/**
 * @abstract
 * open dialog to choose the index of card in market (0~5)
 */
- (void) chooseCardFromMarket: (id)delegate;

/**
 * @abstract
 * open dialog to choose the action of phase 1 (0~2)
 */
- (void) chooseActionForPhase1: (id)delegate;

/**
 * @abstract
 * open dialog to choose for changing a good  (0~n)
 */
- (void) chooseAShipForAction11: (id)delegate;

/**
 * @abstract
 * open dialog to choose the action of phase 2 (0~1)
 */
- (void) chooseActionForPhase2: (id)delegate;

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
@interface User : Player {

}

@end
