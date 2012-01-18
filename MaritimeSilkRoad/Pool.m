//
//  GameBoard.m
//  MaritimeSilkRoad
//
//  Created by MagicStudio on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Pool.h"

@implementation Pool

@synthesize remainingCards;

- (id)init
{
    self = [super init];
    if (self) {
		// shuffle the good deck
		remainingCards = 0;
        for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
			for (int j = 0; j < GOOD_COUNT_PER_TYPE; j++) {
				goodCards[remainingCards++] = i;
			}
        }
		
		for (int i = 0; i < remainingCards; i++) {
			int rnd = (int) (CCRANDOM_0_1() * remainingCards);
			CC_SWAP(goodCards[i], goodCards[rnd]);
		}
        DLog(@"remainingCards %d", remainingCards);
//        for (int i = 0; i< remainingCards; i++)
//            DLog(@"card is type %d", goodCards[i]);

		// prepare special deck
        specialCards[kSpecialShip] = SHIP_COUNT;
        specialCards[kSpecialTrade] = OTHER_SPECIAL_COUNT;
        specialCards[kSpecialWorker] = OTHER_SPECIAL_COUNT;
        specialCards[kSpecialConcession] = OTHER_SPECIAL_COUNT;
		
		//prepare the tokens
		for (int i = 0; i < GOOD_TYPE_COUNT; i++) {
			token[i] = TOKEN_PER_TYPE;
		}
		
    }
    
    return self;
}

- (int*) specialCards {
    return specialCards;
}

- (int*) goodCards {
    return goodCards;
}

- (int*) token {
    return token;
}

- (GoodTypeEnum) fetchAGood {
    if (remainingCards > 0) {
        remainingCards--;
        return goodCards[remainingCards];
    }
    return kGoodNone;
}

- (bool) fetchASpecial: (SpecialTypeEnum) type {
    if (type < SPECIAL_TYPE_COUNT && specialCards[type] > 0) {
        specialCards[type]--;
        return true;
    }
    return false;
}

- (bool) fetchAToken: (GoodTypeEnum) type {
    if (type < GOOD_TYPE_COUNT && token[type] > 0) {
        token[type]--;
        return true;
    }
    return false;
}


@end
