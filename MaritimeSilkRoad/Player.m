//
//  GameBoard.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
//#import "Dialog.h"
#import "Pool.h"

#define Z_MOST_FRONT    1000
#define Z_MOST_BACK     -1000
#define DIALOG_GOODS   	100
#define DIALOG_ACTIONS 	101
#define DIALOG_YESNO	102
#define DIALOG_SHIPS 	103
#define DIALOG_SPECIALS 	104

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
        for (int i = 0; i < SHIP_COUNT; i++) {
            ships[i] = kGoodNone;
        }
	}
    return self;
}

- (id)initWithDelegate:(id) delegate {
    if (self = [super init]) {
        _delegate = delegate;
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

- (bool) playCardOfType: (GoodTypeEnum)goodType {
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

- (void) chooseAGoodTypeFromPool:(Pool*)pool {}

- (void) chooseToUseAbility {}

- (void) chooseSpecialType {}

- (void) chooseCardFromHand {}

- (void) chooseCardFromMarket {}

- (void) chooseActionForPhase1 {}

- (void) chooseAShipForAction11 {}

- (void) chooseASpecialForAction12FromPool:(Pool*)pool {}

- (void) chooseActionForPhase2 {}

@end

#pragma mark - NPC
@implementation NPC
@synthesize AI;

- (void) chooseAGoodTypeFromPool:(Pool*)pool  {
    
	//stupid AI start >>>>
	GoodTypeEnum rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * GOOD_TYPE_COUNT);
    } while (pool.token[rnd] <= 0);
    //stupid AI end <<<<

    NSNumber *num = [NSNumber numberWithInt:rnd];
    [_delegate performSelectorOnMainThread:@selector(didChooseAGoodType:) withObject:num waitUntilDone:NO];
}

- (void) chooseActionForPhase1 {
	//stupid AI start >>>>
	ActionEnum rnd;
    rnd = PHASE1 + (NSInteger) (CCRANDOM_0_1() * 2);
    //stupid AI end <<<<
    
    NSNumber *num = [NSNumber numberWithInt:rnd];
    [_delegate performSelectorOnMainThread:@selector(didChooseActionForPhase1:) withObject:num waitUntilDone:NO];
}

- (void) chooseAShipForAction11 {
	//stupid AI start >>>>
	int rnd;
    rnd = (NSInteger) (CCRANDOM_0_1() * specials[kSpecialShip]);
    //stupid AI end <<<<
    
    NSNumber *num = [NSNumber numberWithInt:rnd];
    [_delegate performSelectorOnMainThread:@selector(didChooseAShip:) withObject:num waitUntilDone:NO];
    
}

- (void) chooseASpecialForAction12FromPool:(Pool*)pool {
    //stupid AI start >>>>
	int rnd;
    do {
        rnd = (NSInteger) (CCRANDOM_0_1() * SPECIAL_TYPE_COUNT);
    } while (pool.specialCards[rnd] <= 0);
    //stupid AI end <<<<
    
    NSNumber *num = [NSNumber numberWithInt:rnd];
    [_delegate performSelectorOnMainThread:@selector(didChooseASpecial:) withObject:num waitUntilDone:NO];
}

- (void) chooseToUseAbility {}

- (void) chooseSpecialType {}

- (void) chooseCardFromHand {}

- (void) chooseCardFromMarket {}

- (void) chooseActionForPhase2 {
}


@end

#pragma mark - Human

@implementation Human

- (void) chooseAGoodTypeFromPool:(Pool *)pool {
//    Dialog *dialog = [Dialog dialogWithGoodCounts:pool.token target:_delegate selector:@selector(didChooseAGoodType:)];
//    [_delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_GOODS];
//    
}

- (void) chooseToUseAbility {
 
}

- (void) chooseSpecialType {
}

- (void) chooseCardFromHand {
}


- (void) chooseCardFromMarket {
}

- (void) chooseActionForPhase1 {
//    Dialog *dialog = [Dialog dialogWithPhase:PHASE1 target:_delegate selector:@selector(didChooseActionForPhase1:)];
//    [_delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_ACTIONS];
}

- (void) chooseAShipForAction11 {
//    Dialog *dialog = [Dialog dialogWithShips:ships count:specials[kSpecialShip] target:_delegate selector:@selector(didChooseAShip:)];
//    [_delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_SHIPS];

}

- (void) chooseASpecialForAction12FromPool:(Pool*)pool {
//    Dialog *dialog = [Dialog dialogWithSpecials:pool.specialCards target:_delegate selector:@selector(didChooseASpecial:)];
//    [_delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_SPECIALS];
}

- (void) chooseActionForPhase2: (id)delegate {
//    Dialog *dialog = [Dialog dialogWithPhase:PHASE2 target:_delegate selector:@selector(didChooseActionForPhase2:)];
//    [_delegate addChild:dialog z:Z_MOST_FRONT tag:DIALOG_ACTIONS];    
}

@end

