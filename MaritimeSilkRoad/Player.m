//
//  GameBoard.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Dialog.h"
#import "Pool.h"

#define Z_MOST_FRONT    1000
#define Z_MOST_BACK     -1000
#define DIALOG_GOODS   	100
#define DIALOG_ACTIONS 	101
#define DIALOG_YESNO	102

@implementation Player

@synthesize coin;
@synthesize name;

- (int*) cardHand {
    return cardHand;
}
- (int*) ships {
    return ships;
}
- (int*) specials {
    return specials;
}


- (id)init {
    if (self = [super init]) {
		coin = 0;
        for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
            cardHand[i] = 0;
        }
        for (int i = 0; i < SPECIAL_TYPE_COUNT; i++) {
            specials[i] = 0;
        }
	}
    return self;
}

- (void) dealloc {
    DLog(@"");
    [super dealloc];
}

- (bool) addCardToHand: (GoodTypeEnum) goodType {
    cardHand[goodType]++;
	return true;
}

- (bool) playCardofType: (GoodTypeEnum)goodType {
	if (cardHand[goodType] > 0) {
        cardHand[goodType]--;
        return true;
    } else {
        return false;
    }
}

- (bool) addSpecial: (SpecialTypeEnum) specialType {
    specials[specialType]++;
	return true;
}

- (bool) loadGoodToShip: (GoodTypeEnum)goodType atIndex:(NSUInteger)ship {
    DLog(@"good %d, ship %d", goodType, ship);
    ships[ship] = goodType;
	return true;
}

- (int) cardHandCount{
    int sum = 0;
    for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
        sum += cardHand[i];
    }
    return sum;
}


- (void) chooseAGoodType:(id)delegate pool:(Pool*)pool  {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

- (void) chooseToUseAbility: (id)delegate {
}

- (void) chooseSpecialType: (id)delegate {
}

- (void) chooseCardFromHand: (id)delegate {
}

- (void) chooseCardFromMarket: (id)delegate { 
}

- (void) chooseActionForPhase1: (id)delegate {
}

- (void) chooseAShipForAction11: (id)delegate {
}

- (void) chooseActionForPhase2: (id)delegate {
}

@end

#pragma mark - NPC
@implementation NPC
@synthesize AI;

/**
 * @override
 */
- (void) chooseAGoodType:(id)delegate pool:(Pool*)pool  {
    
	//stupid AI start >>>>
	GoodTypeEnum rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * GOOD_TYPE_COUNT);
    } while (pool.token[rnd] <= 0);
    //stupid AI end <<<<

    NSNumber *num = [NSNumber numberWithInt:rnd];
    [delegate performSelectorOnMainThread:@selector(didChooseAGoodType:) withObject:num waitUntilDone:NO];
}

/**
 * @override
 */
- (void) chooseActionForPhase1: (id)delegate {
	//stupid AI start >>>>
	ActionEnum rnd;
    rnd = PHASE1 + (NSInteger) (CCRANDOM_0_1() * 2);
    //stupid AI end <<<<
    
    NSNumber *num = [NSNumber numberWithInt:rnd];
    [delegate performSelectorOnMainThread:@selector(didChooseActionForPhase1:) withObject:num waitUntilDone:NO];
}

- (void) chooseAShipForAction11: (id)delegate {
	//stupid AI start >>>>
	ActionEnum rnd;
    rnd = (NSInteger) (CCRANDOM_0_1() * specials[kSpecialShip]);
    //stupid AI end <<<<
    
    NSNumber *num = [NSNumber numberWithInt:rnd];
    [delegate performSelectorOnMainThread:@selector(didChooseAShip:) withObject:num waitUntilDone:NO];
    
}

/**
 * @override
 */
- (void) chooseActionForPhase2: (id)delegate {
    
}

@end

#pragma mark - Human
@implementation User
/**
 * @override
 */
- (void) chooseAGoodType:(id)delegate pool:(Pool*)pool {
    Dialog *dialog = [Dialog dialogWithGoodCounts:pool.token target:delegate selector:@selector(didChooseAGoodType:)];
    [delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_GOODS];
    
}

/**
 * @override
 */
- (void) chooseToUseAbility: (id)delegate {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Use xxx Ability?" delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil] ;
	as.tag = kDlgUserAbility;
    [as showInView:[[CCDirector sharedDirector] openGLView]]; 
}

/**
 * @override
 */
- (void) chooseSpecialType: (id)delegate {
}

/**
 * @override
 */
- (void) chooseCardFromHand: (id)delegate {
}

/**
 * @override
 */
 - (void) chooseCardFromMarket: (id)delegate {
 }

/**
 * @override
 */
- (void) chooseActionForPhase1: (id)delegate {
    Dialog *dialog = [Dialog dialogWithPhase:PHASE1 target:delegate selector:@selector(didChooseActionForPhase1:)];
    [delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_ACTIONS];
}

- (void) chooseAShipForAction11: (id)delegate {
    //TODO
    //just wait human to tap on board, not using dialog for now
}
/**
 * @override
 */
- (void) chooseActionForPhase2: (id)delegate {
    Dialog *dialog = [Dialog dialogWithPhase:PHASE2 target:delegate selector:@selector(didChooseActionForPhase2:)];
    [delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_ACTIONS];    
}

@end

